        P586                           ; 32-bit instructions used!
        MODEL FLAT,C
        IDEAL

        SEGMENT _BSS DWORD PUBLIC USE32 'BSS'
        ALIGN 4
        ENDS _BSS

        SEGMENT _TEXT DWORD PUBLIC USE32 'CODE'
        PUBLICDLL Accessviolation,Zerodiv,Int3,Pushflags,Moveflags,Settrap
        PUBLICDLL Int2d,Intff,Nirvana,Fzerodiv

; void  Accessviolation(void) - attempts to read [00000000].
        PROC Accessviolation
        XOR EAX,EAX
        MOV EAX,[DWORD EAX]
        RET
        ENDP Accessviolation

; void  Int3(void) - executes INT3.
        PROC Int3
        DB 0CCh
        RET
        ENDP Int3

; void  Zerodiv(void) - division by 0.
        PROC Zerodiv
        MOV EAX,00000001
        MOV EDX,00000000
        MOV ECX,00000000
        DIV ECX
        RET
        ENDP Zerodiv

; ulong Pushflags(void) - after POP SS, pushes flags and pops them to return.
        PROC Pushflags
        PUSH SS
        POP SS
        PUSHFD
        POP EAX
        RET
        ENDP Pushflags

; ulong Moveflags(void) - after MOV SS, pushes flags and pops them to return.
        PROC Moveflags
        MOV AX,SS
        MOV SS,AX
        PUSHFD
        POP EAX
        RET
        ENDP Moveflags

; void Settrap(void) - sets Trap flag.
        PROC Settrap
        PUSHFD
        POP EAX
        OR EAX,00000100h
        PUSH EAX
        POPFD
        RET
        ENDP Settrap

; ulong Int2d(ulong u) - executes INT 2D, followed by INC.
        PROC Int2d
        ARG U
        MOV EAX,[DWORD U]
        INT 02Dh
        INC EAX
        NOP
        NOP
        RET
        ENDP Int2d

; ulong Intff(ulong u) - executes INT FF, followed by INC.
        PROC Intff
        ARG U
        MOV EAX,[DWORD U]
        INT 0FFh
        INC EAX
        NOP
        NOP
        RET
        ENDP Intff

; void  Nirvana(void) - executes JMP 123456.
        PROC Nirvana
        MOV EAX,123456h
        JMP EAX
        RET
        ENDP Nirvana

; void Fzerodiv(void) - executes 1.0:0.0.
        PROC Fzerodiv
        FLD1
        FLDZ
        FDIVP
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        INC EAX
        DEC EAX
        FSTP ST(0)
        RET
        ENDP Fzerodiv

        ENDS _TEXT
        END

