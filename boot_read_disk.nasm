mov [BOOT_DISK], dl             ; Disk number is set at dl is moved to a byte

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
mov al, BOOT_DISK             ; Start with 'A'
int 0x10                        ; Interrupt 10h

; Read from 2nd second sector (after 512 bytes)
xor ax, ax    ; make sure ds is set to 0
mov ds, ax
cld
; start putting in values:
mov ah, 0x2    ; int13h function 2
mov al, 2     ; we want to read 63 sectors
mov ch, 0     ; from cylinder number 0
mov cl, 2     ; the sector number 2 - second sector (starts from 1, not 0)
mov dh, 0     ; head number 0
xor bx, bx
mov es, bx    ; es should be 0
mov bx, 0x7e00; 512bytes from origin address 7c00h (End of our kernel code)
int 0x13
jc error_reading
jmp 0x7e00

error_reading:
mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
mov al, 'N'
int 0x10                        ; Interrupt 10h



; BIOS Boot
;jmp $                              ; Jump to current memory address

memoryVariable:
db 13, 10, "Boot Disk Found at : ", 0 ; 0 is the null termination.

BOOT_DISK:
db 0

times 510-($-$$) db 0       ; from current mem address to byte 510
                            ; fill with 0

db 0x55                     ; For booting magic number
                            ; byte 511 is 0x55 
db 0xaa                     ; byte 512 is 0xaa

;Sector 1 starts at 513th byte and every sector is 512 bytes
mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
mov bx, SectorVariable          ; pointer to variable defined below

print_sectors:
mov al, [bx]                    ; load byte from memlocation in bx
cmp al, 0                       ; cmp for null termination
je done_print_sectors            ; quit if al == 0
int 0x10                        ; Interrupt 10h
inc bx                         ; next mem address in memoryVariable
jmp print_sectors                ; loop for next character

done_print_sectors:

SectorVariable:
db 13, 10, " Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. ", 0
