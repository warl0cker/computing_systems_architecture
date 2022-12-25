title Sistem de verificare a validitatii parolei
.model small
.stack 100h
.data
    msg1 db 10,13,'[*] Introduceti parola: $'
    msg2 db 10,13,'  [+] Parola corecta! Bun Venit!$'
    msg3 db 10,13,'  [-] Parola Incorecta! Mai Incearca!',10,13,10,13,'[!] Sugestie: parola123$'
    string db 'parola123'                ;variable to store pre-defined password
    len equ ($-string)                   ;get length of "string"
    inst db 10 dup(0)                    ;variable to store input characters
.code
    mov cx,len                           ;take length of "string" in CX (count register)
    incepe:
        mov ax,@data                     ;initialise ds to point to start of the memory
        mov ds,ax                        ;set aside for storing of data
        mov dx,offset msg1               ;load the address of a msg1 string into DX
        mov ah,09h                       ;write msg1 to stdout
        int 21h                          ;call the interrupt with function code 9 in AH.
        mov si,00                        ;initialize SI (stack index). set SI at the beginning of the string
        sus:
            mov ah,08h                   ;keyboard input without echo. Same as function 01H but not echoed.
            int 21h                      ;call the interrupt with function code 8 in AH.
            cmp al,0dh                   ;compare if it's a line feed, then go to "next" 
            je jos                       ;if equal jump to eticheta jos
            mov [inst+si],al             ;otherwise, store the char in "inst" and get the next one
            mov dl,'*'                   ;character to display
            mov ah,02h                   ;write character to stdout
            int 21h                      ;call the interrupt with function code 2 in AH.
            inc si                       ;increment SI (stack index)
            jmp sus                      ;jump to eticheta sus
        jos:
            mov bx,00                    ;initialize BX. set BX at index '0'
            mov cx,len                   ;take length of "string" in CX (count register)
            dec cx                       ;decrement CX (count register)
        verifica:
            mov al,[inst+bx]             ;move in AL "inst" variable to compare final version
            mov dl,[string+bx]           ;move in DL "string" variable to be compared with inst
            cmp al,dl                    ;compare if "inst" is equal with "string"
            jnz sugestie                 ;if cmp not '0' then jump to sugestie
            inc bx                       ;increment base register
            loop verifica                ;jump to verifica (anti-redundant)
        corect:
            mov dx,offset msg2           ;Load the address of a msg2 string into DX
            mov ah,09h                   ;write msg2 to stdout
            int 21h                      ;call the interrupt with function code 9 in AH.
            jmp sfarsit                  ;jump to eticheta sfarsit
        sugestie:
            mov ah,09h                   ;write msg3 to stdout
            mov dx,offset msg3           ;Load the address of a msg3 string into DX
            int 21h                      ;call the interrupt with function code 9 in AH.
            jmp incepe                   ;jump to eticheta incepe
            loop sugestie                ;jump to eticheta sugestie (anti-redundant)
        sfarsit:
            mov ah,4c00h                 ;This is the proper DOS exit routine
            int 21h                      ;call the interrupt with function code 4C in AH.
    end incepe
end