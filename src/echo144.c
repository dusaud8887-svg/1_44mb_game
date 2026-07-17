#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <mmsystem.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>
#include <assert.h>
#if defined(SELF_TEST) || defined(DEV_LOG)
#include <stdio.h>
#endif

#include "game.h"
#include "game.c"

#ifndef SELF_TEST
#include "render.c"
#include "win32.c"
#endif
