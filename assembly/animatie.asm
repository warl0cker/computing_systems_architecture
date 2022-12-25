.model small
.stack 100
.data
    y1 dw 50
    x dw 50
    y2 dw 100
    l db 100                  ;lungime
    k db 50                   ;latime
    n db 150                  ;nr. de iteratii
.code
    mov ax,@data
    mov ds,ax
    mov ah,0h
    mov al,13h                ;comutare in modul grafic 13h (320 x 200)
    int 10h
    anim: mov al,5
          call dreptunghi     ;il desenez cu magenta (5)
          call delay
          mov al,0
          call dreptunghi     ;il "sterg" (il redesenez cu negru = 0)
          inc x
          dec n
          jnz anim
    mov ah,01h
    int 21h
    mov ah,0h
    mov al,3h                 ;comutare in modul text
    int 10h
    mov ah,4ch
    int 21h                   ;terminare normala program

    ;zona pentru proceduri
    dreptunghi: mov dx,y1
                mov cx,x
                mov bl,l      ;lungime linie
                mov ah,0ch
                mov bh,0
    ciclu1: int 10h           ;aprindere pixel de coordonate (cx,dx)
            push dx
            mov dx,y2
            int 10h
            pop dx
            inc cx
            dec bl
            jnz ciclu1
            mov bl,k          ;latime
    ciclu2: int 10h           ;aprinde pixel de coord (cx,dx)
            push cx
            mov cx,x
            int 10h
            pop cx
            inc dx
            dec bl
            jnz ciclu2
            int 10h
            ret
    delay: push cx
           push dx
           mov cx,0ffffh
    et1: dec cx
         mov dx,0ffffh
    et2: dec dx
         jnz et2
         jnz et1
         pop dx
         pop cx
         ret
end
