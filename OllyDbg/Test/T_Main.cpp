#define STRICT

#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#define MAINPROG                       // Place all globals in this object file
#include "test.h"

#define BTN_TEXT       0               // Plain text
#define BTN_THREAD     1001            // ID of Start thread button
#define BTN_SUSPEND    1002            // Suspend last created thread
#define BTN_SPAWN      1003            // Start new process
#define BTN_SPSUS      1004            // Start new process suspended
#define BTN_FATAL      1005            // Call to FatalExit()
#define BTN_CURRDIR    1006            // Get current directory
#define BTN_LOADDLL    1007            // Load ws2_32.dll
#define BTN_UNLDDLL    1008            // Unload ws2_32.dll
#define BTN_HANDLER    1010            // Activate exception handler
#define BTN_VEH        1011            // Install vectored handler
#define BTN_ACCESS     1012            // Memory access violation
#define BTN_ZERODIV    1013            // Division by 0
#define BTN_INT3       1014            // INT3 set by program
#define BTN_INTFF      1015            // Call INT ff
#define BTN_NIRVANA    1016            // Jump to nirvana
#define BTN_STACK      1017            // Stack overflow
#define BTN_FZERODIV   1018            // Floating division by 0
#define BTN_SETTRAP    1019            // Set Trap flag
#define BTN_PUSHFL     1020            // ID of POP SS/PUSHF button
#define BTN_MOVEFL     1021            // ID of MOV SS/PUSHF button
#define BTN_INT2D      1022            // Call INT 2D
#define BTN_DBGSA      1023            // Debug string in ASCII
#define BTN_DBGSW      1024            // Debug string in UNICODE
#define BTN_ALLOC      1025            // ZwAlloc(0)

#define BTN_EXIT       1999            // ID of Close button

#define CTRL_TEXT      2000            // Text message

typedef struct t_button {              // Descriptor of button
  int            id;                   // Identifier
  int            x0,y0,dx,dy;          // Position
  char           *name;                // Name of the button
} t_button;

static t_button  btnlist[] = {         // Buttons in the main window
  { BTN_TEXT,       5,     0,   200,   15,   "Processes and threads:" },
  { BTN_THREAD,     5,    15,   100,   22,   "Start thread" },
  { BTN_SUSPEND,  115,    15,   100,   22,   "Suspend last" },
  { BTN_SPAWN,    225,    15,   100,   22,   "New process" },
  { BTN_SPSUS,    335,    15,   100,   22,   "New suspended" },
  { BTN_FATAL,      5,    40,   100,   22,   "FatalExit()" },
  { BTN_CURRDIR,  115,    40,   100,   22,   "Current Dir" },
  { BTN_LOADDLL,  225,    40,   100,   22,   "Load ws2_32" },
  { BTN_UNLDDLL,  335,    40,   100,   22,   "Unload ws2_32" },
  { BTN_TEXT,       5,    65,   200,   15,   "Exceptions:" },
  { BTN_HANDLER,    5,    80,   100,   22,   "Set filter" },
  { BTN_VEH,      115,    80,   100,   22,   "Set VEH" },
  { BTN_ACCESS,   225,    80,   100,   22,   "Read [00000000]" },
  { BTN_ZERODIV,  335,    80,   100,   22,   "0 : 0" },
  { BTN_INT3,       5,   105,   100,   22,   "INT3" },
  { BTN_INTFF,    115,   105,   100,   22,   "INT ff" },
  { BTN_NIRVANA,  225,   105,   100,   22,   "JMP 123456" },
  { BTN_STACK,    335,   105,   100,   22,   "Stack overflow" },
  { BTN_FZERODIV,   5,   130,   100,   22,   "1.0 : 0.0" },
  { BTN_SETTRAP,  115,   130,   100,   22,   "Set Trap" },
  { BTN_TEXT,       5,   155,   200,   15,   "Debugging:" },
  { BTN_PUSHFL,     5,   170,   100,   22,   "POP SS/PUSHF" },
  { BTN_MOVEFL,   115,   170,   100,   22,   "MOV SS/PUSHF" },
  { BTN_INT2D,    225,   170,   100,   22,   "INT 2D" },
  { BTN_DBGSA,    335,   170,   100,   22,   "String A" },
  { BTN_DBGSW,      5,   195,   100,   22,   "String W" },
  { BTN_ALLOC,    115,   195,   100,   22,   "ZwAlloc(0)" },
  { BTN_EXIT,     335,   223,   100,   22,   "Close" }
};

