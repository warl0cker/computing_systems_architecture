;Se va scrie un program care preia un şir de caractere de la tastatură şi afişează şirul criptat prin translaţie de 4 (aduna 4 la codul fiecărui caracter).
.model small
.stack 100h
.data
    sir db 80 dup('$')
    m1 db 'Cripteaza textul incrementand fiecare caracter cu 4 pozitii in assembly',13,10,'$'
    m2 db 'Introduceti sirul:$'
    m3 db 'Sirul preluat de la tastatura este: ','$'
.code
    mov ax,@data
    mov ds,ax
    mov ah,9h
    mov dx,offset m1
    int 21h
    mov ah,9h
    mov dx,offset m2
    int 21h
    mov bx,0
    mov cx,80
    mov ah,3fh
    mov dx,offset sir
    int 21h
    mov si,offset sir
    et1: mov al,[si]
         cmp al,13
         jz sfarsit
         add al,4
         mov [si],al
         add si,1
         jmp et1
    sfarsit: mov al,9
             mov dx,offset sir
    mov ah,9h
    mov dx,offset m3
    int 21h
    mov ah,9h
    mov dx,offset sir
    int 21h
    mov ah,4ch
    int 21h
end