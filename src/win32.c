static HWND app_window;
static HDC window_dc;
static BITMAPINFO bmi;
static bool audio_ready;
static HWAVEOUT wave;
static WAVEHDR wave_headers[3];
static int16_t wave_samples[3][735];
static uint32_t audio_phase,audio_phase2,audio_noise=1;

typedef struct {
    uint32_t magic;uint16_t version,checksum;
    uint32_t ending_bits,card_unlock_bits,stage_unlock_bits,challenge_bits;
    uint16_t best_time[8],best_turns[8];
    uint32_t last_daily_seed;
} SaveData;
static SaveData save_data;

static uint16_t save_checksum(const SaveData *source){SaveData copy=*source;copy.checksum=0;const uint8_t *bytes=(const uint8_t*)&copy;uint32_t sum=0;for(size_t i=0;i<sizeof(copy);i++)sum=(sum+bytes[i])&0xffffu;return (uint16_t)sum;}
static void save_path(wchar_t path[MAX_PATH]){DWORD n=GetModuleFileNameW(NULL,path,MAX_PATH);while(n&&path[n-1]!=L'\\')n--;lstrcpyW(path+n,L"ECHO144.SAV");}
static void save_load(void){
    wchar_t path[MAX_PATH];save_path(path);HANDLE file=CreateFileW(path,GENERIC_READ,FILE_SHARE_READ,NULL,OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,NULL);if(file==INVALID_HANDLE_VALUE)return;
    DWORD read=0;SaveData loaded={0};BOOL ok=ReadFile(file,&loaded,sizeof(loaded),&read,NULL);CloseHandle(file);
    if(!ok||read!=sizeof(loaded)||loaded.magic!=0x34313445u||loaded.version!=1||loaded.checksum!=save_checksum(&loaded)){g.save_corrupt=true;return;}save_data=loaded;
}
static void save_write(void){
    save_data.magic=0x34313445u;save_data.version=1;save_data.checksum=save_checksum(&save_data);wchar_t path[MAX_PATH];save_path(path);
    HANDLE file=CreateFileW(path,GENERIC_WRITE,0,NULL,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,NULL);if(file==INVALID_HANDLE_VALUE)return;DWORD written=0;WriteFile(file,&save_data,sizeof(save_data),&written,NULL);CloseHandle(file);
}
static void save_result(void){
    if(g.today)save_data.last_daily_seed=g.seed;
    if(g.won){int ending=g.ending%8;uint16_t seconds=(uint16_t)((OPEN_TICKS-g.open_ticks+59)/60);save_data.ending_bits|=1u<<ending;if(!save_data.best_time[ending]||seconds<save_data.best_time[ending])save_data.best_time[ending]=seconds;if(!save_data.best_turns[ending]||g.turn<save_data.best_turns[ending])save_data.best_turns[ending]=g.turn;}
    save_write();
}

static void audio_fill(WAVEHDR *h){
    int16_t *out=(int16_t*)h->lpData;
    static const int motif[]={330,392,494};int note=g.mode==OPEN_CHANNEL?494:g.echo_archived?motif[2-(g.turn%3)]:motif[g.turn%3];
    uint32_t step=(uint32_t)(note*65536/22050),harmony=(uint32_t)((g.mode==OPEN_CHANNEL?659:note*3/2)*65536/22050);
    for(int i=0;i<735;i++){
        audio_phase+=step;audio_phase2+=harmony;audio_noise=(audio_noise>>1)^((uint32_t)-(int32_t)(audio_noise&1)&0xB400u);
        int v=(audio_phase&0x8000)?260:-260;if(g.sync>=1)v+=(audio_phase2&0x8000)?110:-110;
        if(g.sync>=2)v+=(int)((audio_phase2>>8)&255)-128;if(g.effect_ticks)v+=((audio_phase2&0x4000)?620:-620)+(int)(audio_noise&63)-32;
        if(g.mode==EDIT||g.mode==BREAK)v/=2;if(g.muted)v=0;out[i]=(int16_t)v;
    }
    waveOutWrite(wave,h,sizeof(*h));
}
static void CALLBACK audio_callback(HWAVEOUT w,UINT msg,DWORD_PTR user,DWORD_PTR p1,DWORD_PTR p2){(void)w;(void)user;(void)p2;if(msg==WOM_DONE&&audio_ready)audio_fill((WAVEHDR*)p1);}
static void audio_init(void){
    WAVEFORMATEX f={WAVE_FORMAT_PCM,1,22050,44100,2,16,0};
    if(waveOutOpen(&wave,WAVE_MAPPER,&f,(DWORD_PTR)audio_callback,0,CALLBACK_FUNCTION)!=MMSYSERR_NOERROR)return;
    for(int i=0;i<3;i++){wave_headers[i].lpData=(LPSTR)wave_samples[i];wave_headers[i].dwBufferLength=sizeof(wave_samples[i]);waveOutPrepareHeader(wave,&wave_headers[i],sizeof(WAVEHDR));}
    audio_ready=true;for(int i=0;i<3;i++)audio_fill(&wave_headers[i]);
}
static void audio_shutdown(void){if(!audio_ready)return;audio_ready=false;waveOutReset(wave);for(int i=0;i<3;i++)waveOutUnprepareHeader(wave,&wave_headers[i],sizeof(WAVEHDR));waveOutClose(wave);}

