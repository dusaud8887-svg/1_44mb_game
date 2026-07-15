@echo off
setlocal
cd /d "%~dp0"

set "VSDEV=C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat"
where cl >nul 2>nul
if errorlevel 1 (
  if not exist "%VSDEV%" (
    echo Visual Studio Build Tools 2022 with Desktop C++ is required.
    exit /b 1
  )
  call "%VSDEV%" -arch=x64 -host_arch=x64 >nul || exit /b 1
)

if /i "%~1"=="clean" (
  if exist build rmdir /s /q build
  if exist out rmdir /s /q out
  exit /b 0
)

if not exist build mkdir build
if not exist out mkdir out

if /i "%~1"=="test" (
  cl /nologo /std:c11 /W4 /O2 /MT /DSELF_TEST src\echo144.c /Fe:build\selftest.exe /Fo:build\selftest.obj user32.lib gdi32.lib winmm.lib || exit /b 1
  build\selftest.exe || exit /b 1
  echo selftest: PASS
  exit /b 0
)

rem G2 comparison builds (docs/50_PRODUCTION.md s2). gun: fixed gun, no deck/shop. dummy: no contact damage.
if /i "%~1"=="gun" (
  cl /nologo /std:c11 /W4 /O1 /MT /DDEV_LOG /DFIXED_GUN /DUNICODE /D_UNICODE src\echo144.c /Fe:build\ECHO144_GUN.EXE /Fo:build\echo144_gun.obj /link /SUBSYSTEM:WINDOWS user32.lib gdi32.lib winmm.lib || exit /b 1
  echo comparison build: build\ECHO144_GUN.EXE
  exit /b 0
)

if /i "%~1"=="dummy" (
  cl /nologo /std:c11 /W4 /O1 /MT /DDEV_LOG /DNO_THREAT /DUNICODE /D_UNICODE src\echo144.c /Fe:build\ECHO144_DUMMY.EXE /Fo:build\echo144_dummy.obj /link /SUBSYSTEM:WINDOWS user32.lib gdi32.lib winmm.lib || exit /b 1
  echo comparison build: build\ECHO144_DUMMY.EXE
  exit /b 0
)

set "CFLAGS=/nologo /std:c11 /W4 /O1 /GL /Gy /Gw /GS /MT /DNDEBUG /DUNICODE /D_UNICODE"
set "LFLAGS=/link /SUBSYSTEM:WINDOWS /LTCG /OPT:REF,ICF /INCREMENTAL:NO /MAP:build\ECHO144.map user32.lib gdi32.lib winmm.lib"
set "OUTPUT=out\ECHO144.EXE"
if /i "%~1"=="debug" (
  set "CFLAGS=/nologo /std:c11 /W4 /Od /Zi /MTd /DDEV_LOG /DUNICODE /D_UNICODE"
  set "LFLAGS=/link /SUBSYSTEM:WINDOWS /DEBUG user32.lib gdi32.lib winmm.lib"
  set "OUTPUT=build\ECHO144_DEBUG.EXE"
)
if /i not "%~1"=="debug" (
  if exist out\ECHO144.pdb del /q out\ECHO144.pdb
  if exist out\ECHO144.ilk del /q out\ECHO144.ilk
)

cl %CFLAGS% src\echo144.c /Fe:%OUTPUT% /Fo:build\echo144.obj /Fd:build\echo144.pdb %LFLAGS% || exit /b 1
if /i "%~1"=="debug" (
  echo debug build: %OUTPUT%
  exit /b 0
)
for %%I in (out\ECHO144.EXE) do set SIZE=%%~zI
for /f %%S in ('powershell -NoProfile -Command "(Get-ChildItem '.\out' -File -Recurse | Measure-Object Length -Sum).Sum"') do set TOTAL=%%S
if %TOTAL% GTR 1474560 (
  echo contest size limit exceeded: %TOTAL%
  exit /b 1
)
echo ECHO144.EXE: %SIZE% bytes
echo submission total: %TOTAL% bytes
dumpbin /nologo /dependents out\ECHO144.EXE
powershell -NoProfile -Command "(Get-FileHash '.\out\ECHO144.EXE' -Algorithm SHA256).Hash" || exit /b 1
