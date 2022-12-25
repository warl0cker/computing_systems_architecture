;PARTE PRACTICǍ. Să se realizeze un program, în limbaj de asamblare, care afişază caracterul cu codul ASCII cel mai mare dintr-un şir de caractere preluate de la tastatură.
.model small
.stack 100

.data
    sir db 80 dup('$')
    m1 db 'Introduceti sirul:$'
    m2 db 13,10,'Cel mai mare caracter este: $'
    max db 0,'$'

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
          cmp al,13 ;comparam cu CR (sfarsit de sir)
          jz sfarsit
          cmp al,ah ;este
          jle nu
          mov ah,al
    nu: inc si
        jmp next
    sfarsit: mov bl,ah ;sau mov max,ah
             mov ah,9
             mov dx,offset m2
             int 21h
             mov dl,bl
             mov ah,2
             ;sau:
             ;mov dx,offset max
             ;mov ah,9
             int 21h

    ;apel functie de terminare normala a programului
    mov ah,4ch
    int 21h

;terminare program
end