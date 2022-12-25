;Să se realizeze un program, în limbaj de asamblare, care afişază caracterul cu codul ASCII cel mai mic dintr-un şir de caractere preluate de la tastatură.
.model small
.stack 100

.data
    sir db 80 dup('$')
    m1 db 'Introduceti sirul:$'
    m2 db 13,10,'Cel mai mic caracter este: $'
    min db 0,'$'

.code
    ;initializare segment de date
    mov ax,@data
    mov ds,ax

    ;afisare mesaj m1
    mov ah,9h
    mov dx,offset m1
    int 21h

    ;preluare sir de la tastatura si depunere in memorie la adresa din dx
    mov bx,0
    mov cx,80
    mov ah,3fh
    mov dx,offset sir
    int 21h
    mov si,offset sir
    mov ah,[si]
    next: mov al,[si]
          ;comparam cu CR (sfarsit de sir)
		  cmp al,13
          jz sfarsit
          cmp ah,al
          jle nu
          mov ah,al
    nu: inc si
        jmp next
    sfarsit: mov min,ah
             mov ah,9
             mov dx,offset m2
             int 21h
             mov dl,bl
             mov dx,offset min
             mov ah,9
             int 21h

    ;apel functie de terminare normala a programului
    mov ah,4ch
    int 21h

; terminare program
end