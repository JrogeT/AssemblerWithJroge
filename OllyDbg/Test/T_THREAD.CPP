#define STRICT

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "test.h"

// Thread-related functions.

LRESULT _export CALLBACK Threadwp(HWND hw,UINT msg,WPARAM wp,LPARAM lp) {
  RECT rc;
  PAINTSTRUCT ps;
  HDC dc;
  switch (msg) {
    case WM_CREATE:
      break;
    case WM_ERASEBKGND:
      return 1;
    case WM_PAINT:
      dc=BeginPaint(hw,&ps);
      GetClientRect(hw,&rc);
      FillRect(dc,&rc,(HBRUSH)GetStockObject(WHITE_BRUSH));
      EndPaint(hw,&ps);
      break;
    case WM_CLOSE:
      DestroyWindow(hw); break;
    default: return DefWindowProc(hw,msg,wp,lp);
  };
  return 0L;
};

ulong _export __stdcall Thread(void *parm) {
  int threadindex;
  ulong t,u;
  char s[256];
  HWND hw;
  MSG msg;
  threadindex=*(int *)parm;
  sprintf(s,"Thread %i",threadindex);
  hw=CreateWindow(
    "MULTITHREAD",s,                   // Class name and title
    WS_OVERLAPPEDWINDOW|WS_CLIPCHILDREN|WS_VISIBLE,
    0,0,250,80,                        // Position and size of the window
    NULL,NULL,hinst,NULL);
  if (hw==NULL)
    ExitProcess(1);
  t=GetTickCount(); u=0;
  while (1) {
    // Check for incoming messages.
    if (PeekMessage(&msg,NULL,0,0,PM_REMOVE)) {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
      if (msg.message==WM_QUIT) break;
    };
    if (GetTickCount()>t+100) {
      u++; t=GetTickCount();
      sprintf(s,"Thread %i count %u",threadindex,u);
      SetWindowText(hw,s);
    };
    Sleep(1);
  };
  return threadindex;
};

