; Scrieţi un program care preia de la tastatură un text şi un caracter şi
; afişază un mesaj corespunzător existenţei caracterului în şir («Există
; caracterul în şir» sau «Nu există caracterul în şir»)

.model small
.stack 100h
.data
	sir db 80 dup('$')
	m1 db 'Introduceti sirul: $'
	m2 db 13,10,'Introduceti un caracter: $'
	m3 db 13,10,'Nu exista caracterul in sir.$'
	m4 db 13,10,'Exista caracterul in sir.$'
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
	;afisare mesaj m2
	mov ah,9h
	mov dx,offset m2
	int 21h
	;preluare caracter de la tastatura (depunere in al)
	mov ah,1
	int 21h
	mov dx,offset m3
	mov si,offset sir
    next: mov ah,[si]
          cmp ah,13 ;comparam cu CR (sfarsit de sir)
          jz sfarsit
          cmp al,ah ;aparitie caracter in sir
          jnz cont
          mov dx,offset m4
          jmp sfarsit
    cont: inc si
          jmp next
    sfarsit: mov ah,9h
             int 21h
	;apel functie de terminare normala a programului
	mov ah,4ch
	int 21h
end ;terminare program