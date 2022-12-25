;EXERCIŢIU. Se va realiza următorul program în limbaj de asamblare. Preia un şir de caractere de la tastatură şi îl afisează
.model small
.stack 100h

.data
    ;sir de 80 de caractere ‘$’ reprezentate pe 1 octet
    sir db 80 dup('$')
    ;sir de caractere. 13 (0Dh) = Carriage return; 10 (0Ah) = Line feed; $ = terminatorul de sir
    m1 db 'Primul program in limbaj de asamblare',13,10,'$'
    m2 db 'Introduceti sirul:$'
    m3 db 'Sirul preluat de la tastatura este: ','$'

.code
    ;initializare segment de date
    mov ax,@data
    mov ds,ax
    
    ;afisare mesaj m1
    mov ah,9h
    mov dx,offset m1
    int 21h
    
    ;afisare mesaj m2
    mov ah,9h
    mov dx,offset m2
    int 21h
    
    ;preluare sir de la tastatura si depunere in memorie la adresa din dx
    mov bx,0                        ;valoarea 0 este pentru tastatura
    mov cx,80                       ;nr. octeti de citit
    mov ah,3fh
    mov dx,offset sir
    int 21h
    
    ;afisare mesaj m3
    mov ah,9h
    mov dx,offset m3
    int 21h
    
    ;afisare sir introdus
    mov ah,9h
    mov dx,offset sir
    int 21h
    
    ;apel functie de terminare normala a programului (controlul este redat sistemului de operare)
    mov ah,4ch
    int 21h

;terminare program
end