static int       nthread;              // Actual number of thread starts
static HANDLE    lastthread;           // Handle of last started thread
static HINSTANCE ntdll;                // Instance of ntdll.dll
static HINSTANCE kernel32;             // Instance of kernel32.dll
static HINSTANCE ws232;                // Instance of ws2_32.dll

void Message(char *format,...) {
  char s[TEXTLEN];
  va_list ap;
  if (format==NULL || format[0]=='\0')
    SetDlgItemText(hmain,CTRL_TEXT,"");
  else {
    va_start(ap,format);
    vsprintf(s,format,ap);
    SetDlgItemText(hmain,CTRL_TEXT,s);
    va_end(ap);
  };
};

// Custom exception filter, called when OS detects critical error. Note: will
// not work on stack overflow.
long __stdcall Exceptionfilter(EXCEPTION_POINTERS *xp) {
  ulong addr,except;
  char s[256];
  if (xp==NULL)
    return EXCEPTION_CONTINUE_SEARCH;  // He's completely crasy, what?
  addr=(ulong)xp->ExceptionRecord->ExceptionAddress;
  except=xp->ExceptionRecord->ExceptionCode;
  sprintf(s,"Exception %08X at address %08X\nException is not "
    "processed, next handler will be called.",except,addr);
  MessageBox(hmain,s,"Exception",MB_ICONERROR|MB_OK);
  return EXCEPTION_CONTINUE_SEARCH;
};

// Vectored Exception Handler routine. See how it differs from the filter above?
long CALLBACK Vectoredhandler(EXCEPTION_POINTERS *xp) {
  ulong addr,except;
  char s[256];
  if (xp==NULL)
    return EXCEPTION_CONTINUE_SEARCH;  // He's completely crasy, what?
  addr=(ulong)xp->ExceptionRecord->ExceptionAddress;
  except=xp->ExceptionRecord->ExceptionCode;
  sprintf(s,"Exception %08X at address %08X.\nException is not "
    "processed, next handler will be called.",except,addr);
  MessageBox(hmain,s,"Vectored Exception",MB_ICONERROR|MB_OK);
  return EXCEPTION_CONTINUE_SEARCH;
};

// Causes stack overflow.
void Stackoverflow(int a,int b,int c,int d) {
  Stackoverflow(a+1,b+1,c+1,d+1);
};

