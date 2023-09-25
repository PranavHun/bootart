[BITS 16]
boot:
mov ah, 0x06                    ; clear screen
mov al, 0x00                    ;
mov bh, 0x34                    ;display attribute - colors
mov ch, 0                       ;start row
mov cl,   0                     ;start col
mov dh,  24                     ;end of row
mov dl,  79                     ;end of col
int 0x10                        ;

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

mov ah, 0                       ; Wait for a keystroke
int 0x16

mov ah, 0x00            ; set video mode
mov al, 0x13            ; SVGA 320x200
int 0x10                ;

mov ah, 0x0C            ; Draw Pixel
mov al, 0x09            ; Color Light Blue
mov bh, 0x00            ; Page Number
mov cx, 101             ; pixel x
mov dx, 100             ; pixel y
int 0x10

mov cx, 103
mov dx, 100
int 0x10

mov cx, 100
mov dx, 101
int 0x10

mov cx, 101
mov dx, 101
int 0x10
mov cx, 102
mov dx, 101
int 0x10
mov cx, 103
mov dx, 101
int 0x10
mov cx, 104
mov dx, 101
int 0x10
mov cx, 101
mov dx, 102
int 0x10
mov cx, 102
mov dx, 102
int 0x10
mov cx, 103
mov dx, 102
int 0x10
mov cx, 102
mov dx, 103
int 0x10
jmp $

prompt:
db 10, 13, "Press any key to enter 320x200 SVGA Graphics Mode", 0              ; 0 is the null termination.


times 510-($-$$) db 0
db 0x55
db 0xaa

