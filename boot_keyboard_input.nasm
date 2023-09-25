[org 0x7c00]                    ; Memory Address is offset by 0x7c00
mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
mov bx, prompt                  ; pointer to variable defined below

print_prompt:
mov al, [bx]                    ; load byte from memlocation in bx
cmp al, 0                       ; cmp for null termination
je done_print_prompt            ; quit if al == 0
int 0x10                        ; Interrupt 10h
inc bl                          ; next mem address in memoryVariable
jmp print_prompt                ; loop for next character

done_print_prompt:

mov bx, name                    ; Setup buffer to input character
mov cx, 0                       ; Allow only 20 Characters

input_name:
mov ah, 0                       ; interrupt 16h with ah=0 reads char
int 0x16                        ; interrupt 0x16 
cmp al, 0x0D                    ; check for enter key
je done_input_name
cmp cx, [name_len]              ; Allow only 20 Characters
je done_input_name
mov ah, 0x0e                    ; Print Charater
int 0x10                        ; interrup 0x10
mov [bx], al                    ; move character recorded at al to bx
inc bx                          ; increase pointer
inc cx                          ; increase letter counter
jmp input_name

done_input_name:

mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
mov bx, message                  ; pointer to variable defined below

print_message:
mov al, [bx]                    ; load byte from memlocation in bx
cmp al, 0                       ; cmp for null termination
je done_print_message           ; quit if al == 0
int 0x10                        ; Interrupt 10h
inc bl                          ; next mem address in memoryVariable
jmp print_message               ; loop for next character

done_print_message:

mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
mov bx, name                    ; pointer to variable defined below

print_name:
mov al, [bx]                    ; load byte from memlocation in bx
cmp al, 0                       ; cmp for null termination
je done_print_name              ; quit if al == 0
int 0x10                        ; Interrupt 10h
inc bl                          ; next mem address in memoryVariable
jmp print_name                  ; loop for next character

done_print_name:



; BIOS Boot
jmp $                                   ; Jump to current memory address


prompt:
db "Enter your name : ", 0              ; 0 is the null termination.

message:
db 10, 13, "Hello ", 0                          ; 0 is the null termination.

name:                                   ; Size 20+1(null) buffer to hold name
times 21 db 0
name_len:
db 20




times 510-($-$$) db 0       ; from current mem address to byte 510
                            ; fill with 0

db 0x55                     ; For booting magic number
                            ; byte 511 is 0x55 
db 0xaa                     ; byte 512 is 0xaa


