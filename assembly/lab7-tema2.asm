;Să se realizeze un program, în limbaj de asamblare, care afişază ordonat crescǎtor un şir de cifre preluate de la tastatură.
.model small
.stack 100
.data
    sir db 80 dup('$')
    m1 db 'Introduceti sirul: $'
    m2 db 'Sirul ordonat crescator este: $'
    min db 0,'$'
.code
    mov ax,@data
    mov ds,ax
    mov ah,9h
    mov dx,offset m1
    int 21h
    mov bx,0
    mov cx,80
    mov ah,3fh
    mov dx,offset sir
    int 21h
    iar: xor cl,cl
         mov si, offset sir
    parcurgere: mov ah,[si]
                cmp ah,13
                jz verificare
                mov al,[si+1]
                cmp al,13
                jz verificare
                cmp ah,al
                jle iter
                mov [si],al
                mov [si+1],ah
                mov cl,1
    iter: inc si
          jmp parcurgere
    verificare: cmp cl,1
                je iar
    mov ah,9
    mov dx,offset m2
    int 21h
    mov ah,9h
    mov dx,offset sir
    int 21h
    mov ah,4ch
    int 21h
end