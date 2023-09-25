[org 0x7c00]                    ; Memory Address is offset by 0x7c00
mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
mov bx, memoryVariable          ; pointer to variable defined below

print_string:
mov al, [bx]                    ; load byte from memlocation in bx
cmp al, 0                       ; cmp for null termination
je done_print_string            ; quit if al == 0
int 0x10                        ; Interrupt 10h
inc bl                          ; next mem address in memoryVariable
jmp print_string                ; loop for next character

done_print_string:

mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
                                ; Stays same for rest of the program
mov al, 'A'                     ; Start with 'A'
int 0x10                        ; Interrupt 10h
mov bl, 'Z' + 1                 ; Set end in bl register to 'Z' + 1

loop:
inc al                          ; increment al
cmp al, bl                      ; compare al, bl
je done                         ; if equal jump to label done
int 0x10                        ; call interuppt 10
jmp loop                        ; jump to label loop

done:


; BIOS Boot
jmp $                       ; Jump to current memory address

memoryVariable:
db "The letters of the English alphabet are : ", 0 ; 0 is the null termination.


times 510-($-$$) db 0       ; from current mem address to byte 510
                            ; fill with 0

db 0x55                     ; For booting magic number
                            ; byte 511 is 0x55 
db 0xaa                     ; byte 512 is 0xaa