static void present(void){
    RECT r;GetClientRect(app_window,&r);int cw=r.right,ch=r.bottom,scale=cw/SCREEN_W<(ch/SCREEN_H)?cw/SCREEN_W:ch/SCREEN_H;if(scale<1)scale=1;
    int w=SCREEN_W*scale,h=SCREEN_H*scale,x=(cw-w)/2,y=(ch-h)/2;PatBlt(window_dc,0,0,cw,ch,BLACKNESS);
    StretchDIBits(window_dc,x,y,w,h,0,0,SCREEN_W,SCREEN_H,pixels,&bmi,DIB_RGB_COLORS,SRCCOPY);
}

static LRESULT CALLBACK window_proc(HWND hwnd,UINT msg,WPARAM wp,LPARAM lp){
    switch(msg){
    case WM_KEYDOWN:if(wp==VK_F2&&g.mode==TITLE&&!(lp&(1u<<30))){SYSTEMTIME now;GetLocalTime(&now);game_start((uint32_t)now.wYear*10000u+(uint32_t)now.wMonth*100u+now.wDay);g.today=true;return 0;}if(!(lp&(1u<<30)))game_press((int)wp);game_hold((int)wp,true);if(wp==VK_ESCAPE&&g.mode==TITLE)PostQuitMessage(0);return 0;
    case WM_KEYUP:game_hold((int)wp,false);return 0;
    case WM_ERASEBKGND:return 1;
    case WM_DESTROY:PostQuitMessage(0);return 0;
    }return DefWindowProcW(hwnd,msg,wp,lp);
}

static bool init_window(HINSTANCE instance){
    WNDCLASSW wc={0};wc.lpfnWndProc=window_proc;wc.hInstance=instance;wc.lpszClassName=L"ECHO144_V2";wc.hCursor=LoadCursorW(0,IDC_ARROW);if(!RegisterClassW(&wc))return false;
    RECT r={0,0,SCREEN_W*3,SCREEN_H*3};AdjustWindowRect(&r,WS_OVERLAPPEDWINDOW,false);
    app_window=CreateWindowW(wc.lpszClassName,L"에코/144 — 목록 밖 생방송",WS_OVERLAPPEDWINDOW|WS_VISIBLE,CW_USEDEFAULT,CW_USEDEFAULT,r.right-r.left,r.bottom-r.top,0,0,instance,0);if(!app_window)return false;
    window_dc=GetDC(app_window);back_dc=CreateCompatibleDC(window_dc);
    bmi.bmiHeader.biSize=sizeof(BITMAPINFOHEADER);bmi.bmiHeader.biWidth=SCREEN_W;bmi.bmiHeader.biHeight=-SCREEN_H;bmi.bmiHeader.biPlanes=1;bmi.bmiHeader.biBitCount=32;bmi.bmiHeader.biCompression=BI_RGB;
    back_bitmap=CreateDIBSection(back_dc,&bmi,DIB_RGB_COLORS,(void**)&pixels,0,0);SelectObject(back_dc,back_bitmap);
    audio_init();return true;
}
static void shutdown_window(void){audio_shutdown();if(back_bitmap)DeleteObject(back_bitmap);if(back_dc)DeleteDC(back_dc);if(window_dc)ReleaseDC(app_window,window_dc);}

int WINAPI wWinMain(HINSTANCE instance,HINSTANCE previous,PWSTR command,int show){
    (void)previous;(void)command;(void)show;g.mode=TITLE;g.running=true;save_load();if(!init_window(instance))return 1;
    LARGE_INTEGER freq,last,now;QueryPerformanceFrequency(&freq);QueryPerformanceCounter(&last);double accumulator=0.0;MSG msg;
    while(g.running){while(PeekMessageW(&msg,0,0,0,PM_REMOVE)){if(msg.message==WM_QUIT)g.running=false;TranslateMessage(&msg);DispatchMessageW(&msg);}QueryPerformanceCounter(&now);accumulator+=(double)(now.QuadPart-last.QuadPart)/(double)freq.QuadPart;last=now;
        int steps=0;while(accumulator>=1.0/TICK_HZ&&steps++<5){Mode before=g.mode;game_tick();if(before!=RESULT&&g.mode==RESULT)save_result();accumulator-=1.0/TICK_HZ;}render();present();Sleep(1);
    }shutdown_window();return 0;
}