// Windows procedure of the main window.
LRESULT CALLBACK Mainwp(HWND hw,UINT msg,WPARAM wp,LPARAM lp) {
  ulong u,len,threadid,status;
  char path[MAX_PATH];
  void *handler;
  RECT rc;
  PAINTSTRUCT ps;
  STARTUPINFO si;
  PROCESS_INFORMATION pi;
  HDC dc;
  ulong (WINAPI *zwalloc)(HANDLE ProcessHandle,PVOID *BaseAddress,
    ULONG_PTR ZeroBits,PSIZE_T RegionSize,ULONG AllocationType,ULONG Protect);
  void *(WINAPI *addveh)(ULONG first,
    long (CALLBACK *handler)(EXCEPTION_POINTERS *));
  switch (msg) {
    case WM_CREATE:
      break;
    case WM_DESTROY:
      PostQuitMessage(0);
      ExitProcess(0);
      break;
    case WM_ERASEBKGND:
      return 1;
    case WM_PAINT:
      dc=BeginPaint(hw,&ps);
      GetClientRect(hw,&rc);
      FillRect(dc,&rc,btnbrush);
      EndPaint(hw,&ps);
      break;
    case WM_COMMAND:
      switch (LOWORD(wp)) {
        case BTN_THREAD:
          nthread++;
          // Oh how bad, how bad, I never close this handle!..
          lastthread=CreateThread(NULL,0,Thread,&nthread,0,&threadid);
          break;
        case BTN_SUSPEND:
          if (lastthread!=NULL)
            SuspendThread(lastthread);
          break;
        case BTN_SPAWN:
          GetModuleFileName(NULL,path,MAX_PATH);
          memset(&si,0,sizeof(si));
          si.cb=sizeof(si);
          CreateProcess(path,NULL,NULL,NULL,0,0,
            NULL,NULL,&si,&pi);
          break;
        case BTN_SPSUS:
          GetModuleFileName(NULL,path,MAX_PATH);
          memset(&si,0,sizeof(si));
          si.cb=sizeof(si);
          CreateProcess(path,NULL,NULL,NULL,0,CREATE_SUSPENDED,
            NULL,NULL,&si,&pi);
          break;
        case BTN_FATAL:
          FatalExit(0);
          break;
        case BTN_CURRDIR:
          GetCurrentDirectory(MAX_PATH,path);
          Message("%s",path);
          break;
        case BTN_LOADDLL:
          ws232=LoadLibrary("ws2_32.dll");
          Message("Load: %s",ws232==NULL?"failure":"success");
          break;
        case BTN_UNLDDLL:
          status=FreeLibrary(ws232);
          Message("Unload: %s",status?"success":"failure");
          break;
        case BTN_HANDLER:
          SetUnhandledExceptionFilter(Exceptionfilter);
          break;
        case BTN_VEH:
          (FARPROC)addveh=GetProcAddress(kernel32,
            "AddVectoredExceptionHandler");
          if (addveh!=NULL) {
            handler=addveh(1,Vectoredhandler);
            Message("Handler=%08X",(ulong)handler);
            EnableWindow((HWND)lp,0); };
          break;
        case BTN_ACCESS:
          Accessviolation();
          break;
        case BTN_ZERODIV:
          Zerodiv();
          break;
        case BTN_INT3:
          Int3();
          break;
        case BTN_INTFF:
          u=Intff(0);
          Message("%08X (expected 1)",u);
          break;
        case BTN_NIRVANA:
          Nirvana();
          break;
        case BTN_STACK:
          Stackoverflow(0,0,0,0);
          break;
        case BTN_FZERODIV:
          Fzerodiv();
          break;
        case BTN_SETTRAP:
          Settrap();
          break;
        case BTN_PUSHFL:
          u=Pushflags();
          Message("%08X%s",u,(u & 0x100?" (T bit set)":""));
          break;
        case BTN_MOVEFL:
          u=Moveflags();
          Message("%08X%s",u,(u & 0x100?" (T bit set)":""));
          break;
        case BTN_INT2D:
          u=Int2d(0);
          Message("%08X (expected 1)",u);
          break;
        case BTN_DBGSA:
          OutputDebugStringA("Debug string (ASCII)");
          break;
        case BTN_DBGSW:
          OutputDebugStringW(L"Debug string (UNICODE)");
          break;
        case BTN_ALLOC:
          u=0x0001;
          len=0x0FFF;
          (FARPROC)zwalloc=GetProcAddress(ntdll,"ZwAllocateVirtualMemory");
          if (zwalloc!=NULL) {
            status=zwalloc(GetCurrentProcess(),(void **)&u,0,&len,
              MEM_RESERVE|MEM_COMMIT|MEM_TOP_DOWN,PAGE_EXECUTE_READWRITE);
            Message("Addr=%08X Size=%X Status=%X",u,len,status);
            if (status==0) strcpy((void *)0,
              "This is a memory block located at address NULL!");
            EnableWindow((HWND)lp,0); };
          break;
        case BTN_EXIT:
          SendMessage(hmain,WM_CLOSE,0,0);
          break;
        default: break; };
      break;
    case WM_CLOSE:
      DestroyWindow(hw); break;
    default: return DefWindowProc(hw,msg,wp,lp);
  };
  return 0L;
};

