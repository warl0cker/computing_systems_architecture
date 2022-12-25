; Studiu INT 10h (v. https://en.wikipedia.org/wiki/INT_10H). Se va identifica funcţia de
; schimbare a modului de lucru de afişare. Se va identifica funcţia cu care se aprinde un
; pixel pe ecran.
; Studiaţi următorul program

.model small
.stack 100h
.data
    a dw 0
    b dw 0
    c dw 0
    d dw 0
.code
    mov ax,@data
    mov ds,ax
    mov ah,0h
    mov al,13h
    int 10h
    mov ah ,01h
    int 21h
    mov a,50
    mov b,150
    mov d,100
    mov c,210
ciclu_1: mov ah,0ch
         mov bh,0h
         mov dx,a
         mov cx,b
         mov al,5
         int 10h
         mov ah,0ch
         mov bh,0h
         mov dx,a
         mov cx,c
         mov al,2
         int 10h
         inc a
         cmp a,150
         jne ciclu_1
         mov a,50
         mov b,150
         mov d,150
         mov c,210
ciclu_2: mov ah,0ch
         mov bh,0h
         mov dx,a
         mov cx,b
         mov al,3
         int 10h
         mov ah,0ch
         mov bh,0h
         mov dx,d
         mov cx,b
         mov al,4
         int 10h
         inc b
         cmp b,210
         jne ciclu_2
         mov ah,01h
         int 21h
         mov ah,0h
         mov al,3h
         int 10h
         mov ah,4ch
         int 21h
end