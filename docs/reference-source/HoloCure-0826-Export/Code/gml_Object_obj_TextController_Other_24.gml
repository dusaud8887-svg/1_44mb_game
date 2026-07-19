var SD = global.SkillData;
var name = "FPSMastery";
var data = variable_struct_get(SD, name);
var valA1 = data.ATK[0] * 100;
var valA2 = data.ATK[1] * 100;
var valA3 = data.ATK[2] * 100;
var valB1 = data.Haste;
CreateToolTip(name, 
{
    eng: "FPS Mastery",
    jp: "FPS마스터리",
    Id: "Penguasaan FPS"
}, 
{
    eng: [string("All weapons deal [c_green]{0}%[/color] more damage.", valA1), string("All weapons deal [c_green]{0}%[/color] more damage.", valA2), string("All weapons deal [c_green]{0}%[/color] more damage and fire {1}% faster.", valA3, valB1)],
    jp: [JPAS(string("무기 공격력이 [c_green]{0}%[/color] 증가한다.", valA1)), JPAS(string("무기 공격력이 [c_green]{0}%[/color] 증가한다.", valA2)), JPAS(string("무기 공격력이 [c_green]{0}%[/color] 증가하고, 무기 공격속도가 {1}% 증가한다.", valA3, valB1))],
    Id: [string("Semua senjata memberi damage [c_green]{0}%[/color] lebih banyak.", valA1), string("Semua senjata memberi damage [c_green]{0}%[/color] lebih banyak.", valA2), string("Semua senjata memberi damage [c_green]{0}%[/color] lebih banyak.", valA3)]
});
name = "DetectiveEye";
data = variable_struct_get(SD, name);
valA1 = data.crit[0];
valA2 = data.crit[1];
valA3 = data.crit[2];
valB1 = data.KO;
CreateToolTip(name, 
{
    eng: "Detective Eye",
    jp: "탐정의 눈",
    Id: "Mata Detektif"
}, 
{
    eng: [string("Increases critical hit chance by [c_green]{0}%[/color].", valA1), string("Increases critical hit chance by [c_green]{0}%[/color].", valA2), string("Increases critical hit chance by [c_green]{0}%[/color] with a [c_green]{1}%[/color] chance to defeat an target in 1 hit.", valA3, valB1)],
    jp: [JPAS(string("치명타율이 [c_green]{0}%[/color] 증가한다.", valA1)), JPAS(string("치명타율이 [c_green]{0}%[/color] 증가한다.", valA2)), JPAS(string("치명타율이 [c_green]{0}%[/color] 증가하고, [c_green]{1}%[/color]확률로 일격에 처치한다.", valA3, valB1))],
    Id: [string("Menambah kemungkinan pukulan kritikal sebesar [c_green]{0}%[/color].", valA1), string("Menambah kemungkinan pukulan kritikal sebesar [c_green]{0}%[/color].", valA2), string("Menambah kemungkinan pukulan kritikal sebesar [c_green]{0}%[/color] dengan [c_green]{1}%[/color] kemungkinan untuk mengalahkan target dalam 1 pukulan.", valA3, valB1)]
});
name = "Bubba";
data = variable_struct_get(SD, name);
valA1 = data.ATK[0] * 100;
valA2 = data.ATK[1] * 100;
valA3 = data.ATK[2] * 100;
valB1 = data.stun / 60;
CreateToolTip(name, 
{
    eng: "Bubba",
    jp: "버바",
    Id: "Bubba"
}, 
{
    eng: [string("Gain a dog companion that attacks random targets, dealing [c_green]{0}%[/color] of your base damage per hit.", valA1), string("Gain a dog companion that attacks random targets, dealing [c_green]{0}%[/color] of your base damage per hit.", valA2), string("Gain a dog companion that attacks random targets, dealing [c_green]{0}%[/color] of your base damage per hit and stuns targets for {1} seconds on hit.", valA3, valB1)],
    jp: [JPAS(string("강아지 버바가 합류하여 임의의 적을 공격력의 [c_green]{0}%[/color]로 공격한다.", valA1)), JPAS(string("강아지 버바가 합류하여 임의의 적을 공격력의 [c_green]{0}%[/color]로 공격한다.", valA2)), JPAS(string("강아지 버바가 합류하여 임의의 적을 공격력의 [c_green]{0}%[/color]로 공격하며 맞은 적은 {1}초간 [c_blue]기절[/color] 상태에 걸린다.", valA3, valB1))],
    Id: ["Dapatkan anjing pendamping yang menyerang target acak, memberi [c_green]100%[/color] dari damage dasar per serangan.", "Dapatkan anjing pendamping yang menyerang target acak, memberi [c_green]200%[/color] dari damage dasar per serangan.", "Dapatkan anjing pendamping yang menyerang target acak, memberi [c_green]300%[/color] dari damage dasar per serangan dan stun target selama 2 detik jika kena."]
});
name = "ShortHeight";
data = variable_struct_get(SD, name);
valA1 = data.dodgeChance[0];
valA2 = data.dodgeChance[1];
valA3 = data.dodgeChance[2];
valB1 = data.SPD[0] * 100;
var valB2 = data.SPD[1] * 100;
var valB3 = data.SPD[2] * 100;
var valC1 = 0.5;
CreateToolTip(name, 
{
    eng: "Short Height",
    jp: "꼬맹이",
    Id: "Pendek"
}, 
{
    eng: [string("Grants a [c_green]{0}%[/color] chance to dodge an attack. After dodging, increase movement speed by [c_green]{1}%[/color] and stay invulnerable for {2} second.", valA1, valB1, valC1), string("Grants a [c_green]{0}%[/color] chance to dodge an attack. After dodging, increase movement speed by [c_green]{1}%[/color] and stay invulnerable for {2} second.", valA2, valB2, valC1), string("Grants a [c_green]{0}%[/color] chance to dodge an attack. After dodging, increase movement speed by [c_green]{1}%[/color] and stay invulnerable for {2} seconds.", valA3, valB3, valC1)],
    jp: [JPAS(string("[c_green]{0}%[/color]의 확률로 공격을 회피한다. 회피한 후에 {2}초간 이동속도가 [c_green]{1}%[/color] 상승하고 무적상태가 된다.", valA1, valB1, valC1)), JPAS(string("[c_green]{0}%[/color]의 확률로 공격을 회피한다. 회피한 후에 {2}초간 이동속도가 [c_green]{1}%[/color] 상승하고 무적상태가 된다.", valA2, valB2, valC1)), JPAS(string("[c_green]{0}%[/color]의 확률로 공격을 회피한다. 회피한 후에 {2}초간 이동속도가 [c_green]{1}%[/color] 상승하고 무적상태가 된다.", valA3, valB3, valC1))],
    Id: [string("Memberikan [c_green]{0}%[/color] peluang untuk menghindari serangan. Setelah menghindar, meningkatkan kecepatan gerakan sebesar [c_green]{1}%[/color] dan menjadi kebal selama {2} detik.", valA1, valB1, valC1), string("Memberikan [c_green]{0}%[/color] peluang untuk menghindari serangan. Setelah menghindar, meningkatkan kecepatan gerakan sebesar [c_green]{1}%[/color] dan menjadi kebal selama {2} detik.", valA2, valB2, valC1), string("Memberikan [c_green]{0}%[/color] peluang untuk menghindari serangan. Setelah menghindar, meningkatkan kecepatan gerakan sebesar [c_green]{1}%[/color] dan menjadi kebal selama {2} detik.", valA3, valB3, valC1)]
});
name = "PowerOfAtlantis";
data = variable_struct_get(SD, name);
valA1 = 15;
valA2 = 30;
valA3 = 45;
valB1 = 30;
valB2 = 40;
valB3 = 50;
valC1 = 10;
var valD1 = 6;
var valE1 = 0.5;
CreateToolTip(name, 
{
    eng: "Power of Atlantis",
    jp: "아틀란티스의 힘",
    Id: "Kekuatan Atlantis"
}, 
{
    eng: [string("Every {0} seconds, create a whirlpool that draws in targets and takes [c_green]{1}%[/color] more damage, lasting {2} seconds and deals [c_green]{3}%[/color] damage every 0.5 seconds.", valC1, valA1, valD1, valB1), string("Every {0} seconds, create a whirlpool that draws in targets and takes [c_green]{1}%[/color] more damage, lasting {2} seconds and deals [c_green]{3}%[/color] damage every 0.5 seconds.", valC1, valA2, valD1, valB2), string("Every {0} seconds, create a whirlpool that draws in targets and takes [c_green]{1}%[/color] more damage, lasting {2} seconds and deals [c_green]{3}%[/color] damage every 0.5 seconds.", valC1, valA3, valD1, valB3)],
    jp: [JPAS(string("{0}초마다 소용돌이를 만들어 적들을 빨아들이고, 적이 받는 피해량이 [c_green]{1}%[/color] 증가하고 0.5초마다 [c_green]{3}%[/color]의 피해를 준다(지속시간 {2}초).", valC1, valA1, valD1, valB1)), JPAS(string("{0}초마다 소용돌이를 만들어 적들을 빨아들이고, 적이 받는 피해량이 [c_green]{1}%[/color] 증가하고 0.5초마다 [c_green]{3}%[/color]의 피해를 준다(지속시간 {2}초).", valC1, valA2, valD1, valB2)), JPAS(string("{0}초마다 소용돌이를 만들어 적들을 빨아들이고, 적이 받는 피해량이 [c_green]{1}%[/color] 증가하고 0.5초마다 [c_green]{3}%[/color]의 피해를 준다(지속시간 {2}초).", valC1, valA3, valD1, valB3))],
    Id: [string("Setiap {0} detik, membuat pusaran air yang menarik target dan memberikan [c_green]{1}%[/color] damage lebih selama {2} detik dan memberi [c_green]{3}%[/color] damage setiap 0.5 detik.", valC1, valA1, valD1, valB1), string("Setiap {0} detik, membuat pusaran air yang menarik target dan memberikan [c_green]{1}%[/color] damage lebih selama {2} detik dan memberi [c_green]{3}%[/color] damage setiap 0.5 detik.", valC1, valA2, valD1, valB2), string("Setiap {0} detik, membuat pusaran air yang menarik target dan memberikan [c_green]{1}%[/color] damage lebih selama {2} detik dan memberi [c_green]{3}%[/color] damage setiap 0.5 detik.", valC1, valA3, valD1, valB3)]
});
name = "SharkBite";
data = variable_struct_get(SD, name);
valA1 = data.chance[0];
valA2 = data.chance[1];
valA3 = data.chance[2];
valB1 = data.vuln[0];
valB2 = data.vuln[1];
valB3 = data.vuln[2];
valC1 = 20;
valD1 = 1;
CreateToolTip(name, 
{
    eng: "Shark Bite",
    jp: "샤크 바이트",
    Id: "Gigitan Hiu"
}, 
{
    eng: [string("Attacks have a [c_green]{0}%[/color] chance to place 1 [c_blue]Bite Mark[/color] (max 5), where targets take [c_green]{1}%[/color] more damage, and have a {2}% chance to heal you {3}% when defeated.", valA1, valB1, valC1, valD1), string("Attacks have a [c_green]{0}%[/color] chance to place 1 [c_blue]Bite Mark[/color] (max 5), where targets take [c_green]{1}%[/color] more damage, and have a {2}% chance to heal you {3}% when defeated.", valA2, valB2, valC1, valD1), string("Attacks have a [c_green]{0}%[/color] chance to place 1 [c_blue]Bite Mark[/color] (max 5), where targets take [c_green]{1}%[/color] more damage, and have a {2}% chance to heal you {3}% when defeated.", valA3, valB3, valC1, valD1)],
    jp: [JPAS(string("공격 시 [c_green]{0}%[/color] 확률로[c_blue]「상흔」[/color]을 하나 남긴다. 「상흔」: [c_green]{1}%[/color]의 피해량 증가하고, 처치 시 {2}% 확률로 체력의 {3}%를 회복한다.", valA1, valB1, valC1, valD1)), JPAS(string("공격 시 [c_green]{0}%[/color] 확률로[c_blue]「상흔」[/color]을 하나 남긴다. 「상흔」: [c_green]{1}%[/color]의 피해량 증가하고, 처치 시 {2}% 확률로 체력의 {3}%를 회복한다.", valA2, valB2, valC1, valD1)), JPAS(string("공격 시 [c_green]{0}%[/color] 확률로[c_blue]「상흔」[/color]을 하나 남긴다. 「상흔」: [c_green]{1}%[/color]의 피해량 증가하고, 처치 시 {2}% 확률로 체력의 {3}%를 회복한다.", valA3, valB3, valC1, valD1))],
    Id: [[string("Serangan memiliki peluang [c_green]{0}%[/color] untuk menempatkan 1 [c_blue]Bite Mark[/color] (maksimal 5), di mana target menerima [c_green]{1}%[/color] lebih banyak damage, dan memiliki peluang {2}%", valA1, valB1, valC1), string("untuk memulihkan Anda {0}% ketika dikalahkan.", valD1)], [string("Serangan memiliki peluang [c_green]{0}%[/color] untuk menempatkan 1 [c_blue]Bite Mark[/color] (maksimal 5), di mana target menerima [c_green]{1}%[/color] lebih banyak damage, dan memiliki peluang {2}%", valA2, valB2, valC1), string("untuk memulihkan Anda {0}% ketika dikalahkan.", valD1)], [string("Serangan memiliki peluang [c_green]{0}%[/color] untuk menempatkan 1 [c_blue]Bite Mark[/color] (maksimal 5), di mana target menerima [c_green]{1}%[/color] lebih banyak damage, dan memiliki peluang {2}%", valA3, valB3, valC1), string("untuk memulihkan Anda {0}% ketika dikalahkan.", valD1)]]
});
name = "Death";
data = variable_struct_get(SD, name);
valA1 = data.chance[0];
valA2 = data.chance[1];
valA3 = data.chance[2];
valB1 = data.damage[0] * 100;
valB2 = data.damage[1] * 100;
valB3 = data.damage[2] * 100;
valC1 = data.deathChance[0];
var valC2 = data.deathChance[1];
var valC3 = data.deathChance[2];
CreateToolTip(name, 
{
    eng: "Death",
    jp: "사신",
    Id: "Kematian"
}, 
{
    eng: [string("When defeating a target with [c_yellow]Scythe Swing[/color] or [c_yellow]Death[/color], there is a [c_green]{0}%[/color] chance to create an explosion for [c_green]{1}%[/color] damage, and a [c_green]{2}%[/color] chance to KO.", valA1, valB1, valC1), string("When defeating a target with [c_yellow]Scythe Swing[/color] or [c_yellow]Death[/color], there is a [c_green]{0}%[/color] chance to create an explosion for [c_green]{1}%[/color] damage, and a [c_green]{2}%[/color] chance to KO.", valA2, valB2, valC2), string("When defeating a target with [c_yellow]Scythe Swing[/color] or [c_yellow]Death[/color], there is a [c_green]{0}%[/color] chance to create an explosion for [c_green]{1}%[/color] damage, and a [c_green]{2}%[/color] chance to KO.", valA3, valB3, valC3)],
    jp: [JPAS(string("[c_yellow]대낫 휘두르기[/color]나[c_yellow]사신[/color]의 능력으로 처치 시 [c_green]{0}%[/color]의 확률로 [c_green]{1}%[/color] 피해의 폭발이 일어나고 [c_green]{2}%[/color] 확률로 적을 K.O.시킨다.", valA1, valB1, valC1)), JPAS(string("[c_yellow]대낫 휘두르기[/color]나[c_yellow]사신[/color]의 능력으로 처치 시 [c_green]{0}%[/color]의 확률로 [c_green]{1}%[/color] 피해의 폭발이 일어나고 [c_green]{2}%[/color] 확률로 적을 K.O.시킨다.", valA2, valB2, valC2)), JPAS(string("[c_yellow]대낫 휘두르기[/color]나[c_yellow]사신[/color]의 능력으로 처치 시 [c_green]{0}%[/color]의 확률로 [c_green]{1}%[/color] 피해의 폭발이 일어나고 [c_green]{2}%[/color] 확률로 적을 K.O.시킨다.", valA3, valB3, valC3))],
    Id: [[string("Ketika mengalahkan target dengan [c_yellow]Ayunan Sabit Besar[/color] atau [c_yellow]Kematian[/color], ada peluang [c_green]{0}%[/color] untuk menciptakan ledakan yang memberi [c_green]{1}%[/color] damage,", valA1, valB1), string("dan [c_green]{0}%[/color] kemungkinan untuk KO.", valC1)], [string("Ketika mengalahkan target dengan [c_yellow]Ayunan Sabit Besar[/color] atau [c_yellow]Kematian[/color], ada peluang [c_green]{0}%[/color] untuk menciptakan ledakan yang memberi [c_green]{1}%[/color] damage,", valA2, valB2), string("dan [c_green]{0}%[/color] kemungkinan untuk KO.", valC2)], [string("Ketika mengalahkan target dengan [c_yellow]Ayunan Sabit Besar[/color] atau [c_yellow]Kematian[/color], ada peluang [c_green]{0}%[/color] untuk menciptakan ledakan yang memberi [c_green]{1}%[/color] damage,", valA3, valB3), string("dan [c_green]{0}%[/color] kemungkinan untuk KO.", valC3)]]
});
name = "TheRapper";
data = variable_struct_get(SD, name);
valA1 = data.distance[0];
valA2 = data.distance[1];
valA3 = data.distance[2];
valB1 = data.amount[0];
valB2 = data.amount[1];
valB3 = data.amount[2];
valC1 = data.crit;
CreateToolTip(name, 
{
    eng: "The Rapper",
    jp: "래퍼",
    Id: "Sang Rapper"
}, 
{
    eng: [string("Targets within [c_green]{0}px[/color] take [c_green]{1}%[/color] extra damage.", valA1, valB1), string("Targets within [c_green]{0}px[/color] take [c_green]{1}%[/color] extra damage.", valA2, valB2), string("Targets within [c_green]{0}px[/color] take [c_green]{1}%[/color] extra damage and an additional {2}% of being a critical hit.", valA3, valB3, valC1)],
    jp: [JPAS(string("[c_green]{0}[/color]px 이내의 적에게 [c_green]{1}%[/color]의 추가 피해를 준다.", valA1, valB1)), JPAS(string("[c_green]{0}[/color]px 이내의 적에게 [c_green]{1}%[/color]의 추가 피해를 준다.", valA2, valB2)), JPAS(string("[c_green]{0}[/color]px 이내의 적에게 [c_green]{1}%[/color]의 추가 피해를 주고, 치명타율이 {2}% 증가한다.", valA3, valB3, valC1))],
    Id: [string("Target dalam jarak [c_green]{0}px[/color] menerima [c_green]{1}%[/color] damage ekstra.", valA1, valB1), string("Target dalam jarak [c_green]{0}px[/color] menerima [c_green]{1}%[/color] damage ekstra.", valA2, valB2), string("Target dalam jarak [c_green]{0}px[/color] menerima [c_green]{1}%[/color] damage ekstra dan tambahan {2}% menjadi critical hit.", valA3, valB3, valC1)]
});
name = "Workaholic";
data = variable_struct_get(SD, name);
valA1 = data.ATK[0] * 100;
valA2 = data.ATK[1] * 100;
valA3 = data.ATK[2] * 100;
valB1 = 5;
valC1 = data.SPD * 100;
CreateToolTip(name, 
{
    eng: "Workaholic",
    jp: "워커 홀릭",
    Id: ""
}, 
{
    eng: [string("For each target defeated, increase ATK by [c_green]{0}%[/color] for {1} seconds up to [c_green]{2}%[/color]. Refreshes duration on each target defeat.", valA1, valC1, valA1 * 20), string("For each target defeated, increase ATK by [c_green]{0}%[/color] for {1} seconds up to [c_green]{2}%[/color]. Refreshes duration on each target defeat.", valA2, valC1, valA2 * 20), string("For each target defeated, increase ATK by [c_green]{0}%[/color] for {1} seconds up to [c_green]{2}%[/color], and SPD by {3}% up to {4}%. Refreshes duration on each target defeat.", valA3, valC1, valA3 * 20, valC1, valC1 * 20)],
    jp: [JPAS(string("적을 처치시 {0}초간 피해량이 [c_green]{2}%[/color] 증가하고 최대 [c_green]{1}%[/color]까지 증가한다. (적 처치 시 시간 초기화)", valC1, valA1 * 20, valA1)), JPAS(string("적을 처치시 {0}초간 피해량이 [c_green]{2}%[/color] 증가하고 최대 [c_green]{1}%[/color]까지 증가한다. (적 처치 시 시간 초기화)", valC1, valA2 * 20, valA2)), JPAS(string("적을 처치시 {0}초간 피해량이 [c_green]{2}%[/color] 증가하고 이동속도가 [c_green]{4}%[/color] 증가한다. 각각 최대 [c_green]{1}%[/color], [c_green]{3}%[/color]까지 증가한다. (적 처치 시 시간 초기화)", valC1, valA3 * 20, valA3, valC1 * 20, valC1))],
    Id: [[string("Untuk setiap target yang dikalahkan, meningkatkan ATK sebesar [c_green]{0}%[/color] selama {1} detik hingga [c_green]{2}%[/color]. Me-refresh durasi untuk setiap target yang", valA1, valC1, valA1 * 20), "dikalahkan."], [string("Untuk setiap target yang dikalahkan, meningkatkan ATK sebesar [c_green]{0}%[/color] selama {1} detik hingga [c_green]{2}%[/color]. Me-refresh durasi untuk setiap target yang", valA2, valC1, valA2 * 20), "dikalahkan."], [string("Untuk setiap target yang dikalahkan, tingkatkan ATK sebesar [c_green]{0}%[/color] selama {1} detik hingga [c_green]{2}%[/color], dan SPD sebesar {3}%% hingga {4}%. Me-refresh durasi untuk", valA3, valC1, valA3 * 20, valC1, valC1 * 20), "setiap target yang dikalahkan."]]
});
name = "TheVoid";
data = variable_struct_get(SD, name);
valA1 = data.distance[0];
valA2 = data.distance[1];
valA3 = data.distance[2];
valB1 = data.SPD[0] * 100;
valB2 = data.SPD[1] * 100;
valB3 = data.SPD[2] * 100;
valC1 = data.damage[0] * 100;
valC2 = data.damage[1] * 100;
valC3 = data.damage[2] * 100;
CreateToolTip(name, 
{
    eng: "The Void",
    jp: "공허",
    Id: "The Void"
}, 
{
    eng: [[string("Targets within [c_green]{0}px[/color] moves slower by [c_green]{1}%[/color] and takes [c_green]{2}%[/color] damage every second. If the target has less than 20% HP, there is a 20% chance to be converted", valA1, valB1, valC1), "into a Harmless Takodachi."], [string("Targets within [c_green]{0}px[/color] moves slower by [c_green]{1}%[/color] and takes [c_green]{2}%[/color] damage every second. If the target has less than 20% HP, there is a 20% chance to be converted", valA2, valB2, valC2), "into a Harmless Takodachi."], [string("Targets within [c_green]{0}px[/color] moves slower by [c_green]{1}%[/color] and takes [c_green]{2}%[/color] damage every second. If the target has less than 20% HP, there is a 20% chance to be converted", valA3, valB3, valC3), "into a Harmless Takodachi."]],
    jp: [[JPAS(string("[c_green]{0}px[/color] 내의 적의 이동속도를 [c_green]{1}%[/color]감소시키고, 매 초마다 [c_green]{2}%[/color]의 피해를 준다.대상의 체력이 20% 아래일 경우, 20%의 확률로 대상을 무해한 타코다치로 변이시킨다.", valA1, valB1, valC1)), "てしまう。"], [JPAS(string("[c_green]{0}px[/color] 내의 적의 이동속도를 [c_green]{1}%[/color]감소시키고, 매 초마다 [c_green]{2}%[/color]의 피해를 준다.대상의 체력이 20% 아래일 경우, 20%의 확률로 대상을 무해한 타코다치로 변이시킨다.", valA2, valB2, valC2)), "てしまう。"], [JPAS(string("[c_green]{0}px[/color] 내의 적의 이동속도를 [c_green]{1}%[/color]감소시키고, 매 초마다 [c_green]{2}%[/color]의 피해를 준다.대상의 체력이 20% 아래일 경우, 20%의 확률로 대상을 무해한 타코다치로 변이시킨다.", valA3, valB3, valC3)), "てしまう。"]],
    Id: [[string("Target dalam jarak [c_green]{0}px[/color] bergerak lebih lambat sebesar [c_green]{1}%[/color] dan menerima [c_green]{2}%[/color] damage setiap detiknya. Jika target memiliki kurang dari 20% HP,", valA1, valB1, valC1), "ada peluang 20% untuk berubah menjadi Takodachi Tidak Berbahaya."], [string("Target dalam jarak [c_green]{0}px[/color] bergerak lebih lambat sebesar [c_green]{1}%[/color] dan menerima [c_green]{2}%[/color] damage setiap detiknya. Jika target memiliki kurang dari 20% HP,", valA2, valB2, valC2), "ada peluang 20% untuk berubah menjadi Takodachi Tidak Berbahaya."], [string("Target dalam jarak [c_green]{0}px[/color] bergerak lebih lambat sebesar [c_green]{1}%[/color] dan menerima [c_green]{2}%[/color] damage setiap detiknya. Jika target memiliki kurang dari 20% HP,", valA3, valB3, valC3), "ada peluang 20% untuk berubah menjadi Takodachi Tidak Berbahaya."]]
});
name = "Cult";
data = variable_struct_get(SD, name);
valA1 = data.multiplier[0];
valA2 = data.multiplier[1];
valA3 = data.multiplier[2];
CreateToolTip(name, 
{
    eng: "The Forbidden Wah",
    jp: "금지된WAH",
    Id: "Wah Terlarang"
}, 
{
    eng: [string("If any attack hits more than 4 times or 4 targets, every 4th hit will deal [c_green]{0}x[/color] damage.", valA1), string("If any attack hits more than 4 times or 4 targets, every 4th hit will deal [c_green]{0}x[/color] damage.", valA2), string("If any attack hits more than 4 times or 4 targets, every 4th hit will deal [c_green]{0}x[/color] damage.", valA3)],
    jp: [JPAS(string("한 공격이 4회 또는 4명 이상 타격하면, 매 4번째 공격은 [c_green]{0}배[/color]가 된다.", valA1)), JPAS(string("한 공격이 4회 또는 4명 이상 타격하면, 매 4번째 공격은 [c_green]{0}배[/color]가 된다.", valA2)), JPAS(string("한 공격이 4회 또는 4명 이상 타격하면, 매 4번째 공격은 [c_green]{0}배[/color]가 된다.", valA3))],
    Id: [string("Jika ada serangan yang memukul lebih dari 4 kali atau 4 target, setiap 4 pukulan akan memberi [c_green]{0}x[/color] damage.", valA1), string("Jika ada serangan yang memukul lebih dari 4 kali atau 4 target, setiap 4 pukulan akan memberi [c_green]{0}x[/color] damage.", valA2), string("Jika ada serangan yang memukul lebih dari 4 kali atau 4 target, setiap 4 pukulan akan memberi [c_green]{0}x[/color] damage.", valA3)]
});
name = "TheAncientOne";
data = variable_struct_get(SD, name);
valA1 = data.chance[0];
valA2 = data.chance[1];
valA3 = data.chance[2];
CreateToolTip(name, 
{
    eng: "The Ancient One",
    jp: "고대의 존재",
    Id: "The Ancient One"
}, 
{
    eng: [[string("Summon AO. Every 5 seconds, create a zone with a [c_green]{0}%[/color] chance to convert targets to Harmless Takodachis. Harmless Takodachis can stack with", valA1), "other Harmless Takodachis. Touching a Harmless Takodachi will heal for 1HP per stack and deal damage based on its size."], [string("Summon AO. Every 5 seconds, create a zone with a [c_green]{0}%[/color] chance to convert targets to Harmless Takodachis. Harmless Takodachis can stack with", valA2), "other Harmless Takodachis. Touching a Harmless Takodachi will heal for 1HP per stack and deal damage based on its size."], [string("Summon AO. Every 5 seconds, create a zone with a [c_green]{0}%[/color] chance to convert targets to Harmless Takodachis. Harmless Takodachis can stack with", valA3), "other Harmless Takodachis. Touching a Harmless Takodachi will heal for 1HP per stack and deal damage based on its size."]],
    jp: [[JPAS(string("고대의 존재를 소환한다. 5초마다 [c_green]{0}%[/color]의 확률로 무해한 타코다치로 변이시키는 마법진을 생성한다. 무해한 타코다치는 서로에게 붙어 스택을 축적시킬 수 있다. ", valA1)), "무해한 타코다치에게 피격 시 스택 당 1의 체력을 회복하며, 크기에 따라 피해량이 달라집니다."], [JPAS(string("고대의 존재를 소환한다. 5초마다 [c_green]{0}%[/color]의 확률로 무해한 타코다치로 변이시키는 마법진을 생성한다. 무해한 타코다치는 서로에게 붙어 스택을 축적시킬 수 있다. ", valA2)), "무해한 타코다치에게 피격 시 스택 당 1의 체력을 회복하며, 크기에 따라 피해량이 달라집니다."], [JPAS(string("고대의 존재를 소환한다. 5초마다 [c_green]{0}%[/color]의 확률로 무해한 타코다치로 변이시키는 마법진을 생성한다. 무해한 타코다치는 서로에게 붙어 스택을 축적시킬 수 있다. ", valA3)), "무해한 타코다치에게 피격 시 스택 당 1의 체력을 회복하며, 크기에 따라 피해량이 달라집니다."]],
    Id: [[string("Memanggil AO. Setiap 5 detik, buat zona dengan peluang [c_green]{0}%[/color] untuk mengubah target menjadi Takodachi yang tidak berbahaya. Takodachi yang", valA1), "tidak berbahaya dapat di-stack dengan Takodachi yang tidak berbahaya lainnya. Menyentuh Takodachi yang tidak berbahaya akan menyembuhkan 1HP per", "stack dan memberikan damage ke target berdasarkan ukurannya."], [string("Memanggil AO. Setiap 5 detik, buat zona dengan peluang [c_green]{0}%[/color] untuk mengubah target menjadi Takodachi yang tidak berbahaya. Takodachi yang", valA2), "tidak berbahaya dapat di-stack dengan Takodachi yang tidak berbahaya lainnya. Menyentuh Takodachi yang tidak berbahaya akan menyembuhkan 1HP per", "stack dan memberikan damage ke target berdasarkan ukurannya."], [string("Memanggil AO. Setiap 5 detik, buat zona dengan peluang [c_green]{0}%[/color] untuk mengubah target menjadi Takodachi yang tidak berbahaya. Takodachi yang", valA3), "tidak berbahaya dapat di-stack dengan Takodachi yang tidak berbahaya lainnya. Menyentuh Takodachi yang tidak berbahaya akan menyembuhkan 1HP per", "stack dan memberikan damage ke target berdasarkan ukurannya."]]
});
name = "Trailblazer";
data = variable_struct_get(SD, name);
valA1 = data.SPD[0] * 100;
valA2 = data.SPD[1] * 100;
valA3 = data.SPD[2] * 100;
valB1 = data.damage[0] * 100;
valB2 = data.damage[1] * 100;
valB3 = data.damage[2] * 100;
CreateToolTip(name, 
{
    eng: "Trailblazer",
    jp: "불길",
    Id: "Trailblazer"
}, 
{
    eng: [string("Increase SPD by [c_green]{0}%[/color]. Leave a burning fire underneath Kiara whenever she moves that deals [c_green]{1}%[/color] damage per hit. Lasts 5 seconds.", valA1, valB1), string("Increase SPD by [c_green]{0}%[/color]. Leave a burning fire underneath Kiara whenever she moves that deals [c_green]{1}%[/color] damage per hit. Lasts 5 seconds.", valA2, valB2), [string("Increase SPD by [c_green]{0}%[/color]. Leave a burning fire underneath Kiara whenever she moves that deals [c_green]{1}%[/color] damage per hit. Lasts 5 seconds. Also slows", valA3, valB3), "targets for 3 seconds."]],
    jp: [JPAS(string("이동속도가 [c_green]{0}%[/color]증가한다. 키아라가 이동하는 경로마다 [c_green]{1}%[/color]의 피해를 주는 화염을 남긴다. (화염 지속시간:5초)", valA1, valB1)), JPAS(string("이동속도가 [c_green]{0}%[/color]증가한다. 키아라가 이동하는 경로마다 [c_green]{1}%[/color]의 피해를 주는 화염을 남긴다. (화염 지속시간:5초)", valA2, valB2)), JPAS(string("이동속도가 [c_green]{0}%[/color]증가한다. 키아라가 이동하는 경로마다 [c_green]{1}%[/color]의 피해를 주고 이동속도 3초간 감소시키는 화염을 남긴다. (화염 지속시간:5초) ", valA3, valB3))],
    Id: [[string("Meningkatkan SPD sebesar [c_green]{0}%[/color]. Meninggalkan api yang membara di bawah Kiara setiap kali dia bergerak yang menghasilkan damage [c_green]{1}%[/color] per hit.", valA1, valB1), "Berlangsung selama 5 detik."], [string("Meningkatkan SPD sebesar [c_green]{0}%[/color]. Meninggalkan api yang membara di bawah Kiara setiap kali dia bergerak yang menghasilkan damage [c_green]{1}%[/color] per hit.", valA2, valB2), "Berlangsung selama 5 detik."], [string("Meningkatkan SPD sebesar [c_green]{0}%[/color]. Meninggalkan api yang membara di bawah Kiara setiap kali dia bergerak yang menghasilkan damage [c_green]{1}%[/color] per hit.", valA3, valB3), "Berlangsung selama 5 detik. Juga memperlambat target selama 3 detik."]]
});
name = "Dancer";
data = variable_struct_get(SD, name);
valA1 = data.ATK[0] * 100;
valA2 = data.ATK[1] * 100;
valA3 = data.ATK[2] * 100;
CreateToolTip(name, 
{
    eng: "Dancer",
    jp: "댄서",
    Id: "Penari"
}, 
{
    eng: [string("Moving gradually heals 5% HP per 5 seconds and increases ATK by [c_green]{0}%[/color] every second, up to [c_green]{1}%[/color]. If stopped, buff will slowly decrease.", valA1, valA1 * 20), string("Moving gradually heals 5% HP per 5 seconds and increases ATK by [c_green]{0}%[/color] every second, up to [c_green]{1}%[/color]. If stopped, buff will slowly decrease.", valA2, valA2 * 20), [string("Moving gradually heals 5% HP per 5 seconds and increases ATK by [c_green]{0}%[/color] every second, up to [c_green]{1}%[/color]. Also increase critical hit chance by 1% per", valA3, valA3 * 20), "stack. If stopped, buff will slowly decrease."]],
    jp: [JPAS(string("움직일 때마다 5초마다 체력의 5%의 체력을 회복하고, 초 당[c_green]{0}%[/color]씩 공격력이 증가한다. 움직이지 않으면 효과는 서서히 감소한다.(최대 [c_green]{1}%[/color])", valA1, valA1 * 20)), JPAS(string("움직일 때마다 5초마다 체력의 5%의 체력을 회복하고, 초 당[c_green]{0}%[/color]씩 공격력이 증가한다. 움직이지 않으면 효과는 서서히 감소한다.(최대 [c_green]{1}%[/color])", valA2, valA2 * 20)), JPAS(string("움직일 때마다 5초마다 체력의 5%의 체력을 회복하고, 초 당[c_green]{0}%[/color]씩 공격력이 증가한다. 움직이지 않으면 효과는 서서히 감소한다.(최대 [c_green]{1}%[/color])", valA3, valA3 * 20))],
    Id: [[string("Bergerak akan perlahan lahan menyembuhkan 5% HP per 5 detik dan menambah ATK sebesar [c_green]{0}%[/color] setiap detik, sampai dengan [c_green]{1}%[/color]. Jika terhentikan, buff", valA1, valA1 * 20), "akan pelan pelan menurun."], [string("Bergerak akan perlahan lahan menyembuhkan 5% HP per 5 detik dan menambah ATK sebesar [c_green]{0}%[/color] setiap detik, sampai dengan [c_green]{1}%[/color]. Jika terhentikan, buff", valA2, valA2 * 20), "akan pelan pelan menurun."], [string("Bergerak akan perlahan lahan menyembuhkan 5% HP per 5 detik dan menambah ATK sebesar [c_green]{0}%[/color] setiap detik, sampai dengan [c_green]{1}%[/color]. Juga menambah peluang", valA3, valA3 * 20), "pukulan kritikal sebesar 1% per stack. Jika terhentikan, buff akan pelan pelan menurun."]]
});
name = "PhoenixShield";
data = variable_struct_get(SD, name);
valA1 = data.stack[0];
valA2 = data.stack[1];
valA3 = data.stack[2];
CreateToolTip(name, 
{
    eng: "Phoenix Shield",
    jp: "불사조의 방패",
    Id: "Perisai Phoenix"
}, 
{
    eng: [string("Every 10 seconds gain [c_green]{0}[/color] stack of Phoenix Shield. The next damage taken is halved and become invulnerable for 0.25 seconds.", valA1), string("Every 10 seconds gain [c_green]{0}[/color] stacks of Phoenix Shield. The next two hits taken is halved and become invulnerable for 0.25 seconds.", valA2), string("Every 10 seconds gain [c_green]{0}[/color] stacks of Phoenix Shield. The next three hits taken is halved and become invulnerable for 0.25 seconds.", valA3)],
    jp: [JPAS(string("10초마다 피닉스 쉴드를 [c_green]{0}[/color]스택 획득한다. 적에게 피해를 입을 시 입은 데미지를 반으로 줄이고 0.25초간 무적상태가 된다.", valA1)), JPAS(string("10초마다 피닉스 쉴드를 [c_green]{0}[/color]스택 획득한다. 적에게 피해를 입을 시 입은 데미지를 반으로 줄이고 0.25초간 무적상태가 된다.", valA2)), JPAS(string("10초마다 피닉스 쉴드를 [c_green]{0}[/color]스택 획득한다. 적에게 피해를 입을 시 입은 데미지를 반으로 줄이고 0.25초간 무적상태가 된다.", valA3))],
    Id: [[string("Setiap 10 detik, mendapatkan [c_green]{0}[/color] stack Perisai Phoenix. Damage berikutnya yang diterima akan berkurang setengahnya dan menjadi kebal selama", valA1), "0.25 detik."], [string("Setiap 10 detik, mendapatkan [c_green]{0}[/color] stack Perisai Phoenix. Damage berikutnya yang diterima akan berkurang setengahnya dan menjadi kebal selama", valA2), "0.25 detik."], [string("Setiap 10 detik, mendapatkan [c_green]{0}[/color] stack Perisai Phoenix. Damage berikutnya yang diterima akan berkurang setengahnya dan menjadi kebal selama", valA3), "0.25 detik."]]
});
name = "HalfAngel";
data = variable_struct_get(SD, name);
valA1 = data.chance[0];
valA2 = data.chance[1];
valA3 = data.chance[2];
valB1 = data.heal[0];
valB2 = data.heal[1];
valB3 = data.heal[2];
CreateToolTip(name, 
{
    eng: "Half Angel",
    jp: "하프 엔젤",
    Id: "Setengah Malaikat"
}, 
{
    eng: [string("When landing a critical hit on a target, there is a [c_green]{0}%[/color] chance to heal [c_green]{1}[/color] HP. There is a 0.3 second cooldown between each heal.", valA1, valB1), string("When landing a critical hit on a target, there is a [c_green]{0}%[/color] chance to heal [c_green]{1}[/color] HP. There is a 0.3 second cooldown between each heal.", valA2, valB2), string("When landing a critical hit on a target, there is a [c_green]{0}%[/color] chance to heal [c_green]{1}[/color] HP. There is a 0.3 second cooldown between each heal.", valA3, valB3)],
    jp: [JPAS(string("치명타 발동 시 [c_green]{0}%[/color] 확률로 체력을 [c_green]{1}[/color] 회복한다. (쿨타임 0.3초)", valA1, valB1)), JPAS(string("치명타 발동 시 [c_green]{0}%[/color] 확률로 체력을 [c_green]{1}[/color] 회복한다. (쿨타임 0.3초)", valA2, valB2)), JPAS(string("치명타 발동 시 [c_green]{0}%[/color] 확률로 체력을 [c_green]{1}[/color] 회복한다. (쿨타임 0.3초)", valA3, valB3))],
    Id: [[string("Saat mendaratkan critical hit pada target, terdapat peluang [c_green]{0}%[/color] untuk menyembuhkan [c_green]{1}[/color] HP. Terdapat cooldown 0.3 detik antara tiap", valA1, valB1), "penyembuhan."], [string("Saat mendaratkan critical hit pada target, terdapat peluang [c_green]{0}%[/color] untuk menyembuhkan [c_green]{1}[/color] HP. Terdapat cooldown 0.3 detik antara tiap", valA2, valB2), "penyembuhan."], [string("Saat mendaratkan critical hit pada target, terdapat peluang [c_green]{0}%[/color] untuk menyembuhkan [c_green]{1}[/color] HP. Terdapat cooldown 0.3 detik antara tiap", valA3, valB3), "penyembuhan."]]
});
name = "HalfDemon";
data = variable_struct_get(SD, name);
valA1 = data.ATK[0] * 100;
valA2 = data.ATK[1] * 100;
valA3 = data.ATK[2] * 100;
CreateToolTip(name, 
{
    eng: "Half Demon",
    jp: "하프 데몬",
    Id: "Setengah Setan"
}, 
{
    eng: [string("Increase damage by [c_green]{0}%[/color], up to [c_green]{1}%[/color], for 5 seconds every time Irys heals. Each heal resets the timer.", valA1, valA1 * 10), string("Increase damage by [c_green]{0}%[/color], up to [c_green]{1}%[/color], for 5 seconds every time Irys heals. Each heal resets the timer.", valA2, valA2 * 10), string("Increase damage by [c_green]{0}%[/color], up to [c_green]{1}%[/color], for 5 seconds every time Irys heals. Each heal resets the timer.", valA3, valA3 * 10)],
    jp: [JPAS(string("체력 회복 시 공격력이 5초간 [c_green]{0}%[/color]에서 최대 [c_green]{1}%[/color]까지 증가한다. 매번 체력을 회복할 때마다 버프 타이머가 초기화된다.", valA1, valA1 * 10)), JPAS(string("체력 회복 시 공격력이 5초간 [c_green]{0}%[/color]에서 최대 [c_green]{1}%[/color]까지 증가한다. 매번 체력을 회복할 때마다 버프 타이머가 초기화된다.", valA2, valA2 * 10)), JPAS(string("체력 회복 시 공격력이 5초간 [c_green]{0}%[/color]에서 최대 [c_green]{1}%[/color]까지 증가한다. 매번 체력을 회복할 때마다 버프 타이머가 초기화된다.", valA3, valA3 * 10))],
    Id: [string("Meningkatkan damage sebesar [c_green]{0}%[/color], hingga [c_green]{1}%[/color], selama 5 detik setiap kali Irys mendapat heal. Setiap heal mereset timer.", valA1, valA1 * 10), string("Meningkatkan damage sebesar [c_green]{0}%[/color], hingga [c_green]{1}%[/color], selama 5 detik setiap kali Irys mendapat heal. Setiap heal mereset timer.", valA2, valA2 * 10), string("Meningkatkan damage sebesar [c_green]{0}%[/color], hingga [c_green]{1}%[/color], selama 5 detik setiap kali Irys mendapat heal. Setiap heal mereset timer.", valA3, valA3 * 10)]
});
name = "Hope";
data = variable_struct_get(SD, name);
valA1 = data.crit[0];
valA2 = data.crit[1];
valA3 = data.crit[2];
valB1 = data.chance[0];
valB2 = data.chance[1];
valB3 = data.chance[2];
valC1 = data.heal[0] * 100;
valC2 = data.heal[1] * 100;
valC3 = data.heal[2] * 100;
CreateToolTip(name, 
{
    eng: "Hope",
    jp: "희망",
    Id: "Harapan"
}, 
{
    eng: [string("Increase crit by [c_green]{0}%[/color]. Upon being hit, there is a [c_green]{1}%[/color] chance to heal [c_green]{2}%[/color] HP and create a shockwave that knocks back all targets.", valA1, valB1, valC1), string("Increase crit by [c_green]{0}%[/color]. Upon being hit, there is a [c_green]{1}%[/color] chance to heal [c_green]{2}%[/color] HP and create a shockwave that knocks back all targets.", valA2, valB2, valC2), string("Increase crit by [c_green]{0}%[/color]. Upon being hit, there is a [c_green]{1}%[/color] chance to heal [c_green]{2}%[/color] HP and create a shockwave that knocks back all targets.", valA3, valB3, valC3)],
    jp: [JPAS(string("치명타 확률이 [c_green]{0}%[/color] 증가한다. 적에게 피격 시 [c_green]{1}%[/color] 확률로 [c_green]{2}%[/color]의 체력을 회복하고 상대를 밀어내는 충격파를 발생시킨다.", valA1, valB1, valC1)), JPAS(string("치명타 확률이 [c_green]{0}%[/color] 증가한다. 적에게 피격 시 [c_green]{1}%[/color] 확률로 [c_green]{2}%[/color]의 체력을 회복하고 상대를 밀어내는 충격파를 발생시킨다.", valA2, valB2, valC2)), JPAS(string("치명타 확률이 [c_green]{0}%[/color] 증가한다. 적에게 피격 시 [c_green]{1}%[/color] 확률로 [c_green]{2}%[/color]의 체력을 회복하고 상대를 밀어내는 충격파를 발생시킨다.", valA3, valB3, valC3))],
    Id: [[string("Tingkatkan crit sebesar [c_green]{0}%[/color]. Saat terkena hit, terdapat [c_green]{1}%[/color] kemungkinan untuk menyembuhkan [c_green]{2}%[/color] HP dan menciptakan gelombang yang mendorong mundur", valA1, valB1, valC1), "semua targett."], [string("Tingkatkan crit sebesar [c_green]{0}%[/color]. Saat terkena hit, terdapat [c_green]{1}%[/color] kemungkinan untuk menyembuhkan [c_green]{2}%[/color] HP dan menciptakan gelombang yang mendorong mundur", valA2, valB2, valC2), "semua targett."], [string("Tingkatkan crit sebesar [c_green]{0}%[/color]. Saat terkena hit, terdapat [c_green]{1}%[/color] kemungkinan untuk menyembuhkan [c_green]{2}%[/color] HP dan menciptakan gelombang yang mendorong mundur", valA3, valB3, valC3), "semua targett."]]
});
name = "Civilization";
data = variable_struct_get(SD, name);
valA1 = data.ATK[0] * 100;
valA2 = data.ATK[1] * 100;
valA3 = data.ATK[2] * 100;
valB1 = data.ATK2 * 100;
valC1 = data.History;
CreateToolTip(name, 
{
    eng: "Civilization",
    jp: "문명",
    Id: "Peradaban"
}, 
{
    eng: [string("ATK increases by [c_green]{0}%[/color] for every target currently on the screen, up to [c_green]{1}%[/color]. In addition, gain a further {2}% for every {3} targets ever defeated.", valA1, valA1 * 100, valB1, valC1), string("ATK increases by [c_green]{0}%[/color] for every target currently on the screen, up to [c_green]{1}%[/color]. In addition, gain a further {2}% for every {3} targets ever defeated.", valA2, valA2 * 80, valB1, valC1), string("ATK increases by [c_green]{0}%[/color] for every target currently on the screen, up to [c_green]{1}%[/color]. In addition, gain a further {2}% for every {3} targets ever defeated.", valA3, valA3 * 75, valB1, valC1)],
    jp: [JPAS(string("화면 내 적 하나 당 공격력이 [c_green]{0}%[/color] 증가한다. (최대 [c_green]{1}%[/color]) 추가로, 지금까지 처치한 적 수 {2}당 공격력이 {3}% 증가한다.", valA1, valA1 * 100, valC1, valB1)), JPAS(string("화면 내 적 하나 당 공격력이 [c_green]{0}%[/color] 증가한다. (최대 [c_green]{1}%[/color]) 추가로, 지금까지 처치한 적 수 {2}당 공격력이 {3}% 증가한다.", valA2, valA2 * 100, valC1, valB1)), JPAS(string("화면 내 적 하나 당 공격력이 [c_green]{0}%[/color] 증가한다. (최대 [c_green]{1}%[/color]) 추가로, 지금까지 처치한 적 수 {2}당 공격력이 {3}% 증가한다.", valA3, valA3 * 100, valC1, valB1))],
    Id: [[string("Serangan bertambah sebesar [c_green]{0}%[/color] untuk setiap target yang sedang ada di layar, sampai dengan [c_green]{1}%[/color]. Sebagai tambahan, dapatkan {2}% lagi untuk setiap", valA1, valA1 * 100, valB1), string("{0} target yang pernah dikalahkan.", valC1)], [string("Serangan bertambah sebesar [c_green]{0}%[/color] untuk setiap target yang sedang ada di layar, sampai dengan [c_green]{1}%[/color]. Sebagai tambahan, dapatkan {2}% lagi untuk setiap", valA2, valA2 * 80, valB1), string("{0} target yang pernah dikalahkan.", valC1)], [string("Serangan bertambah sebesar [c_green]{0}%[/color] untuk setiap target yang sedang ada di layar, sampai dengan [c_green]{1}%[/color]. Sebagai tambahan, dapatkan {2}% lagi untuk setiap", valA3, valA3 * 75, valB1), string("{0} target yang pernah dikalahkan.", valC1)]]
});
name = "Friend";
data = variable_struct_get(SD, name);
valA1 = data.damage[0] * 100;
valA2 = data.damage[1] * 100;
valA3 = data.damage[2] * 100;
CreateToolTip(name, 
{
    eng: "Friend",
    jp: "친구",
    Id: "Teman"
}, 
{
    eng: [string("Summon Friend that uses Bird Feather at [c_green]{0}%[/color] Power.", valA1), string("Summon Friend that uses Bird Feather as well as [c_green]1[/color] other random weapon at [c_green]{0}%[/color] Power.", valA2), string("Summon Friend that uses Bird Feather as well as [c_green]2[/color] other random weapons at [c_green]{0}%[/color] Power.", valA3)],
    jp: [JPAS(string("\"친구\"를 소환한다. 깃털을 [c_green]{0}%[/color]의 위력으로 공격한다.", valA1)), JPAS(string("\"친구\"를 소환한다. 내 무기 중 [c_green]1[/color]개를 골라 깃털과 함께 그 위력의 [c_green]{0}%[/color]로 공격한다.", valA2)), JPAS(string("\"친구\"를 소환한다. 내 무기 중 [c_green]1[/color]개를 골라 깃털과 함께 그 위력의 [c_green]{0}%[/color]로 공격한다.", valA3))],
    Id: [string("Memanggil Teman yang juga menggunakan Piercing Feather di kekuatan [c_green]{0}%[/color].", valA1), string("Memanggil Teman yang menggunakan Piercing Feather juga [c_green]1[/color] senjata acak lain di kekuatan [c_green]{0}%[/color].", valA2), string("Memanggil Teman yang menggunakan Piercing Feather juga [c_green]2[/color] senjata acak lain di kekuatan [c_green]{0}%[/color].", valA3)]
});
name = "History";
data = variable_struct_get(SD, name);
valA1 = data.ATK[0] * 100;
valA2 = data.ATK[1] * 100;
valA3 = data.ATK[2] * 100;
valB1 = data.heal * 100;
CreateToolTip(name, 
{
    eng: "Bloodthirsty",
    jp: "피를 마시는 새",
    Id: "Haus Darah"
}, 
{
    eng: [string("When a target is defeated, gain 1 stack of [c_red]Bloodthirst[/color]. At 20 stacks, Mumei heals {0}% HP and gains [c_green]{1}%[/color] ATK for 10 seconds.", valB1, valA1), string("When a target is defeated, gain 1 stack of [c_red]Bloodthirst[/color]. At 20 stacks, Mumei heals {0}% HP and gains [c_green]{1}%[/color] ATK for 10 seconds.", valB1, valA2), string("When a target is defeated, gain 1 stack of [c_red]Bloodthirst[/color]. At 20 stacks, Mumei heals {0}% HP and gains [c_green]{1}%[/color] ATK for 10 seconds.", valB1, valA3)],
    jp: [JPAS(string("적을 처치시 [c_red]피의 갈증[/color]이 1스택 증가한다. 20스택이 쌓이면 무메이는 체력을 {0}% 회복하고 10초간 공격력이 [c_green]{1}%[/color] 증가한다.", valB1, valA1)), JPAS(string("적을 처치시 [c_red]피의 갈증[/color]이 1스택 증가한다. 20스택이 쌓이면 무메이는 체력을 {0}% 회복하고 10초간 공격력이 [c_green]{1}%[/color] 증가한다.", valB1, valA2)), JPAS(string("적을 처치시 [c_red]피의 갈증[/color]이 1스택 증가한다. 20스택이 쌓이면 무메이는 체력을 {0}% 회복하고 10초간 공격력이 [c_green]{1}%[/color] 증가한다.", valB1, valA3))],
    Id: [string("Saat target dikalahkan, dapatkan 1 stack [c_red]Bloodthirst[/color]. Di 20 stack, Mumei menyembuhkan {0}% HP dan mendapat [c_green]{1}%[/color] ATK untuk 10 detik.", valB1, valA1), string("Saat target dikalahkan, dapatkan 1 stack [c_red]Bloodthirst[/color]. Di 20 stack, Mumei menyembuhkan {0}% HP dan mendapat [c_green]{1}%[/color] ATK untuk 10 detik.", valB1, valA2), string("Saat target dikalahkan, dapatkan 1 stack [c_red]Bloodthirst[/color]. Di 20 stack, Mumei menyembuhkan {0}% HP dan mendapat [c_green]{1}%[/color] ATK untuk 10 detik.", valB1, valA3)]
});
name = "Perfection";
data = variable_struct_get(SD, name);
valA1 = data.weight[0] * 100;
valA2 = data.weight[1] * 100;
valA3 = data.weight[2] * 100;
valB1 = data.weight2[0];
valB2 = data.weight2[1];
valB3 = data.weight2[2];
CreateToolTip(name, 
{
    eng: "Perfection",
    jp: "자칭완벽주의",
    Id: "Perfeksionis"
}, 
{
    eng: [string("If HP is full, increase ATK, SPD, Pick Up Range by [c_green]{0}%[/color]. Also increase Haste and Crit by [c_green]{1}%[/color].", valA1, valB1), string("If HP is full, increase ATK, SPD, Pick Up Range by [c_green]{0}%[/color]. Also increase Haste and Crit by [c_green]{1}%[/color].", valA2, valB2), string("If HP is full, increase ATK, SPD, Pick Up Range by [c_green]{0}%[/color]. Also increase Haste and Crit by [c_green]{1}%[/color]. If HP is not full, heal HP by 5% every 3 seconds.", valA3, valB3)],
    jp: [JPAS(string("체력 100% 유지 시 피해량/이동속도/획득범위가 [c_green]{0}%[/color] 증가하고, 공격속도/지명타율이 [c_green]{1}%[/color]증가한다.", valA1, valB1)), JPAS(string("체력 100% 유지 시 피해량/이동속도/획득범위가 [c_green]{0}%[/color] 증가하고, 공격속도/지명타율이 [c_green]{1}%[/color]증가한다.", valA2, valB2)), JPAS(string("체력 100% 유지 시 피해량/이동속도/획득범위가 [c_green]{0}%[/color] 증가하고, 공격속도/지명타율이 [c_green]{1}%[/color]증가한다. 체력이 잃을 시, 3초마다 체력의 5%를 회복한다.", valA3, valB3))],
    Id: [string("Jika HP penuh, meningkatkan ATK, SPD, Range Pick Up sebesar [c_green]{0}%[/color]. Juga meningkatkan Haste dan Crit sebesar [c_green]{1}%[/color].", valA1, valB1), string("Jika HP penuh, meningkatkan ATK, SPD, Range Pick Up sebesar [c_green]{0}%[/color]. Juga meningkatkan Haste dan Crit sebesar [c_green]{1}%[/color].", valA2, valB2), [string("Jika HP penuh, meningkatkan ATK, SPD, Range Pick Up sebesar [c_green]{0}%[/color]. Juga meningkatkan Haste dan Crit sebesar [c_green]{1}%[/color]. Jika HP tidak penuh,", valA3, valB3), "memulihkan HP sebesar 5% setiap 3 detik."]]
});
name = "Kroniicopter";
data = variable_struct_get(SD, name);
valA1 = data.haste[0];
valA2 = data.haste[1];
valA3 = data.haste[2];
valB1 = data.SPD[0] * 100;
valB2 = data.SPD[1] * 100;
valB3 = data.SPD[2] * 100;
CreateToolTip(name, 
{
    eng: "Kroniicopter",
    jp: "크로니콥터",
    Id: "Kroniicopter"
}, 
{
    eng: [string("Increase SPD and Haste by [c_green]{0}%[/color]. If Clock Hands lands a critical hit, gain another [c_green]{1}%[/color] to SPD and Haste for 5 seconds.", valA1, valB1), string("Increase SPD and Haste by [c_green]{0}%[/color]. If Clock Hands lands a critical hit, gain another [c_green]{1}%[/color] to SPD and Haste for 5 seconds.", valA2, valB2), string("Increase SPD and Haste by [c_green]{0}%[/color]. If Clock Hands lands a critical hit, gain another [c_green]{1}%[/color] to SPD and Haste for 5 seconds.", valA3, valB3)],
    jp: [JPAS(string("이동속도, 공격속도가 [c_green]{0}%[/color] 증가한다. \"시계바늘\" 공격으로 치명타 성공 시, 추가로 5초간 이동속도, 공격속도가 [c_green]{1}%[/color] 증가한다.", valA1, valB1)), JPAS(string("이동속도, 공격속도가 [c_green]{0}%[/color] 증가한다. \"시계바늘\" 공격으로 치명타 성공 시, 추가로 5초간 이동속도, 공격속도가 [c_green]{1}%[/color] 증가한다.", valA2, valB2)), JPAS(string("이동속도, 공격속도가 [c_green]{0}%[/color] 증가한다. \"시계바늘\" 공격으로 치명타 성공 시, 추가로 5초간 이동속도, 공격속도가 [c_green]{1}%[/color] 증가한다.", valA3, valB3))],
    Id: [string("Meningkatkan SPD dan Haste sebesar [c_green]{0}%[/color]. Jika Tangan Jam mendaratkan critical hit, dapatkan [c_green]{1}%[/color] SPD dan Haste untuk 5 detik tambahan.", valA1, valB1), string("Meningkatkan SPD dan Haste sebesar [c_green]{0}%[/color]. Jika Tangan Jam mendaratkan critical hit, dapatkan [c_green]{1}%[/color] SPD dan Haste untuk 5 detik tambahan.", valA2, valB2), string("Meningkatkan SPD dan Haste sebesar [c_green]{0}%[/color]. Jika Tangan Jam mendaratkan critical hit, dapatkan [c_green]{1}%[/color] SPD dan Haste untuk 5 detik tambahan.", valA3, valB3)]
});
name = "TimeBubble";
data = variable_struct_get(SD, name);
CreateToolTip(name, 
{
    eng: "Time Bubble",
    jp: "시간 거품",
    Id: "Gelembung Waktu"
}, 
{
    eng: ["Every 10 seconds, create a [c_green]small[/color] time bubble that freezes targets in time, preventing them from moving or attacking.", "Every 10 seconds, create a [c_green]medium[/color] time bubble that freezes targets in time, preventing them from moving or attacking.", "Every 10 seconds, create a [c_green]large[/color] time bubble that freezes targets in time, preventing them from moving or attacking."],
    jp: ["10초간 돔 형타의 구역을 생성한다[c_green](소)[/color]. 해당 구역에서 적은 움직일 수도 공격할 수도 없다.", "10초간 돔 형타의 구역을 생성한다[c_green](중)[/color]. 해당 구역에서 적은 움직일 수도 공격할 수도 없다.", "10초간 돔 형타의 구역을 생성한다[c_green](대)[/color]. 해당 구역에서 적은 움직일 수도 공격할 수도 없다."],
    Id: ["Setiap 10 detik, buat gelembung waktu [c_green]kecil[/color] yang membekukan target pada waktunya, mencegah mereka bergerak atau menyerang.", "Setiap 10 detik, buat gelembung waktu [c_green]sedang[/color] yang membekukan target pada waktunya, mencegah mereka bergerak atau menyerang.", "Setiap 10 detik, buat gelembung waktu [c_green]besar[/color] yang membekukan target pada waktunya, mencegah mereka bergerak atau menyerang."]
});
name = "LunarConstruction";
data = variable_struct_get(SD, name);
valA1 = data.damage[0] * 100;
valA2 = data.damage[1] * 100;
valA3 = data.damage[2] * 100;
valB1 = data.blocks;
CreateToolTip(name, 
{
    eng: "Lunar Construction",
    jp: "월면 건설",
    Id: "Konstruksi Lunar"
}, 
{
    eng: [[string("Targets may drop Lunar Blocks. At {0} Blocks, Moona creates a Lunar Rabbit, which explodes on nearby targets dealing [c_green]{1}%[/color] damage. If Lunar Rabbit", valB1, valA1), " defeats a target, gain Special Meter."], [string("Targets may drop Lunar Blocks. At {0} Blocks, Moona creates a Lunar Rabbit, which explodes on nearby targets dealing [c_green]{1}%[/color] damage. If Lunar Rabbit", valB1, valA2), " defeats a target, gain Special Meter."], [string("Targets may drop Lunar Blocks. At {0} Blocks, Moona creates a Lunar Rabbit, which explodes on nearby targets dealing [c_green]{1}%[/color] damage. If Lunar Rabbit", valB1, valA3), " defeats a target, gain Special Meter."]],
    jp: [[JPAS(string("적이 월면 블록을 드롭할 수 있다. 블록이 {0}개 생기면 무나는 폭발하는 달토끼를 소환하고, 주변 대상에게 [c_green]{1}%[/color] 피해를 입힌다. 달토끼가 적을 처치하면 특수 능력 게이지가 찬다.", valB1, valA1)), JPAS("必殺ゲージが少し溜まる。")], [JPAS(string("적이 월면 블록을 드롭할 수 있다. 블록이 {0}개 생기면 무나는 폭발하는 달토끼를 소환하고, 주변 대상에게 [c_green]{1}%[/color] 피해를 입힌다. 달토끼가 적을 처치하면 특수 능력 게이지가 찬다.", valB1, valA2)), JPAS("必殺ゲージが少し溜まる。")], [JPAS(string("적이 월면 블록을 드롭할 수 있다. 블록이 {0}개 생기면 무나는 폭발하는 달토끼를 소환하고, 주변 대상에게 [c_green]{1}%[/color] 피해를 입힌다. 달토끼가 적을 처치하면 특수 능력 게이지가 찬다.", valB1, valA3)), JPAS("必殺ゲージが少し溜まる。")]],
    Id: [[string("Target dapat menjatuhkan Balok Bulan. Di {0} balok, Moona menciptakan Kelinci Bulan, yang meledak di sekitar target dan memberikan [c_green]{1}%[/color]", valB1, valA1), "damage. Jika Kelinci Bulan mengalahkan target, dapatkan Special Meter."], [string("Target dapat menjatuhkan Balok Bulan. Di {0} balok, Moona menciptakan Kelinci Bulan, yang meledak di sekitar target dan memberikan [c_green]{1}%[/color]", valB1, valA2), "damage. Jika Kelinci Bulan mengalahkan target, dapatkan Special Meter."], [string("Target dapat menjatuhkan Balok Bulan. Di {0} balok, Moona menciptakan Kelinci Bulan, yang meledak di sekitar target dan memberikan [c_green]{1}%[/color]", valB1, valA3), "damage. Jika Kelinci Bulan mengalahkan target, dapatkan Special Meter."]]
});
name = "MoonSong";
data = variable_struct_get(SD, name);
valA1 = data.damage[0] * 100;
valA2 = data.damage[1] * 100;
valA3 = data.damage[2] * 100;
CreateToolTip(name, 
{
    eng: "Moon Song",
    jp: "달의 노래",
    Id: "Nyanyian Bulan"
}, 
{
    eng: [string("Every 10 seconds, Moona sings to create a [c_green]small[/color] moving orb of music that draws targets in, slowly dealing [c_green]{0}%[/color] damage per half second.", valA1), string("Every 10 seconds, Moona sings to create a [c_green]medium[/color] moving orb of music that draws targets in, slowly dealing [c_green]{0}%[/color] damage per half second.", valA2), string("Every 10 seconds, Moona sings to create a [c_green]large[/color] moving orb of music that draws targets in, slowly dealing [c_green]{0}%[/color] damage per half second.", valA3)],
    jp: [JPAS(string("10초마다 무나는 노래를 불러 [c_green]소형[/color] 음악의 구슬을 소환한다. 구슬은 적을 끌어들여 서서히 1/2초당 [c_green]{0}%[/color] 피해를 입힌다.", valA1)), JPAS(string("10초마다 무나는 노래를 불러 [c_green]중형[/color] 음악의 구슬을 소환한다. 구슬은 적을 끌어들여 서서히 1/2초당 [c_green]{0}%[/color] 피해를 입힌다.", valA2)), JPAS(string("10초마다 무나는 노래를 불러 [c_green]대형[/color] 음악의 구슬을 소환한다. 구슬은 적을 끌어들여 서서히 1/2초당 [c_green]{0}%[/color] 피해를 입힌다.", valA3))],
    Id: [["Setiap 10 detik, Moona bernyanyi untuk menciptakan bola musik berukuran [c_green]kecil[/color] yang bergerak yang menarik target, yang secara perlahan memberikan", string("[c_green]{0}%[/color] damage per setengah detik.", valA1)], ["Setiap 10 detik, Moona bernyanyi untuk menciptakan bola musik berukuran [c_green]sedang[/color] yang bergerak yang menarik target, yang secara perlahan memberikan", string("[c_green]{0}%[/color] damage per setengah detik.", valA2)], ["Setiap 10 detik, Moona bernyanyi untuk menciptakan bola musik berukuran [c_green]besar[/color] yang bergerak yang menarik target, yang secara perlahan memberikan", string("[c_green]{0}%[/color] damage per setengah detik.", valA3)]]
});
name = "Hoshinova";
data = variable_struct_get(SD, name);
valA1 = data.ATK[0] * 100;
valA2 = data.ATK[1] * 100;
valA3 = data.ATK[2] * 100;
valB1 = 100 - (data.DEF[0] * 100);
valB2 = 100 - (data.DEF[1] * 100);
valB3 = 100 - (data.DEF[2] * 100);
CreateToolTip(name, 
{
    eng: "Hoshinova & Moona",
    jp: "호시노바 & 무나",
    Id: "Hoshinova & Moona"
}, 
{
    eng: [string("Gain [c_purple]Hoshinova[/color] buff, increasing ATK by [c_green]{0}%[/color]. If taking damage, [c_purple]Hoshinova[/color] becomes [c_lavender]Moona[/color] for 5 seconds, reducing damage taken by {1}% instead.", valA1, valB1), string("Gain [c_purple]Hoshinova[/color] buff, increasing ATK by [c_green]{0}%[/color]. If taking damage, [c_purple]Hoshinova[/color] becomes [c_lavender]Moona[/color] for 5 seconds, reducing damage taken by {1}% instead.", valA2, valB2), string("Gain [c_purple]Hoshinova[/color] buff, increasing ATK by [c_green]{0}%[/color]. If taking damage, [c_purple]Hoshinova[/color] becomes [c_lavender]Moona[/color] for 5 seconds, reducing damage taken by {1}% instead.", valA3, valB3)],
    jp: [JPAS(string("[c_purple]호시노바[/color] 버프를 얻는다. 공격력이 [c_green]{0}%[/color] 증가한다. 피해를 입으면, [c_purple]호시노바[/color]가 5초간 [c_lavender]무나[/color]로 변하고 피해를 {1}%만 받는다.", valA1, valB1)), JPAS(string("[c_purple]호시노바[/color] 버프를 얻는다. 공격력이 [c_green]{0}%[/color] 증가한다. 피해를 입으면, [c_purple]호시노바[/color]가 5초간 [c_lavender]무나[/color]로 변하고 피해를 {1}%만 받는다.", valA2, valB2)), JPAS(string("[c_purple]호시노바[/color] 버프를 얻는다. 공격력이 [c_green]{0}%[/color] 증가한다. 피해를 입으면, [c_purple]호시노바[/color]가 5초간 [c_lavender]무나[/color]로 변하고 피해를 {1}%만 받는다.", valA3, valB3))],
    Id: [[string("Dapatkan buff [c_purple]Hoshinova[/color], meningkatkan ATK sebesar [c_green]{0}%[/color]. Bila mendapat damage, [c_purple]Hoshinova[/color] menjadi [c_lavender]Moona[/color] untuk 5 detik, mengurangi damage yang diterima", valA1), string("sebesar {0}%.", valB1)], [string("Dapatkan buff [c_purple]Hoshinova[/color], meningkatkan ATK sebesar [c_green]{0}%[/color]. Bila mendapat damage, [c_purple]Hoshinova[/color] menjadi [c_lavender]Moona[/color] untuk 5 detik, mengurangi damage yang diterima", valA2), string("sebesar {0}%.", valB2)], [string("Dapatkan buff [c_purple]Hoshinova[/color], meningkatkan ATK sebesar [c_green]{0}%[/color]. Bila mendapat damage, [c_purple]Hoshinova[/color] menjadi [c_lavender]Moona[/color] untuk 5 detik, mengurangi damage yang diterima", valA3), string("sebesar {0}%.", valB3)]]
});
name = "Deez";
data = variable_struct_get(SD, name);
valA1 = data.chance[0];
valA2 = data.chance[1];
valA3 = data.chance[2];
valB1 = data.damage * 100;
CreateToolTip(name, 
{
    eng: "Deez",
    jp: "Deez",
    Id: "Deez"
}, 
{
    eng: [string("Inflicts [c_yellow]Internal[/color] damage. Risu's Main Weapon has a [c_green]{0}%[/color] chance to inflict damage equal to {1}% of a non-boss target's HP.", valA1, valB1), string("Inflicts [c_yellow]Internal[/color] damage. Risu's Main Weapon has a [c_green]{0}%[/color] chance to inflict damage equal to {1}% of a non-boss target's HP.", valA2, valB1), string("Inflicts [c_yellow]Internal[/color] damage. Risu's Main Weapon has a [c_green]{0}%[/color] chance to inflict damage equal to {1}% of a non-boss target's HP.", valA3, valB1)],
    jp: [JPAS(string("[c_yellow]내상[/color]을 입힌다. 리스의 주무기는 [c_green]{0}%[/color] 확률로  보스를 제외한 대상의 체력 {1}%만큼의 피해를 입힌다.", valA1, valB1)), JPAS(string("[c_yellow]내상[/color]을 입힌다. 리스의 주무기는 [c_green]{0}%[/color] 확률로  보스를 제외한 대상의 체력 {1}%만큼의 피해를 입힌다.", valA2, valB1)), JPAS(string("[c_yellow]내상[/color]을 입힌다. 리스의 주무기는 [c_green]{0}%[/color] 확률로  보스를 제외한 대상의 체력 {1}%만큼의 피해를 입힌다.", valA3, valB1))],
    Id: [string("Memberikan damage [c_yellow]Internal[/color]. Senjata Utama Risu memiliki peluang [c_green]{0}%[/color] untuk memberi damage setara dengan {1}% dari HP target sekarang.", valA1, valB1), string("Memberikan damage [c_yellow]Internal[/color]. Senjata Utama Risu memiliki peluang [c_green]{0}%[/color] untuk memberi damage setara dengan {1}% dari HP target sekarang.", valA2, valB1), string("Memberikan damage [c_yellow]Internal[/color]. Senjata Utama Risu memiliki peluang [c_green]{0}%[/color] untuk memberi damage setara dengan {1}% dari HP target sekarang.", valA3, valB1)]
});
name = "NonstopNuts";
data = variable_struct_get(SD, name);
valA1 = data.chance[0];
valA2 = data.chance[1];
valA3 = data.chance[2];
valB1 = data.damage[0] * 100;
valB2 = data.damage[1] * 100;
valB3 = data.damage[2] * 100;
CreateToolTip(name, 
{
    eng: "Nonstop Nuts",
    jp: "논스톱 넛츠",
    Id: "Nonstop Nuts"
}, 
{
    eng: [string("When defeating a target, there is a [c_green]{0}%[/color] chance the target explodes into Nuts that scatter, dealing [c_green]{1}%[/color] of main weapon damage each.", valA1, valB1), string("When defeating a target, there is a [c_green]{0}%[/color] chance the target explodes into Nuts that scatter, dealing [c_green]{1}%[/color] of main weapon damage each.", valA2, valB2), string("When defeating a target, there is a [c_green]{0}%[/color] chance the target explodes into Nuts that scatter, dealing [c_green]{1}%[/color] of main weapon damage each.", valA3, valB3)],
    jp: [JPAS(string("적 처치 시 [c_green]{0}%[/color]확률로 도토리를 흩뿌리며 죽는다. 도토리는 각각 주무기의 [c_green]{1}%[/color] 피해를 입힌다.", valA1, valB1)), JPAS(string("적 처치 시 [c_green]{0}%[/color]확률로 도토리를 흩뿌리며 죽는다. 도토리는 각각 주무기의 [c_green]{1}%[/color] 피해를 입힌다.", valA2, valB2)), JPAS(string("적 처치 시 [c_green]{0}%[/color]확률로 도토리를 흩뿌리며 죽는다. 도토리는 각각 주무기의 [c_green]{1}%[/color] 피해를 입힌다.", valA3, valB3))],
    Id: [string("Saat mengalahkan target, ada [c_green]{0}%[/color] kemungkinan target meledak menjadi Kacang yang tersebar, memberikan [c_green]{1}%[/color] dari damage senjata utama.", valA1, valB1), string("Saat mengalahkan target, ada [c_green]{0}%[/color] kemungkinan target meledak menjadi Kacang yang tersebar, memberikan [c_green]{1}%[/color] dari damage senjata utama.", valA2, valB2), string("Saat mengalahkan target, ada [c_green]{0}%[/color] kemungkinan target meledak menjadi Kacang yang tersebar, memberikan [c_green]{1}%[/color] dari damage senjata utama.", valA3, valB3)]
});
name = "DLC";
data = variable_struct_get(SD, name);
valA1 = data.dropChance[0] * 100;
valA2 = data.dropChance[1] * 100;
valA3 = data.dropChance[2] * 100;
valB1 = data.damage[0] * 100;
valB2 = data.damage[1] * 100;
valB3 = data.damage[2] * 100;
CreateToolTip(name, 
{
    eng: "DLC",
    jp: "DLC",
    Id: "DLC"
}, 
{
    eng: [string("Gain [c_green]1[/color] HoloCoin every 3 seconds. After gaining HoloCoins 5 times, create another Risu (max 3) for 15 seconds, dealing [c_green]{0}%[/color] of your Weapon damage.", valB1), string("Gain [c_green]2[/color] HoloCoin every 3 seconds. After gaining HoloCoins 5 times, create another Risu (max 3) for 15 seconds, dealing [c_green]{0}%[/color] of your Weapon damage.", valB2), string("Gain [c_green]3[/color] HoloCoin every 3 seconds. After gaining HoloCoins 5 times, create another Risu (max 3) for 15 seconds, dealing [c_green]{0}%[/color] of your Weapon damage.", valB3)],
    jp: [JPAS(string("3초마다 [c_green]1[/color] 홀로코인을 습득한다. 5번 얻고 나면 (최대 3명의) 리스 복제본이 15초간 생겨나 주무기의 [c_green]{0}%[/color] 공격력으로 공격한다.", valB1)), JPAS(string("3초마다 [c_green]2[/color] 홀로코인을 습득한다. 5번 얻고 나면 (최대 3명의) 리스 복제본이 15초간 생겨나 주무기의 [c_green]{0}%[/color] 공격력으로 공격한다.", valB2)), JPAS(string("3초마다 [c_green]3[/color] 홀로코인을 습득한다. 5번 얻고 나면 (최대 3명의) 리스 복제본이 15초간 생겨나 주무기의 [c_green]{0}%[/color] 공격력으로 공격한다.", valB3))],
    Id: [["Dapatkan 1 [c_green]1[/color] HoloCoin setiap 3 detik. Setelah mendapatkan HoloCoins 5 kali, ciptakan satu Risu tambahan (maks 3) selama 15 detik, memberikan", string("[c_green]{0}%[/color] dari damage Senjata.", valB1)], ["Dapatkan 1 [c_green]1[/color] HoloCoin setiap 3 detik. Setelah mendapatkan HoloCoins 5 kali, ciptakan satu Risu tambahan (maks 3) selama 15 detik, memberikan", string("[c_green]{0}%[/color] dari damage Senjata.", valB2)], ["Dapatkan 1 [c_green]1[/color] HoloCoin setiap 3 detik. Setelah mendapatkan HoloCoins 5 kali, ciptakan satu Risu tambahan (maks 3) selama 15 detik, memberikan", string("[c_green]{0}%[/color] dari damage Senjata.", valB3)]]
});
name = "Erofi";
data = variable_struct_get(SD, name);
valA1 = data.heal[0] * 100;
valA2 = data.heal[1] * 100;
valA3 = data.heal[2] * 100;
valB1 = data.distance;
CreateToolTip(name, 
{
    eng: "Erofi",
    jp: "에로피",
    Id: "Erofi"
}, 
{
    eng: [string("Once per second, after Iofi takes damage from an attack, Iofi immediately heals [c_green]{0}%[/color] HP for every target within {1}px.", valA1, valB1), string("Once per second, after Iofi takes damage from an attack, Iofi immediately heals [c_green]{0}%[/color] HP for every target within {1}px.", valA2, valB1), string("Once per second, after Iofi takes damage from an attack, Iofi immediately heals [c_green]{0}%[/color] HP for every target within {1}px.", valA3, valB1)],
    jp: [JPAS(string("1초마다, 이오피가 공격받을 경우 {0}px내의 적 인당 체력 [c_green]{1}%[/color]를 회복한다.", valB1, valA1)), JPAS(string("1초마다, 이오피가 공격받을 경우 {0}px내의 적 인당 체력 [c_green]{1}%[/color]를 회복한다.", valB1, valA2)), JPAS(string("1초마다, 이오피가 공격받을 경우 {0}px내의 적 인당 체력 [c_green]{1}%[/color]를 회복한다.", valB1, valA3))],
    Id: [string("Sekali per detik, setelah Iofi menerima damage dari serangan, Iofi langsung menyembuhkan [c_green]{0}%[/color] HP untuk setiap target dalam jarak {1}px.", valA1, valB1), string("Sekali per detik, setelah Iofi menerima damage dari serangan, Iofi langsung menyembuhkan [c_green]{0}%[/color] HP untuk setiap target dalam jarak {1}px.", valA2, valB1), string("Sekali per detik, setelah Iofi menerima damage dari serangan, Iofi langsung menyembuhkan [c_green]{0}%[/color] HP untuk setiap target dalam jarak {1}px.", valA3, valB1)]
});
name = "AlienBrainwashing";
data = variable_struct_get(SD, name);
valA1 = data.damage[0] * 100;
valA2 = data.damage[1] * 100;
valA3 = data.damage[2] * 100;
valB1 = data.maxTargets[0];
valB2 = data.maxTargets[1];
valB3 = data.maxTargets[2];
valC1 = data.timer / 60;
CreateToolTip(name, 
{
    eng: "Alien Brainwashing",
    jp: "외계인 세뇌",
    Id: "Cuci Otak Alien"
}, 
{
    eng: [[string("Every {0} seconds, release a brainwashing wave that deals [c_green]{1}%[/color] damage and pacifies targets (max [c_green]{2}[/color]) for 3 seconds. Gain 1% crit for each target", valC1, valA1, valB1), "brainwashed for 15 seconds."], [string("Every {0} seconds, release a brainwashing wave that deals [c_green]{1}%[/color] damage and pacifies targets (max [c_green]{2}[/color]) for 3 seconds. Gain 1% crit for each target", valC1, valA2, valB2), "brainwashed for 15 seconds."], [string("Every {0} seconds, release a brainwashing wave that deals [c_green]{1}%[/color] damage and pacifies targets (max [c_green]{2}[/color]) for 3 seconds. Gain 1% crit for each target", valC1, valA3, valB3), "brainwashed for 15 seconds."]],
    jp: [JPAS(string("{0}초마다 세뇌파를 보내 [c_green]{1}%[/color] 피해를 주고 3초간 최대 적 [c_green]{2}[/color]명을 무력화시킨다. 이후 15초간 세뇌시킨 적 당 치명타 확률이 1% 증가한다.", valC1, valA1, valB1)), JPAS(string("{0}초마다 세뇌파를 보내 [c_green]{1}%[/color] 피해를 주고 3초간 최대 적 [c_green]{2}[/color]명을 무력화시킨다. 이후 15초간 세뇌시킨 적 당 치명타 확률이 1% 증가한다.", valC1, valA2, valB2)), JPAS(string("{0}초마다 세뇌파를 보내 [c_green]{1}%[/color] 피해를 주고 3초간 최대 적 [c_green]{2}[/color]명을 무력화시킨다. 이후 15초간 세뇌시킨 적 당 치명타 확률이 1% 증가한다.", valC1, valA3, valB3))],
    Id: [[string("Setiap 15 detik, lepaskan sebuah gelombang cuci otak yang memberi [c_green]{0}%[/color] damage dan pasifkan (maks [c_green]{1}[/color]) target selama 3 detik. Dapatkan 1% crit untuk", valA1, valB1), "setiap target tercuci otak selama 15 detik."], [string("Setiap 15 detik, lepaskan sebuah gelombang cuci otak yang memberi [c_green]{0}%[/color] damage dan pasifkan (maks [c_green]{1}[/color]) target selama 3 detik. Dapatkan 1% crit untuk", valA2, valB2), "setiap target tercuci otak selama 15 detik."], [string("Setiap 15 detik, lepaskan sebuah gelombang cuci otak yang memberi [c_green]{0}%[/color] damage dan pasifkan (maks [c_green]{1}[/color]) target selama 3 detik. Dapatkan 1% crit untuk", valA3, valB3), "setiap target tercuci otak selama 15 detik."]]
});
name = "Polyglot";
data = variable_struct_get(SD, name);
valA1 = data.weight1[0] * 100;
valA2 = data.weight1[1] * 100;
valA3 = data.weight1[2] * 100;
valB1 = data.weight2[0];
valB2 = data.weight2[1];
valB3 = data.weight2[2];
CreateToolTip(name, 
{
    eng: "Polyglot",
    jp: "다국어 구사자",
    Id: "Polyglot"
}, 
{
    eng: [[string("Targets drop Language Orbs that switch Iofi's language, granting ATK/SPD/PUR by [c_green]{0}%[/color], or Crit/Haste by [c_green]{1}%[/color]. If the current language gained", valA1, valB1), "is different, create a burst dealing 200% damage."], [string("Targets drop Language Orbs that switch Iofi's language, granting ATK/SPD/PUR by [c_green]{0}%[/color], or Crit/Haste by [c_green]{1}%[/color]. If the current language gained", valA2, valB2), "is different, create a burst dealing 200% damage."], [string("Targets drop Language Orbs that switch Iofi's language, granting ATK/SPD/PUR by [c_green]{0}%[/color], or Crit/Haste by [c_green]{1}%[/color]. If the current language gained", valA3, valB3), "is different, create a burst dealing 200% damage."]],
    jp: [[JPAS(string("적이 드랍하는 언어 구슬을 습득하면 이오피의 언어가 바뀌고, 공격력/이동속도/습득범위가 [c_green]{0}%[/color] 증가하거나 치명타율/공격속도가 [c_green]{1}%[/color] 증가한다. 이번에 습득한", valA1, valB1)), JPAS("언어 구슬이 현재 언어와 다르면 즉시 200% 피해를 준다.")], [JPAS(string("적이 드랍하는 언어 구슬을 습득하면 이오피의 언어가 바뀌고, 공격력/이동속도/습득범위가 [c_green]{0}%[/color] 증가하거나 치명타율/공격속도가 [c_green]{1}%[/color] 증가한다. 이번에 습득한", valA2, valB2)), JPAS("언어 구슬이 현재 언어와 다르면 즉시 200% 피해를 준다.")], [JPAS(string("적이 드랍하는 언어 구슬을 습득하면 이오피의 언어가 바뀌고, 공격력/이동속도/습득범위가 [c_green]{0}%[/color] 증가하거나 치명타율/공격속도가 [c_green]{1}%[/color] 증가한다. 이번에 습득한", valA3, valB3)), JPAS("언어 구슬이 현재 언어와 다르면 즉시 200% 피해를 준다.")]],
    Id: [[string("Target menjatuhkan Language Orbs yang mengganti bahasa Iofi, memberikan ATK/SPD/PUR sebesar [c_green]{0}%[/color], atau Crit/Haste sebesar [c_green]{1}%[/color]. Jika", valA1, valB1), "bahasa yang diperoleh saat ini berbeda, buat ledakan yang memberikan 200% damage."], [string("Target menjatuhkan Language Orbs yang mengganti bahasa Iofi, memberikan ATK/SPD/PUR sebesar [c_green]{0}%[/color], atau Crit/Haste sebesar [c_green]{1}%[/color]. Jika", valA2, valB2), "bahasa yang diperoleh saat ini berbeda, buat ledakan yang memberikan 200% damage."], [string("Target menjatuhkan Language Orbs yang mengganti bahasa Iofi, memberikan ATK/SPD/PUR sebesar [c_green]{0}%[/color], atau Crit/Haste sebesar [c_green]{1}%[/color]. Jika", valA3, valB3), "bahasa yang diperoleh saat ini berbeda, buat ledakan yang memberikan 200% damage."]]
});
name = "Ninjutsu";
data = variable_struct_get(SD, name);
var valA = data.damage;
CreateToolTip(name, 
{
    eng: "Zombie Ninjutsu",
    jp: "좀비 인술",
    Id: "Zombie Ninjutsu"
}, 
{
    eng: [string("Gather chakra while moving. If Ollie stops moving for 1 second, spend all chakra to cast a [c_green]{0}x[/color] strength jutsu based on the accumulated chakra.", valA[0]), string("Gather chakra while moving. If Ollie stops moving for 1 second, spend all chakra to cast a [c_green]{0}x[/color] strength jutsu based on the accumulated chakra.", valA[1]), string("Gather chakra while moving. If Ollie stops moving for 1 second, spend all chakra to cast a [c_green]{0}x[/color] strength jutsu based on the accumulated chakra.", valA[2])],
    jp: [JPAS(string("움직일때마다 차크라가 쌓인다. 올리가 움직임을 1초 멈추면 지금까지 모인 차크라의 [c_green]{0}x[/color]위력으로 주술을 시전한다.", valA[0])), JPAS(string("움직일때마다 차크라가 쌓인다. 올리가 움직임을 1초 멈추면 지금까지 모인 차크라의 [c_green]{0}x[/color]위력으로 주술을 시전한다.", valA[1])), JPAS(string("움직일때마다 차크라가 쌓인다. 올리가 움직임을 1초 멈추면 지금까지 모인 차크라의 [c_green]{0}x[/color]위력으로 주술을 시전한다.", valA[2]))],
    Id: [["Mengumpulkan chakra selagi bergerak. Jika Ollie berhenti bergerak selama 1 detik, gunakan semua chakra untuk mengeluarkan jutsu dengan kekuatan", string("[c_green]{0}[/color] berdasarkan akumulasi chakra.", valA[0])], ["Mengumpulkan chakra selagi bergerak. Jika Ollie berhenti bergerak selama 1 detik, gunakan semua chakra untuk mengeluarkan jutsu dengan kekuatan", string("[c_green]{0}[/color] berdasarkan akumulasi chakra.", valA[1])], ["Mengumpulkan chakra selagi bergerak. Jika Ollie berhenti bergerak selama 1 detik, gunakan semua chakra untuk mengeluarkan jutsu dengan kekuatan", string("[c_green]{0}[/color] berdasarkan akumulasi chakra.", valA[2])]]
});
name = "Undead";
data = variable_struct_get(SD, name);
valA1 = data.weight;
valB1 = data.duration;
CreateToolTip(name, 
{
    eng: "Undead",
    jp: "언데드",
    Id: "Undead"
}, 
{
    eng: [[string("If HP reaches 0, Ollie gains [c_red]Undead[/color] and can not die for {0} seconds (10s cooldown). However, each time this activates, Ollie loses [c_red]50%[/color] Max HP for", valB1), string("1 minute. Gain 2% ATK for every [c_green]{0}[/color] Max HP lost.", valA1[0])], [string("If HP reaches 0, Ollie gains [c_red]Undead[/color] and can not die for {0} seconds (10s cooldown). However, each time this activates, Ollie loses [c_red]50%[/color] Max HP for", valB1), string("1 minute. Gain 2% ATK for every [c_green]{0}[/color] Max HP lost.", valA1[1])], [string("If HP reaches 0, Ollie gains [c_red]Undead[/color] and can not die for {0} seconds (10s cooldown). However, each time this activates, Ollie loses [c_red]50%[/color] Max HP for", valB1), string("1 minute. Gain 2% ATK for every [c_green]{0}[/color] Max HP lost.", valA1[2])]],
    jp: [[JPAS(string("체력이 0이 되면, 올리는 [c_red]언데드[/color] 상태가 되어 {0}초간 죽을 수 없게 된다. (쿨타임 10초) 그러나 능력 발동시 1분간 최대 체력 [c_red]50%[/color]를 잃는다. 잃은 체력 [c_green]{1}[/color]당", valB1, valA1[0])), JPAS("공격력이 2% 증가한다.")], [JPAS(string("체력이 0이 되면, 올리는 [c_red]언데드[/color] 상태가 되어 {0}초간 죽을 수 없게 된다. (쿨타임 10초) 그러나 능력 발동시 1분간 최대 체력 [c_red]50%[/color]를 잃는다. 잃은 체력 [c_green]{1}[/color]당", valB1, valA1[1])), JPAS("공격력이 2% 증가한다.")], [JPAS(string("체력이 0이 되면, 올리는 [c_red]언데드[/color] 상태가 되어 {0}초간 죽을 수 없게 된다. (쿨타임 10초) 그러나 능력 발동시 1분간 최대 체력 [c_red]50%[/color]를 잃는다. 잃은 체력 [c_green]{1}[/color]당", valB1, valA1[2])), JPAS("공격력이 2% 증가한다.")]],
    Id: [[string("Jika HP mencapai 0, Ollie mendapatkan [c_red]Undead[/color] dan tidak bisa mati selama {0} detik (cooldown 10 detik). Namun, setiap kali ini aktif, Ollie", valB1), string("kehilangan [c_red]50%[/color] Max HP selama 1 menit. Mendapatkan 2% ATK untuk setiap [c_green]{0}[/color] Max HP yang hilang.", valA1[0])], [string("Jika HP mencapai 0, Ollie mendapatkan [c_red]Undead[/color] dan tidak bisa mati selama {0} detik (cooldown 10 detik). Namun, setiap kali ini aktif, Ollie", valB1), string("kehilangan [c_red]50%[/color] Max HP selama 1 menit. Mendapatkan 2% ATK untuk setiap [c_green]{0}[/color] Max HP yang hilang.", valA1[1])], [string("Jika HP mencapai 0, Ollie mendapatkan [c_red]Undead[/color] dan tidak bisa mati selama {0} detik (cooldown 10 detik). Namun, setiap kali ini aktif, Ollie", valB1), string("kehilangan [c_red]50%[/color] Max HP selama 1 menit. Mendapatkan 2% ATK untuk setiap [c_green]{0}[/color] Max HP yang hilang.", valA1[2])]]
});
name = "SimpOfAllTime";
data = variable_struct_get(SD, name);
valA = data.damage;
var valB = data.weight;
CreateToolTip(name, 
{
    eng: "Simp Of All Time",
    jp: "사상 최강의 극성팬",
    Id: "Simp Sepanjang Masa"
}, 
{
    eng: [[string("Targets can drop [c_holoblue]Hololive Merch[/color]. When picking up [c_holoblue]Hololive Merch[/color], Ollie takes 5 damage, but heal back the damage after 2 seconds and gain [c_green]{0}%[/color]", valB[0] * 100), "Haste and SPD for 8 seconds."], [string("Targets can drop [c_holoblue]Hololive Merch[/color]. When picking up [c_holoblue]Hololive Merch[/color], Ollie takes 5 damage, but heal back the damage after 2 seconds and gain [c_green]{0}%[/color]", valB[1] * 100), "Haste and SPD for 8 seconds."], [string("Targets can drop [c_holoblue]Hololive Merch[/color]. When picking up [c_holoblue]Hololive Merch[/color], Ollie takes 5 damage, but heal back the damage after 2 seconds and gain [c_green]{0}%[/color]", valB[2] * 100), "Haste and SPD for 8 seconds."]],
    jp: [JPAS(string("적이 [c_holoblue]홀로라이브 굿즈[/color]를 떨어뜨릴 수 있다. [c_holoblue]홀로라이브 굿즈[/color]를 주으면 올리는 피해를 5 입지만 2초 후 회복하고 이동/공격 속도가 8초간 [c_green]{0}%[/color] 증가한다.", valB[0] * 100)), JPAS(string("적이 [c_holoblue]홀로라이브 굿즈[/color]를 떨어뜨릴 수 있다. [c_holoblue]홀로라이브 굿즈[/color]를 주으면 올리는 피해를 5 입지만 2초 후 회복하고 이동/공격 속도가 8초간 [c_green]{0}%[/color] 증가한다.", valB[1] * 100)), JPAS(string("적이 [c_holoblue]홀로라이브 굿즈[/color]를 떨어뜨릴 수 있다. [c_holoblue]홀로라이브 굿즈[/color]를 주으면 올리는 피해를 5 입지만 2초 후 회복하고 이동/공격 속도가 8초간 [c_green]{0}%[/color] 증가한다.", valB[2] * 100))],
    Id: [["Target dapat menjatuhkan [c_holoblue]Hololive Merch[/color]. Saat mengambil [c_holoblue]Hololive Merch[/color], Ollie menerima 5 damage, tetapi menyembuhkan kembali damage tersebut", string("setelah 2 detik dan mendapatkan [c_green]{0}%[/color] Haste dan SPD selama 8 detik.", valB[0] * 100)], ["Target dapat menjatuhkan [c_holoblue]Hololive Merch[/color]. Saat mengambil [c_holoblue]Hololive Merch[/color], Ollie menerima 5 damage, tetapi menyembuhkan kembali damage tersebut", string("setelah 2 detik dan mendapatkan [c_green]{0}%[/color] Haste dan SPD selama 8 detik.", valB[1] * 100)], ["Target dapat menjatuhkan [c_holoblue]Hololive Merch[/color]. Saat mengambil [c_holoblue]Hololive Merch[/color], Ollie menerima 5 damage, tetapi menyembuhkan kembali damage tersebut", string("setelah 2 detik dan mendapatkan [c_green]{0}%[/color] Haste dan SPD selama 8 detik.", valB[2] * 100)]]
});
name = "WindMagic";
data = variable_struct_get(SD, name);
valA = data.haste;
valB = data.chance;
var valC = data.damage;
CreateToolTip(name, 
{
    eng: "Wind Magic",
    jp: "바람 마법",
    Id: "Sihir Angin"
}, 
{
    eng: [string("On crits, increase Haste by [c_green]{0}%[/color], up to {1}%. Additionally, there is a [c_green]{2}%[/color] chance to cast Wind Blast at the closest target dealing [c_green]{3}%[/color] damage.", valA[0], valA[0] * 20, valB[0], valC[0] * 100), string("On crits, increase Haste by [c_green]{0}%[/color], up to {1}%. Additionally, there is a [c_green]{2}%[/color] chance to cast Wind Blast at the closest target dealing [c_green]{3}%[/color] damage.", valA[0], valA[0] * 20, valB[1], valC[1] * 100), string("On crits, increase Haste by [c_green]{0}%[/color], up to {1}%. Additionally, there is a [c_green]{2}%[/color] chance to cast Wind Blast at the closest target dealing [c_green]{3}%[/color] damage.", valA[0], valA[0] * 20, valB[2], valC[2] * 100)],
    jp: [JPAS(string("치명타 공격 성공 시, 공격 속도를 [c_green]{0}%[/color], 최대 {1}% 올린다. 또한, [c_green]{2}%[/color] 확률로 윈드 블래스트를 근처 적에게 날려 [c_green]{3}%[/color] 피해를 준다.", valA[0], valA[0] * 20, valB[0], valC[0] * 100)), JPAS(string("치명타 공격 성공 시, 공격 속도를 [c_green]{0}%[/color], 최대 {1}% 올린다. 또한, [c_green]{2}%[/color] 확률로 윈드 블래스트를 근처 적에게 날려 [c_green]{3}%[/color] 피해를 준다.", valA[0], valA[0] * 20, valB[1], valC[1] * 100)), JPAS(string("치명타 공격 성공 시, 공격 속도를 [c_green]{0}%[/color], 최대 {1}% 올린다. 또한, [c_green]{2}%[/color] 확률로 윈드 블래스트를 근처 적에게 날려 [c_green]{3}%[/color] 피해를 준다.", valA[0], valA[0] * 20, valB[2], valC[2] * 100))],
    Id: [[string("Saat serangan critical, tingkatkan Haste sebesar [c_green]{0}%[/color], hingga {1}%. Selain itu, ada peluang [c_green]{2}%[/color] untuk melemparkan Wind Blast ke target terdekat dengan", valA[0], valA[0] * 20, valB[0]), string("damage [c_green]{0}%[/color].", valC[0] * 100)], [string("Saat serangan critical, tingkatkan Haste sebesar [c_green]{0}%[/color], hingga {1}%. Selain itu, ada peluang [c_green]{2}%[/color] untuk melemparkan Wind Blast ke target terdekat dengan", valA[0], valA[0] * 20, valB[1]), string("damage [c_green]{0}%[/color].", valC[1] * 100)], [string("Saat serangan critical, tingkatkan Haste sebesar [c_green]{0}%[/color], hingga {1}%. Selain itu, ada peluang [c_green]{2}%[/color] untuk melemparkan Wind Blast ke target terdekat dengan", valA[0], valA[0] * 20, valB[2]), string("damage [c_green]{0}%[/color].", valC[2] * 100)]]
});
name = "AttentionPlease";
data = variable_struct_get(SD, name);
valA = data.crit;
valB = data.distance;
valC = data.SPD;
CreateToolTip(name, 
{
    eng: "Attention Please",
    jp: "주목해 주세요!",
    Id: "Mohon Perhatiannya"
}, 
{
    eng: [string("Every 15 seconds, gain [c_green]{0}%[/color] Crit (max [c_green]{1}%[/color]) for each target within {2}px. Targets outside of {3}px get reduced {4}% SPD for 3 seconds.", valA[0], valA[0] * 10, valB, valB, valC), string("Every 15 seconds, gain [c_green]{0}%[/color] Crit (max [c_green]{1}%[/color]) for each target within {2}px. Targets outside of {3}px get reduced {4}% SPD for 3 seconds.", valA[1], valA[1] * 10, valB, valB, valC), string("Every 15 seconds, gain [c_green]{0}%[/color] Crit (max [c_green]{1}%[/color]) for each target within {2}px. Targets outside of {3}px get reduced {4}% SPD for 3 seconds.", valA[2], valA[2] * 10, valB, valB, valC)],
    jp: [JPAS(string("15초마다 {0}px 내의 적을 대상으로 치명타율 [c_green]{1}%[/color]가 상승한다. (최대 [c_green]{2}%[/color]) {3}px 밖의 적은 3초간 이동속도가 {4}% 감소한다.", valB, valA[0], valA[0] * 10, valB, valC)), JPAS(string("15초마다 {0}px 내의 적을 대상으로 치명타율 [c_green]{1}%[/color]가 상승한다. (최대 [c_green]{2}%[/color]) {3}px 밖의 적은 3초간 이동속도가 {4}% 감소한다.", valB, valA[1], valA[1] * 10, valB, valC)), JPAS(string("15초마다 {0}px 내의 적을 대상으로 치명타율 [c_green]{1}%[/color]가 상승한다. (최대 [c_green]{2}%[/color]) {3}px 밖의 적은 3초간 이동속도가 {4}% 감소한다.", valB, valA[2], valA[2] * 10, valB, valC))],
    Id: [string("Setiap 15 detik, dapatkan [c_green]]{0}%[/color] Crit (maks [c_green]{1}%[/color]) untuk setiap target dalam jarak {2}px. Target di luar jarak {3}px dikurangi {4} SPD selama 3 detik.", valA[0], valA[0] * 10, valB, valB, valC), string("Setiap 15 detik, dapatkan [c_green]]{0}%[/color] Crit (maks [c_green]{1}%[/color]) untuk setiap target dalam jarak {2}px. Target di luar jarak {3}px dikurangi {4} SPD selama 3 detik.", valA[1], valA[1] * 10, valB, valB, valC), string("Setiap 15 detik, dapatkan [c_green]]{0}%[/color] Crit (maks [c_green]{1}%[/color]) untuk setiap target dalam jarak {2}px. Target di luar jarak {3}px dikurangi {4} SPD selama 3 detik.", valA[2], valA[2] * 10, valB, valB, valC)]
});
name = "LadyOfPeafowl";
data = variable_struct_get(SD, name);
valA = data.maxStacks;
CreateToolTip(name, 
{
    eng: "Lady Of The Peafowl",
    jp: "공작 아가씨",
    Id: "Nona Merak"
}, 
{
    eng: [[string("When picking up HoloCoins, gain 1 [c_blue]Royal Tea[/color], increasing Crit Damage by 1% (max [c_green]{0}%[/color]) for 30 seconds. The duration recovers [c_green]1[/color] seconds each", valA[0]), "time Reine picks up more HoloCoins."], [string("When picking up HoloCoins, gain 1 [c_blue]Royal Tea[/color], increasing Crit Damage by 1% (max [c_green]{0}%[/color]) for 30 seconds. The duration recovers [c_green]2[/color] seconds each", valA[1]), "time Reine picks up more HoloCoins."], [string("When picking up HoloCoins, gain 1 [c_blue]Royal Tea[/color], increasing Crit Damage by 1% (max [c_green]{0}%[/color]) for 30 seconds. The duration recovers [c_green]3[/color] seconds each", valA[2]), "time Reine picks up more HoloCoins."]],
    jp: [JPAS(string("홀로코인을 주을 때, 30초간 치명타 공격력을 1% (최대 [c_green]{0}%[/color])증가시키는 [c_blue]로열 티[/color]를 획득한다. 레이네가 홀로코인을 획득할때마다 유지 시간을 [c_green][/color]초 회복한다.", valA[0])), JPAS(string("홀로코인을 주을 때, 30초간 치명타 공격력을 1% (최대 [c_green]{0}%[/color])증가시키는 [c_blue]로열 티[/color]를 획득한다. 레이네가 홀로코인을 획득할때마다 유지 시간을 [c_green]2[/color]초 회복한다.", valA[1])), JPAS(string("홀로코인을 주을 때, 30초간 치명타 공격력을 1% (최대 [c_green]{0}%[/color])증가시키는 [c_blue]로열 티[/color]를 획득한다. 레이네가 홀로코인을 획득할때마다 유지 시간을 [c_green]3[/color]초 회복한다.", valA[2]))],
    Id: [[string("Saat mengambil HoloCoin, dapatkan 1 [c_blue]Royal Tea[/color], Meningkatkan Damage Crit sebesar 1% (max [c_green]{0}%[/color]) untuk 30 detik. Durasinya bertambah [c_green]1[/color] detil", valA[0]), "tiap kali Reine mengambil HoloCoin."], [string("Saat mengambil HoloCoin, dapatkan 1 [c_blue]Royal Tea[/color], Meningkatkan Damage Crit sebesar 1% (max [c_green]{0}%[/color]) untuk 30 detik. Durasinya bertambah [c_green]2[/color] detil", valA[1]), "tiap kali Reine mengambil HoloCoin."], [string("Saat mengambil HoloCoin, dapatkan 1 [c_blue]Royal Tea[/color], Meningkatkan Damage Crit sebesar 1% (max [c_green]{0}%[/color]) untuk 30 detik. Durasinya bertambah [c_green]3[/color] detil", valA[2]), "tiap kali Reine mengambil HoloCoin."]]
});
name = "LivingWeapon";
data = variable_struct_get(SD, name);
valA = data.ATK;
valB = data.damage;
CreateToolTip(name, 
{
    eng: "Living Weapon",
    jp: "생체병기",
    Id: "Senjata Hidup"
}, 
{
    eng: [[string("Defeating targets may grant 1 stack of Sharpen (max 50). Every 10 stacks increases ATK by [c_green]{0}%[/color] and creates a Sharp Aura which deals [c_green]{1}%[/color] damage", valA[0] * 100, valB[0] * 100), "per 10 stacks to targets. When hit, Anya loses 5 stacks."], [string("Defeating targets may grant 1 stack of Sharpen (max 50). Every 10 stacks increases ATK by [c_green]{0}%[/color] and creates a Sharp Aura which deals [c_green]{1}%[/color] damage", valA[1] * 100, valB[1] * 100), "per 10 stacks to targets. When hit, Anya loses 5 stacks."], [string("Defeating targets may grant 1 stack of Sharpen (max 50). Every 10 stacks increases ATK by [c_green]{0}%[/color] and creates a Sharp Aura which deals [c_green]{1}%[/color] damage", valA[2] * 100, valB[2] * 100), "per 10 stacks to targets. When hit, Anya loses 5 stacks."]],
    jp: [[JPAS(string("적 처치시 날카로움 1스택이 증가한다. (최대 50스택) 10스택 당 공격력이 [c_green]{0}%[/color] 증가하고 [c_green]{1}%[/color] 공격력의 날카로운 아우라를 두른다. 피격 시 5스택 감소한다.", valA[0] * 100, valB[0] * 100)), JPAS("鋭いオーラを発生させる。被弾時、鋭さが１０レベル下がる。")], [JPAS(string("적 처치시 날카로움 1스택이 증가한다. (최대 50스택) 10스택 당 공격력이 [c_green]{0}%[/color] 증가하고 [c_green]{1}%[/color] 공격력의 날카로운 아우라를 두른다. 피격 시 5스택 감소한다.", valA[1] * 100, valB[1] * 100)), JPAS("鋭いオーラを発生させる。被弾時、鋭さが１０レベル下がる。")], [JPAS(string("적 처치시 날카로움 1스택이 증가한다. (최대 50스택) 10스택 당 공격력이 [c_green]{0}%[/color] 증가하고 [c_green]{1}%[/color] 공격력의 날카로운 아우라를 두른다. 피격 시 5스택 감소한다.", valA[2] * 100, valB[2] * 100)), JPAS("鋭いオーラを発生させる。被弾時、鋭さが１０レベル下がる。")]],
    Id: [[string("Mengalahkan target dapat memberi 1 tumpuk Sharpen (max 50). Tiap 10 tumpuk meningkatkan ATK sebesar [c_green]{0}%[/color] dan menciptakan Aura Tajam yang memberikan [c_green]{1}%[/color]", valA[0] * 100, valB[0] * 100), "damagetiap 10 tumpuk ke target. Saat terserang, Anya kehilangan 10 tumpuk."], [string("Mengalahkan target dapat memberi 1 tumpuk Sharpen (max 50). Tiap 10 tumpuk meningkatkan ATK sebesar [c_green]{0}%[/color] dan menciptakan Aura Tajam yang memberikan [c_green]{1}%[/color]", valA[1] * 100, valB[1] * 100), "damagetiap 10 tumpuk ke target. Saat terserang, Anya kehilangan 10 tumpuk."], [string("Mengalahkan target dapat memberi 1 tumpuk Sharpen (max 50). Tiap 10 tumpuk meningkatkan ATK sebesar [c_green]{0}%[/color] dan menciptakan Aura Tajam yang memberikan [c_green]{1}%[/color]", valA[2] * 100, valB[2] * 100), "damagetiap 10 tumpuk ke target. Saat terserang, Anya kehilangan 10 tumpuk."]]
});
name = "Slumber";
data = variable_struct_get(SD, name);
valA = data.SPD * 100;
valB = data.heal;
CreateToolTip(name, 
{
    eng: "Slumber",
    jp: "숙면",
    Id: "Tidur Panjang"
}, 
{
    eng: [[string("When not moving for over 1 second, reduce all targets' SPD by {0}%. Then, every 2 seconds Anya heals [c_green]{1}%[/color] HP and gain up to 10 stacks of [c_orange]Resting[/color],", valA, valB[0] * 100), "which reduces damage taken by 5% but also reduces all damage dealt by [c_red]7%[/color] each. After waking up, Anya can not sleep again for 2 seconds."], [string("When not moving for over 1 second, reduce all targets' SPD by {0}%. Then, every 2 seconds Anya heals [c_green]{1}%[/color] HP and gain up to 10 stacks of [c_orange]Resting[/color],", valA, valB[1] * 100), "which reduces damage taken by 5% but also reduces all damage dealt by [c_red]7%[/color] each. After waking up, Anya can not sleep again for 2 seconds."], [string("When not moving for over 1 second, reduce all targets' SPD by {0}%. Then, every 2 seconds Anya heals [c_green]{1}%[/color] HP and gain up to 10 stacks of [c_orange]Resting[/color],", valA, valB[2] * 100), "which reduces damage taken by 5% but also reduces all damage dealt by [c_red]7%[/color] each. After waking up, Anya can not sleep again for 2 seconds."]],
    jp: [[JPAS(string("1초 이상 움직이지 않으면 모든 대상의 이동속도를 {0}% 감소시킨다. 그 후 2초마다 아냐는 체력을 [c_green]{1}%[/color] 회복하고 최대 10스택의 [c_orange]휴식[/color]을 얻는다.", valA, valB[0] * 100)), JPAS("휴식은 개당 받는 피해량을 5% 낮추는 대신 모든 공격 피해량을 [c_red]7%[/color] 낮춘다. 잠에서 깨어나고 나면 2초간 다시 잠들지 못한다.")], [JPAS(string("1초 이상 움직이지 않으면 모든 대상의 이동속도를 {0}% 감소시킨다. 그 후 2초마다 아냐는 체력을 [c_green]{1}%[/color] 회복하고 최대 10스택의 [c_orange]휴식[/color]을 얻는다.", valA, valB[1] * 100)), JPAS("휴식은 개당 받는 피해량을 5% 낮추는 대신 모든 공격 피해량을 [c_red]7%[/color] 낮춘다. 잠에서 깨어나고 나면 2초간 다시 잠들지 못한다.")], [JPAS(string("1초 이상 움직이지 않으면 모든 대상의 이동속도를 {0}% 감소시킨다. 그 후 2초마다 아냐는 체력을 [c_green]{1}%[/color] 회복하고 최대 10스택의 [c_orange]휴식[/color]을 얻는다.", valA, valB[2] * 100)), JPAS("휴식은 개당 받는 피해량을 5% 낮추는 대신 모든 공격 피해량을 [c_red]7%[/color] 낮춘다. 잠에서 깨어나고 나면 2초간 다시 잠들지 못한다.")]],
    Id: [[string("Saat tidak bergerak selama lebih dari 1 detik, kurangi SPD semua target sebesar {0}%. Kemudian, setiap 2 detik Anya memulihkan [c_green]{1}%[/color] HP dan", valA, valB[0] * 100), "mendapatkan hingga 10 stack [c_orange]Resting[/color], yang mengurangi damage yang diterima sebesar 5% tetapi juga mengurangi semua damage yang diberikan", "sebesar [c_red]7%[/color]. Setelah bangun, Anya tidak bisa tidur lagi selama 3 detik."], [string("Saat tidak bergerak selama lebih dari 1 detik, kurangi SPD semua target sebesar {0}%. Kemudian, setiap 2 detik Anya memulihkan [c_green]{1}%[/color] HP dan", valA, valB[1] * 100), "mendapatkan hingga 10 stack [c_orange]Resting[/color], yang mengurangi damage yang diterima sebesar 5% tetapi juga mengurangi semua damage yang diberikan", "sebesar [c_red]7%[/color]. Setelah bangun, Anya tidak bisa tidur lagi selama 3 detik."], [string("Saat tidak bergerak selama lebih dari 1 detik, kurangi SPD semua target sebesar {0}%. Kemudian, setiap 2 detik Anya memulihkan [c_green]{1}%[/color] HP dan", valA, valB[2] * 100), "mendapatkan hingga 10 stack [c_orange]Resting[/color], yang mengurangi damage yang diterima sebesar 5% tetapi juga mengurangi semua damage yang diberikan", "sebesar [c_red]7%[/color]. Setelah bangun, Anya tidak bisa tidur lagi selama 3 detik."]]
});
name = "CuttingDeep";
data = variable_struct_get(SD, name);
valA = data.PUR;
valB = data.chance;
CreateToolTip(name, 
{
    eng: "Cutting Deep",
    jp: "후벼파기",
    Id: "Memotong Dalam"
}, 
{
    eng: [string("Increase Pick Up Range by [c_green]{0}%[/color]. If a target is within Anya's Pick Up Range, melee weapons have a [c_green]{1}%[/color] chance to hit twice.", valA[0], valB[0]), string("Increase Pick Up Range by [c_green]{0}%[/color]. If a target is within Anya's Pick Up Range, melee weapons have a [c_green]{1}%[/color] chance to hit twice.", valA[1], valB[1]), string("Increase Pick Up Range by [c_green]{0}%[/color]. If a target is within Anya's Pick Up Range, melee weapons have a [c_green]{1}%[/color] chance to hit twice.", valA[2], valB[2])],
    jp: [JPAS(string("획득 범위가 [c_green]{0}%[/color] 증가한다. 아냐의 획득 범위 내에 존재하는 대상에게 근접 무기는 [c_green]{1}%[/color]확률로 2번 공격한다.", valA[0], valB[0])), JPAS(string("획득 범위가 [c_green]{0}%[/color] 증가한다. 아냐의 획득 범위 내에 존재하는 대상에게 근접 무기는 [c_green]{1}%[/color]확률로 2번 공격한다.", valA[1], valB[1])), JPAS(string("획득 범위가 [c_green]{0}%[/color] 증가한다. 아냐의 획득 범위 내에 존재하는 대상에게 근접 무기는 [c_green]{1}%[/color]확률로 2번 공격한다.", valA[2], valB[2]))],
    Id: [string("Menambah Range Pick Up sebesar [c_green]{0}%[/color]. Jika target berada dalam Range Pick Up Anya, senjata jarak dekat memiliki peluang [c_green]{1}%[/color] untuk memukul dua kali.", valA[0], valB[0]), string("Menambah Range Pick Up sebesar [c_green]{0}%[/color]. Jika target berada dalam Range Pick Up Anya, senjata jarak dekat memiliki peluang [c_green]{1}%[/color] untuk memukul dua kali.", valA[1], valB[1]), string("Menambah Range Pick Up sebesar [c_green]{0}%[/color]. Jika target berada dalam Range Pick Up Anya, senjata jarak dekat memiliki peluang [c_green]{1}%[/color] untuk memukul dua kali.", valA[2], valB[2])]
});
name = "MaterialGrind";
data = variable_struct_get(SD, name);
valA = data.chance;
CreateToolTip(name, 
{
    eng: "Material Grind",
    jp: "수집 노가다",
    Id: "Material Grind"
}, 
{
    eng: [[string("Targets have a [c_green]{0}%[/color] chance to drop an Ore Deposit, which may be destroyed with Hammer Swing to drop Ore. Gaining 10 of a type of Ore will strengthen", valA[0]), "all weapons by 1, 2, or 3%."], [string("Targets have a [c_green]{0}%[/color] chance to drop an Ore Deposit, which may be destroyed with Hammer Swing to drop Ore. Gaining 10 of a type of Ore will strengthen", valA[1]), "all weapons by 1, 2, or 3%."], [string("Targets have a [c_green]{0}%[/color] chance to drop an Ore Deposit, which may be destroyed with Hammer Swing to drop Ore. Gaining 10 of a type of Ore will strengthen", valA[2]), "all weapons by 1, 2, or 3%."]],
    jp: [JPAS(string("적이 [c_green]{0}%[/color] 확률로 광맥을 드랍하고, 여기에 망치를 휘둘러 부수면 광석을 얻을 수 있다. 한 종류의 광석 10개를 모으면 모든 무기가 1%/2%/3% 강화된다.", valA[0])), JPAS(string("적이 [c_green]{0}%[/color] 확률로 광맥을 드랍하고, 여기에 망치를 휘둘러 부수면 광석을 얻을 수 있다. 한 종류의 광석 10개를 모으면 모든 무기가 1%/2%/3% 강화된다.", valA[1])), JPAS(string("적이 [c_green]{0}%[/color] 확률로 광맥을 드랍하고, 여기에 망치를 휘둘러 부수면 광석을 얻을 수 있다. 한 종류의 광석 10개를 모으면 모든 무기가 1%/2%/3% 강화된다.", valA[2]))],
    Id: [[string("Target memiliki [c_green]{0}%[/color] kemungkinan untuk menjatuhkan Deposit Bijih, yang dapat dihancurkan dengan Ayunan Palu dan menjatuhkan Bijih. Mendapat 10", valA[0]), "yang sama akan menguatkan semua senjata sebesar 1, 2, or 3%."], [string("Target memiliki [c_green]{0}%[/color] kemungkinan untuk menjatuhkan Deposit Bijih, yang dapat dihancurkan dengan Ayunan Palu dan menjatuhkan Bijih. Mendapat 10", valA[1]), "yang sama akan menguatkan semua senjata sebesar 1, 2, or 3%."], [string("Target memiliki [c_green]{0}%[/color] kemungkinan untuk menjatuhkan Deposit Bijih, yang dapat dihancurkan dengan Ayunan Palu dan menjatuhkan Bijih. Mendapat 10", valA[2]), "yang sama akan menguatkan semua senjata sebesar 1, 2, or 3%."]]
});
name = "NoPressure";
data = variable_struct_get(SD, name);
valA = data.damage;
valB = data.distance;
valC = data.debuff;
CreateToolTip(name, 
{
    eng: "No Pressure",
    jp: "노 프레져",
    Id: "Tanpa Tekanan"
}, 
{
    eng: [[string("Deals [c_green]{0}%[/color] damage to all targets within {1}px every 2 seconds and reduces their SPD by {2}%. Each time a target is hit by pressure within 4 seconds, ", valA[0] * 100, valB[0], valC * 100), "the damage is increased by 25% up to 10 times."], [string("Deals [c_green]{0}%[/color] damage to all targets within {1}px every 2 seconds and reduces their SPD by {2}%. Each time a target is hit by pressure within 4 seconds, ", valA[1] * 100, valB[1], valC * 100), "the damage is increased by 25% up to 10 times."], [string("Deals [c_green]{0}%[/color] damage to all targets within {1}px every 2 seconds and reduces their SPD by {2}%. Each time a target is hit by pressure within 4 seconds, ", valA[2] * 100, valB[2], valC * 100), "the damage is increased by 25% up to 10 times."]],
    jp: [[JPAS(string("2초마다 {0}px 내의 모든 적에게 [c_green]{1}%[/color] 피해를 준다. 4초 안에 적이 압박받으면 공격력이 {2}%, 최대 10번 증가한다.", valB[0], valA[0] * 100, valC * 100)), JPAS("まで２５％ずつ上昇する。")], [JPAS(string("2초마다 {0}px 내의 모든 적에게 [c_green]{1}%[/color] 피해를 준다. 4초 안에 적이 압박받으면 공격력이 {2}%, 최대 10번 증가한다.", valB[1], valA[1] * 100, valC * 100)), JPAS("まで２５％ずつ上昇する。")], [JPAS(string("2초마다 {0}px 내의 모든 적에게 [c_green]{1}%[/color] 피해를 준다. 4초 안에 적이 압박받으면 공격력이 {2}%, 최대 10번 증가한다.", valB[2], valA[2] * 100, valC * 100)), JPAS("まで２５％ずつ上昇する。")]],
    Id: [[string("Memberikan [c_green]{0}%[/color] damage pada semua target dalam jarak {1}px setiap 2 detik dan mengurangi SPD mereka sebesar {2}%. Setiap kali target terkena", valA[0] * 100, valB[0], valC * 100), "tekanan dalam waktu 4 detik, damage meningkat 25% sampai 10 kali."], [string("Memberikan [c_green]{0}%[/color] damage pada semua target dalam jarak {1}px setiap 2 detik dan mengurangi SPD mereka sebesar {2}%. Setiap kali target terkena", valA[1] * 100, valB[1], valC * 100), "tekanan dalam waktu 4 detik, damage meningkat 25% sampai 10 kali."], [string("Memberikan [c_green]{0}%[/color] damage pada semua target dalam jarak {1}px setiap 2 detik dan mengurangi SPD mereka sebesar {2}%. Setiap kali target terkena", valA[2] * 100, valB[2], valC * 100), "tekanan dalam waktu 4 detik, damage meningkat 25% sampai 10 kali."]]
});
name = "TheBlacksmith";
data = variable_struct_get(SD, name);
valA = data.damage;
valB = data.chance;
CreateToolTip(name, 
{
    eng: "The Blacksmith",
    jp: "대장장이",
    Id: "Si Pandai Besi"
}, 
{
    eng: [string("Drop [c_green]1[/color] Falling Anvil every 8 seconds onto a nearby target dealing [c_green]{0}%[/color] damage. There is a {1}% chance the Falling Anvil becomes Upgrade Anvil.", valA[0] * 100, valB[0]), string("Drop [c_green]2[/color] Falling Anvils every 8 seconds onto a nearby target dealing [c_green]{0}%[/color] damage. There is a {1}% chance the Falling Anvil becomes Upgrade Anvil.", valA[1] * 100, valB[1]), string("Drop [c_green]3[/color] Falling Anvils every 8 seconds onto a nearby target dealing [c_green]{0}%[/color] damage. There is a {1}% chance the Falling Anvil becomes Upgrade Anvil.", valA[2] * 100, valB[2])],
    jp: [JPAS(string("8초마다 떨어지는 모루를 [c_green]1[/color]개 소환해 [c_green]{0}%[/color] 피해를 준다. [c_green]{1}%[/color] 확률로 떨어진 모루가 강화 모루로 변한다.", valA[0] * 100, valB[0])), JPAS(string("8초마다 떨어지는 모루를 [c_green]2[/color]개 소환해 [c_green]{0}%[/color] 피해를 준다. [c_green]{1}%[/color] 확률로 떨어진 모루가 강화 모루로 변한다.", valA[1] * 100, valB[1])), JPAS(string("8초마다 떨어지는 모루를 [c_green]3[/color]개 소환해 [c_green]{0}%[/color] 피해를 준다. [c_green]{1}%[/color] 확률로 떨어진 모루가 강화 모루로 변한다.", valA[2] * 100, valB[2]))],
    Id: [string("Menjatuhkan Falling Anvil setiap 8 detik ke target terdekat yang memberikan damage [c_green]{0}%[/color]. Ada peluang {1} Falling Anvil menjadi Upgrade Anvil.", valA[0] * 100, valB[0]), string("Menjatuhkan Falling Anvil setiap 8 detik ke target terdekat yang memberikan damage [c_green]{0}%[/color]. Ada peluang {1} Falling Anvil menjadi Upgrade Anvil.", valA[1] * 100, valB[1]), string("Menjatuhkan Falling Anvil setiap 8 detik ke target terdekat yang memberikan damage [c_green]{0}%[/color]. Ada peluang {1} Falling Anvil menjadi Upgrade Anvil.", valA[2] * 100, valB[2])]
});
name = "SecretAgent";
data = variable_struct_get(SD, name);
valA = data.chance;
valB = data.multiplier;
valC = data.cooldown;
CreateToolTip(name, 
{
    eng: "Secret Agent",
    jp: "비밀 요원",
    Id: "Agen Rahasia"
}, 
{
    eng: [[string("Gain a buff that allows Zeta to dodge the next hit ({0}s cooldown). On dodge, Zeta turns invisible for 4 seconds. All damage dealt is increased by [c_green]{1}%[/color]", valC, valB[0] * 100), "any time Zeta is invisible."], [string("Gain a buff that allows Zeta to dodge the next hit ({0}s cooldown). On dodge, Zeta turns invisible for 4 seconds. All damage dealt is increased by [c_green]{1}%[/color]", valC, valB[1] * 100), "any time Zeta is invisible."], [string("Gain a buff that allows Zeta to dodge the next hit ({0}s cooldown). On dodge, Zeta turns invisible for 4 seconds. All damage dealt is increased by [c_green]{1}%[/color]", valC, valB[2] * 100), "any time Zeta is invisible."]],
    jp: [JPAS(string("다음 공격을 피할 수 있는 버프를 받는다. (쿨다운 {0}초) 공격을 피할 때 제타는 4초간 투명해지고, 모든 공격의 피해량은 [c_green]{1}%[/color] 증가한다.", valC, valB[0] * 100)), JPAS(string("다음 공격을 피할 수 있는 버프를 받는다. (쿨다운 {0}초) 공격을 피할 때 제타는 4초간 투명해지고, 모든 공격의 피해량은 [c_green]{1}%[/color] 증가한다.", valC, valB[1] * 100)), JPAS(string("다음 공격을 피할 수 있는 버프를 받는다. (쿨다운 {0}초) 공격을 피할 때 제타는 4초간 투명해지고, 모든 공격의 피해량은 [c_green]{1}%[/color] 증가한다.", valC, valB[2] * 100))],
    Id: [[string("Mendapatkan buff yang memungkinkan Zeta untuk menghindari serangan musuh berikutnya (cooldown {0} detik). Saat menghindar, Zeta menjadi tidak", valC), string("terlihat selama 4 detik. Semua damage yang diberikan meningkat sebesar [c_green]{0}%[/color] setiap saat Zeta tidak terlihat.", valB[0] * 100)], [string("Mendapatkan buff yang memungkinkan Zeta untuk menghindari serangan musuh berikutnya (cooldown {0} detik). Saat menghindar, Zeta menjadi tidak", valC), string("terlihat selama 4 detik. Semua damage yang diberikan meningkat sebesar [c_green]{0}%[/color] setiap saat Zeta tidak terlihat.", valB[1] * 100)], [string("Mendapatkan buff yang memungkinkan Zeta untuk menghindari serangan musuh berikutnya (cooldown {0} detik). Saat menghindar, Zeta menjadi tidak", valC), string("terlihat selama 4 detik. Semua damage yang diberikan meningkat sebesar [c_green]{0}%[/color] setiap saat Zeta tidak terlihat.", valB[2] * 100)]]
});
name = "CatReflexes";
data = variable_struct_get(SD, name);
valA = data.crit;
valB = data.crit2;
CreateToolTip(name, 
{
    eng: "Cat(?) Reflexes",
    jp: "고양이다운(?) 반응속도",
    Id: "Refleks Kucing(?)"
}, 
{
    eng: [string("While moving, Crit is increased by [c_green]{0}%[/color]. If Zeta is invisible, increase Crit by a further {1}%.", valA[0], valB), string("While moving, Crit is increased by [c_green]{0}%[/color]. If Zeta is invisible, increase Crit by a further {1}%.", valA[1], valB), string("While moving, Crit is increased by [c_green]{0}%[/color]. If Zeta is invisible, increase Crit by a further {1}%.", valA[2], valB)],
    jp: [JPAS(string("움직이는 동안 치명타 공격력이 [c_green]{0}%[/color] 증가한다. 투명화 시 {1}% 더 증가한다.", valA[0], valB)), JPAS(string("움직이는 동안 치명타 공격력이 [c_green]{0}%[/color] 증가한다. 투명화 시 {1}% 더 증가한다.", valA[1], valB)), JPAS(string("움직이는 동안 치명타 공격력이 [c_green]{0}%[/color] 증가한다. 투명화 시 {1}% 더 증가한다.", valA[2], valB))],
    Id: [string("Ketika bergerak, Crit ditambahkan sebesar [c_green]{0}%[/color]. Jika Zeta tak terlihat, Crit ditambahkan lagi sebesar 5%.", valA[0]), string("Ketika bergerak, Crit ditambahkan sebesar [c_green]{0}%[/color]. Jika Zeta tak terlihat, Crit ditambahkan lagi sebesar 5%.", valA[1]), string("Ketika bergerak, Crit ditambahkan sebesar [c_green]{0}%[/color]. Jika Zeta tak terlihat, Crit ditambahkan lagi sebesar 5%.", valA[2])]
});
name = "DataCollection";
data = variable_struct_get(SD, name);
valA = data.chance;
valB = data.bonusEXP;
CreateToolTip(name, 
{
    eng: "Data Collection",
    jp: "정보 수집",
    Id: "Pengumpulan Data"
}, 
{
    eng: [string("On critical hits, non-melee attacks have a [c_green]{0}%[/color] chance to hit {1}% additional EXP out of non-boss targets.", valA[0], valB[0] * 100), string("On critical hits, non-melee attacks have a [c_green]{0}%[/color] chance to hit {1}% additional EXP out of non-boss targets.", valA[1], valB[1] * 100), string("On critical hits, non-melee attacks have a [c_green]{0}%[/color] chance to hit {1}% additional EXP out of non-boss targets.", valA[2], valB[2] * 100)],
    jp: [JPAS(string("치명타 공격 성공 시 원거리 공격이 [c_green]{0}%[/color]확률로 일반 적에게서 50% 추가 경험치를 획득한다.", valA[0], valB[0] * 100)), JPAS(string("치명타 공격 성공 시 원거리 공격이 [c_green]{0}%[/color]확률로 일반 적에게서 50% 추가 경험치를 획득한다.", valA[1], valB[1] * 100)), JPAS(string("치명타 공격 성공 시 원거리 공격이 [c_green]{0}%[/color]확률로 일반 적에게서 50% 추가 경험치를 획득한다.", valA[2], valB[2] * 100))],
    Id: [string("Pada pukulan kritikal, serangan tidak berjarak dekat memiliki peluang [c_green]{0}%[/color] untuk mendapatkan {1}% EXP tambahan dari target yang bukan bos.", valA[0], valB[0] * 100), string("Pada pukulan kritikal, serangan tidak berjarak dekat memiliki peluang [c_green]{0}%[/color] untuk mendapatkan {1}% EXP tambahan dari target yang bukan bos.", valA[1], valB[1] * 100), string("Pada pukulan kritikal, serangan tidak berjarak dekat memiliki peluang [c_green]{0}%[/color] untuk mendapatkan {1}% EXP tambahan dari target yang bukan bos.", valA[2], valB[2] * 100)]
});
name = "RainCloud";
data = variable_struct_get(SD, name);
valA = data.number;
valB = data.damage;
CreateToolTip(name, 
{
    eng: "Rain Shaman",
    jp: "레인 샤먼",
    Id: "Pawang Hujan"
}, 
{
    eng: [string("Summons [c_green]{0}[/color] rain cloud that hovers around nearby enemies, raining and dealing constant [c_green]{1}%[/color] damage over time.", valA[0], valB[0] * 100), string("Summons [c_green]{0}[/color] rain clouds that hovers around nearby enemies, raining and dealing constant [c_green]{1}%[/color] damage over time.", valA[1], valB[1] * 100), string("Summons [c_green]{0}[/color] rain clouds that hovers around nearby enemies, raining and dealing constant [c_green]{1}%[/color] damage over time.", valA[2], valB[2] * 100)],
    jp: [JPAS(string("비구름 [c_green]{0}[/color]개를 소환한다. 비구름은 근처 적 주위를 떠다니며 지속적인 [c_green]{1}%[/color] 피해를 주는 비를 내린다.", valA[0], valB[0] * 100)), JPAS(string("비구름 [c_green]{0}[/color]개를 소환한다. 비구름은 근처 적 주위를 떠다니며 지속적인 [c_green]{1}%[/color] 피해를 주는 비를 내린다.", valA[1], valB[1] * 100)), JPAS(string("비구름 [c_green]{0}[/color]개를 소환한다. 비구름은 근처 적 주위를 떠다니며 지속적인 [c_green]{1}%[/color] 피해를 주는 비를 내린다.", valA[2], valB[2] * 100))],
    Id: [string("Memanggil [c_green]{0}[/color] awan hujan yang melayang di sekitar musuh di dekatnya, menghujani dan memberikan damage [c_green]{1}%[/color] secara konstan dari waktu ke waktu.", valA[0], valB[0] * 100), string("Memanggil [c_green]{0}[/color] awan hujan yang melayang di sekitar musuh di dekatnya, menghujani dan memberikan damage [c_green]{1}%[/color] secara konstan dari waktu ke waktu.", valA[1], valB[1] * 100), string("Memanggil [c_green]{0}[/color] awan hujan yang melayang di sekitar musuh di dekatnya, menghujani dan memberikan damage[c_green]{1}%[/color] secara konstan dari waktu ke waktu.", valA[2], valB[2] * 100)]
});
name = "Praise";
data = variable_struct_get(SD, name);
valA = data.ATK;
CreateToolTip(name, 
{
    eng: "Praise",
    jp: "칭찬",
    Id: "Pujian"
}, 
{
    eng: [[string("For every 1 HP healed or every second of not taking damage, Kobo gains [c_holoblue]Praise[/color]. When [c_holoblue]Praise[/color] is maxed, Kobo gains [c_green]{0}%[/color] ATK for 10 seconds and", valA[0] * 100), "[c_holoblue]Praise[/color] resets to 0. Kobo loses half [c_holoblue]Praise[/color] when taking damage."], [string("For every 1 HP healed or every second of not taking damage, Kobo gains [c_holoblue]Praise[/color]. When [c_holoblue]Praise[/color] is maxed, Kobo gains [c_green]{0}%[/color] ATK for 10 seconds and", valA[1] * 100), "[c_holoblue]Praise[/color] resets to 0. Kobo loses half [c_holoblue]Praise[/color] when taking damage."], [string("For every 1 HP healed or every second of not taking damage, Kobo gains [c_holoblue]Praise[/color]. When [c_holoblue]Praise[/color] is maxed, Kobo gains [c_green]{0}%[/color] ATK for 10 seconds and", valA[2] * 100), "[c_holoblue]Praise[/color] resets to 0. Kobo loses half [c_holoblue]Praise[/color] when taking damage."]],
    jp: [[JPAS(string("체력 회복 1/피해를 입지 않은 시간 1초 당 [c_holoblue]칭찬[/color]을 얻는다. [c_holoblue]칭찬[/color]을 최대로 채우면 공격력이 10초간 [c_green]{0}%[/color] 증가하고 [c_holoblue]칭찬[/color]이 0이 된다. 피격 시", valA[0] * 100)), JPAS("[c_holoblue]칭찬[/color]이 반감된다.")], [JPAS(string("체력 회복 1/피해를 입지 않은 시간 1초 당 [c_holoblue]칭찬[/color]을 얻는다. [c_holoblue]칭찬[/color]을 최대로 채우면 공격력이 10초간 [c_green]{0}%[/color] 증가하고 [c_holoblue]칭찬[/color]이 0이 된다. 피격 시", valA[1] * 100)), JPAS("[c_holoblue]칭찬[/color]이 반감된다.")], [JPAS(string("체력 회복 1/피해를 입지 않은 시간 1초 당 [c_holoblue]칭찬[/color]을 얻는다. [c_holoblue]칭찬[/color]을 최대로 채우면 공격력이 10초간 [c_green]{0}%[/color] 증가하고 [c_holoblue]칭찬[/color]이 0이 된다. 피격 시", valA[2] * 100)), JPAS("[c_holoblue]칭찬[/color]이 반감된다.")]],
    Id: [["Untuk setiap 1 HP yang dipulihkan atau setiap detik tidak terkena damage, Kobo mendapatkan [c_holoblue]Praise[/color]. Ketika [c_holoblue]Praise[/color] maksimal, Kobo mendapatkan", string("[c_green]{0}%[/color] ATK selama 10 detik dan [c_holoblue]Praise[/color] disetel ulang ke 0. Kobo kehilangan separuh [c_holoblue]Praise[/color] ketika menerima kerusakan.", valA[0] * 100)], ["Untuk setiap 1 HP yang dipulihkan atau setiap detik tidak terkena damage, Kobo mendapatkan [c_holoblue]Praise[/color]. Ketika [c_holoblue]Praise[/color] maksimal, Kobo mendapatkan", string("[c_green]{0}%[/color] ATK selama 10 detik dan [c_holoblue]Praise[/color] disetel ulang ke 0. Kobo kehilangan separuh [c_holoblue]Praise[/color] ketika menerima kerusakan.", valA[1] * 100)], ["Untuk setiap 1 HP yang dipulihkan atau setiap detik tidak terkena damage, Kobo mendapatkan [c_holoblue]Praise[/color]. Ketika [c_holoblue]Praise[/color] maksimal, Kobo mendapatkan", string("[c_green]{0}%[/color] ATK selama 10 detik dan [c_holoblue]Praise[/color] disetel ulang ke 0. Kobo kehilangan separuh [c_holoblue]Praise[/color] ketika menerima kerusakan.", valA[2] * 100)]]
});
name = "Tantrum";
data = variable_struct_get(SD, name);
valA = data.heal;
valB = data.damage;
CreateToolTip(name, 
{
    eng: "Tantrum",
    jp: "떼쓰기",
    Id: "Mengamuk"
}, 
{
    eng: [[string("When attacked, gain 1 Tantrum (max 10), and Kobo has a chance to heal {0}% HP while creating an extremely loud cry that deals [c_green]{1}%[/color] damage to all", valA * 100, valB[0] * 100), "targets. Each Tantrum stack increases the chance by 5%. Consume all stacks if effect is triggered."], [string("When attacked, gain 1 Tantrum (max 10), and Kobo has a chance to heal {0}% HP while creating an extremely loud cry that deals [c_green]{1}%[/color] damage to all", valA * 100, valB[1] * 100), "targets. Each Tantrum stack increases the chance by 5%. Consume all stacks if effect is triggered."], [string("When attacked, gain 1 Tantrum (max 10), and Kobo has a chance to heal {0}% HP while creating an extremely loud cry that deals [c_green]{1}%[/color] damage to all", valA * 100, valB[2] * 100), "targets. Each Tantrum stack increases the chance by 5%. Consume all stacks if effect is triggered."]],
    jp: [[JPAS(string("공격받았을 때, 떼쓰기 1스택(최대 10)이 쌓이고, 확률적으로 모든 대상에게 [c_green]400%[/color] 피해를 주는 괴성을 지르고 체력을 10% 회복한다.", valA * 100, valB[0] * 100)), JPAS("각 스택마다 발동 확률이 5% 증가한다. 발동 시 스택은 초기화된다.")], [JPAS(string("공격받았을 때, 떼쓰기 1스택(최대 10)이 쌓이고, 확률적으로 모든 대상에게 [c_green]400%[/color] 피해를 주는 괴성을 지르고 체력을 10% 회복한다.", valA * 100, valB[1] * 100)), JPAS("각 스택마다 발동 확률이 5% 증가한다. 발동 시 스택은 초기화된다.")], [JPAS(string("공격받았을 때, 떼쓰기 1스택(최대 10)이 쌓이고, 확률적으로 모든 대상에게 [c_green]400%[/color] 피해를 주는 괴성을 지르고 체력을 10% 회복한다.", valA * 100, valB[2] * 100)), JPAS("각 스택마다 발동 확률이 5% 증가한다. 발동 시 스택은 초기화된다.")]],
    Id: [[string("Saat diserang, dapatkan 1 Amukan (maksimal 10), dan Kobo memiliki kesempatan untuk memulihkan {0}% HP sambil menciptakan teriakan keras yang", valA * 100), string("memberikan [c_green]{0}%[/color] damage ke semua target. Setiap stack Amukan meningkatkan peluang sebesar 5%. Habiskan semua stack jika efeknya terpicu.", valB[0] * 100)], [string("Saat diserang, dapatkan 1 Amukan (maksimal 10), dan Kobo memiliki kesempatan untuk memulihkan {0}% HP sambil menciptakan teriakan keras yang", valA * 100), string("memberikan [c_green]{0}%[/color] damage ke semua target. Setiap stack Amukan meningkatkan peluang sebesar 5%. Habiskan semua stack jika efeknya terpicu.", valB[1] * 100)], [string("Saat diserang, dapatkan 1 Amukan (maksimal 10), dan Kobo memiliki kesempatan untuk memulihkan {0}% HP sambil menciptakan teriakan keras yang", valA * 100), string("memberikan [c_green]{0}%[/color] damage ke semua target. Setiap stack Amukan meningkatkan peluang sebesar 5%. Habiskan semua stack jika efeknya terpicu.", valB[2] * 100)]]
});