// Main program.
int PASCAL WinMain(HINSTANCE hi,HINSTANCE hprev,LPSTR cmdline,int show) {
  int i;
  char s[256];
  MSG msg;
  WNDCLASS wc;
  HWND hw;
  // Initialize variables.
  hinst=hi;
  nthread=0;
  // Allocate resources.
  btncolor=GetSysColor(COLOR_BTNFACE);
  btnbrush=CreateSolidBrush(btncolor);
  // Register class of main window.
  wc.style=CS_HREDRAW|CS_VREDRAW;
  wc.lpfnWndProc=Mainwp;
  wc.cbClsExtra=wc.cbWndExtra=0;
  wc.hInstance=hinst;
  wc.hIcon=NULL;
  wc.hCursor=LoadCursor(NULL,IDC_ARROW);
  wc.hbrBackground=NULL;
  wc.lpszMenuName=NULL;
  wc.lpszClassName="OLLY2TEST";
  RegisterClass(&wc);
  // Register class of thread window.
  wc.style=CS_HREDRAW|CS_VREDRAW;
  wc.lpfnWndProc=Threadwp;
  wc.cbClsExtra=wc.cbWndExtra=0;
  wc.hInstance=hinst;
  wc.hIcon=NULL;
  wc.hCursor=LoadCursor(NULL,IDC_ARROW);
  wc.hbrBackground=btnbrush;
  wc.lpszMenuName=NULL;
  wc.lpszClassName="MULTITHREAD";
  RegisterClass(&wc);
  // Create main window.
  hmain=CreateWindow("OLLY2TEST","Test application for OllyDbg v2",
    WS_OVERLAPPED|WS_BORDER|WS_VISIBLE|WS_CLIPCHILDREN,
    CW_USEDEFAULT,CW_USEDEFAULT,MAINDX,MAINDY,
    NULL,NULL,hinst,NULL);
  // Create fixed controls.
  hmessage=CreateWindowEx(WS_EX_CLIENTEDGE,"EDIT","",
    WS_CHILD|WS_VISIBLE|ES_READONLY,
    5,223,320,22,
    hmain,(HMENU)CTRL_TEXT,hinst,NULL);
  // Fill it with buttons.
  for (i=0; i<sizeof(btnlist)/sizeof(btnlist[0]); i++) {
    if (btnlist[i].id==BTN_TEXT)
      hw=CreateWindow("STATIC",btnlist[i].name,
      WS_CHILD|WS_VISIBLE|SS_LEFT,
      btnlist[i].x0,btnlist[i].y0,btnlist[i].dx,btnlist[i].dy,
      hmain,NULL,hinst,NULL);
    else
      hw=CreateWindow("BUTTON",btnlist[i].name,
      WS_CHILD|WS_VISIBLE|BS_PUSHBUTTON,
      btnlist[i].x0,btnlist[i].y0,btnlist[i].dx,btnlist[i].dy,
      hmain,(HMENU)btnlist[i].id,hinst,NULL);
    SendMessage(hw,WM_SETFONT,(WPARAM)GetStockObject(ANSI_VAR_FONT),0);
  };
  // Display command line.
  if (cmdline[0]!='\0') {
    sprintf(s,"Cmdline: %.200s",cmdline);
    SetDlgItemText(hmain,CTRL_TEXT,s); };
  ntdll=LoadLibrary("ntdll.dll");
  kernel32=LoadLibrary("kernel32.dll");
  // Main loop.
  while (1) {
    // Check for incoming messages.
    if (PeekMessage(&msg,NULL,0,0,PM_REMOVE)) {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
      if (msg.message==WM_QUIT) break; }
    else
      Sleep(1);
    ;
  };
  // Clean up.
  FreeLibrary(kernel32);
  FreeLibrary(ntdll);
  DeleteObject(btnbrush);
  UnregisterClass("OLLY2TEST",hinst);
  return 0;
};

