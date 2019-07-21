////////////////////////////////////////////////////////////////////////////////
//////////////////////////// OLLYDBG 2 TEST PROGRAM ////////////////////////////

////////////////////////////////////////////////////////////////////////////////
////////////// PREFERRED SETTINGS AND FIXES FOR BORLAND COMPILERS //////////////

#ifdef __BORLANDC__
  #pragma option -a1                   // Byte alignment
  #pragma option -K                    // Force unsigned characters!
  #pragma option -w-pin                // Disable "partially bracketed" warning
  // Redefinition of MAKELONG removes nasty warning under Borland Builder 4.0:
  // boolean OR in one row with arithmetical shift.
  #undef  MAKELONG
  #define MAKELONG(lo,hi) ((LONG)(((WORD)(lo))|(((DWORD)((WORD)(hi)))<<16)))
#endif

#define MAKEWP(lo,hi)  ((WPARAM)MAKELONG(lo,hi))
#define MAKELP(lo,hi)  ((LPARAM)MAKELONG(lo,hi))

#define LOINT(l)       ((signed short)((WORD)(l)))
#define HIINT(l)       ((signed short)(((DWORD)(l)>>16) & 0xFFFF))

#ifndef FIELD_OFFSET
  #define FIELD_OFFSET(type,field) ((LONG)&(((type *)0)->field))
#endif


////////////////////////////////////////////////////////////////////////////////
////////////////////////////// GLOBAL DEFINITIONS //////////////////////////////

#define recursive                      // Helps to understand software

#ifndef MAINPROG                       // A trick, define MAINPROG in main file
  #define unique extern
#else
  #define unique
#endif

// Note that some parts of OllyDbg rely on the fact that TEXTLEN is at least
// 256 bytes long.
#define TEXTLEN        256             // Max length of text string
#define DATALEN        4096            // Max length of data record (max 65535)
#define ARGLEN         1024            // Max length of argument string
#define MAXMULTIPATH   8192            // Max length of multiple selection
#define SHORTNAME      32              // Max length of short or module name

#define PAGESIZE       4096            // Memory granularity (page size)

typedef unsigned char  uchar;          // Unsigned character (byte)
typedef unsigned short ushort;         // Unsigned short
typedef unsigned int   uint;           // Unsigned integer
typedef unsigned long  ulong;          // Unsigned long

// I am frequently annoyed by the 'Comparing signed and unsigned values'
// warnings issued whenever I write 'if (i+sizeof(x)<j) ...' or similar.
#define sigsize(x)     ((signed)sizeof(x))


////////////////////////////////////////////////////////////////////////////////
////////////////////////////// ASSEMBLER ROUTINES //////////////////////////////

extern "C" void  Accessviolation(void);
extern "C" void  Zerodiv(void);
extern "C" void  Int3(void);
extern "C" ulong Pushflags(void);
extern "C" ulong Moveflags(void);
extern "C" void  Settrap(void);
extern "C" ulong Int2d(ulong u);
extern "C" ulong Intff(ulong u);
extern "C" void  Nirvana(void);
extern "C" void  Fzerodiv(void);


////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////// THREADS ////////////////////////////////////

LRESULT CALLBACK Threadwp(HWND hw,UINT msg,WPARAM wp,LPARAM lp);
ulong __stdcall Thread(void *parm);


////////////////////////////////////////////////////////////////////////////////
///////////////////////////////// MAIN WINDOW //////////////////////////////////

#define MAINDX         450             // Width of the main window
#define MAINDY         275             // Height of the main window

unique HINSTANCE hinst;                // Instance of the test program
unique COLORREF  btncolor;             // Button face color
unique HBRUSH    btnbrush;             // Button face brush
unique HWND      hmain;                // Main window
unique HWND      hmessage;             // Message line

void   Message(char *format,...);

