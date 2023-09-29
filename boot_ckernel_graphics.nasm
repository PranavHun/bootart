[org 0x7c00]                            ; Offset memory by 0x7c00
KERNEL_ENTRY equ 0x1000
mov [BOOT_DISK], dl                     ; Move disk number to BOOT_DISK

xor ax, ax
mov ax, 0x13
int 0x10

xor ax, ax                          
mov es, ax
mov ds, ax
mov bp, 0x8000
mov sp, bp

; start putting in values:
mov bx, KERNEL_ENTRY ; kernel location bytes from origin address 7c00h (End of our kernel code)
mov dl, [BOOT_DISK]
mov ah, 0x02    ; int13h function 2
mov al, 20     ; we want to read 11 sectors 
              ; 1 - 0 - Boot 
              ; 2 - 0x500 - Kernel_Entry asm
              ; 3 - 0x1000 - Kernel C main
              ; 4 - 0x1500 - "
              ; 5 - 0x2000 - "
              ; 6 - padding - 0x10000 (to) prevent overreading
mov ch, 0     ; from cylinder number 0
mov cl, 2     ; the sector number 2 - second sector (starts from 1, not 0)
mov dh, 0     ; head number 0
int 0x13

jc error_reading_disk


CODE_SEG equ GDT_code - GDT_start       ; Label for length of Code part of Global Descriptor Table
DATA_SEG equ GDT_data - GDT_start       ; Label for length of Data part of Global Descriptor Table


cli                                     ; stop bios interrupts (to prevent messing while switching to 32 bit)
lgdt [GDTable]                          ; load the GDT

mov eax, cr0                            ; mov all bits from cr0 to eax
or eax, 1                               ; change lowest bit of eax to 1
mov cr0, eax                            ; move all bits of eax back to cr0
jmp CODE_SEG:start_protected_mode       ; Long Jump to protected mode code

error_reading_disk:
    mov ah, 0x0e                    ; 0Eh 	Write Character in TTY Mode.
    mov bx, error_message           ; pointer to variable defined below

    print_string:
    mov al, [bx]                    ; load byte from memlocation in bx
    cmp al, 0                       ; cmp for null termination
    je done_print_string            ; quit if al == 0
    int 0x10                        ; Interrupt 10h
    inc bx                          ; next mem address in memoryVariable
    jmp print_string                ; loop for next character

done_print_string:

jmp $                               ; Infinite Loop


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Data Section
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

GDT_start:                          ; after real mode
                                    ; 64-bit is filled from lowest to highest bit
                                    ; dd - double word(4 bytes), dw - word (2 bytes), db - byte (8 bits)
    GDT_null:
        dd 0x0                      ; null descriptor of 4 bytes
        dd 0x0                      ; null descriptor of 4 bytes - 64 bit (1)

    GDT_code:
        dw 0xffff                   ; Segment Limit (0-15 bits)
        dw 0x0                      ; Base Address (0-15 bits) - 32 bit (2)
        db 0x0                      ; Base Address (16-23)
        db 0b10011010               ; Present=1, 
                                    ;Ring Privilege - 00,
                                    ;Segment - 1(code/data) not system
                                    ;Type = 1010 (Execute = 1, 
                                                 ;Ring Protection = 0 only ring 0 can run it,
                                                 ;Read/Write = 1 - Code is readable,
                                                 ;Accessed bit = 0 - code is accessed by cpu or not. set by cpu)
        db 0b11001111               ;G - 1 - Granularity 
                                    ;D/B - 1 - size flag 32 bit
                                    ;L - 0 - long mode code flag not 64 bit
                                    ;Reserved - 0;
                                    ;Segment limit (16-19 bit)
        db 0x0                      ;Base address (24-31 bits) - all zeros

    GDT_data:
        dw 0xffff                   ; Segment Limit (0-15 bits)
        dw 0x0                      ; Base Address (0-15 bits) - 32 bit (2)
        db 0x0                      ; Base Address (16-23)
        db 0b10010010               ;Present=1, 
                                    ;Ring Privilege - 00,
                                    ;Segment - 1(code/data) not system
                                    ;Type = 0010 (Execute = 0 not executable, 
                                                 ;Direction bit = 0 data grows up,
                                                 ;Read/Write = 1 - Data is writable,
                                                 ;Accessed bit = 0 - data is accessed by cpu or not. set by cpu)
        db 0b11001111               ;G - 1 - Granularity 
                                    ;D/B - 1 - size flag 32 bit
                                    ;L - 0 - long mode code flag not 64 bit
                                    ;Reserved - 0;
                                    ;Segment limits (16-19bits)
        db 0x0                      ; Base address (24-31bits)

GDT_end:

GDTable:                            ;GDtable contains
    dw GDT_end - GDT_start - 1      ;total size of gdtable (64 null + 64 Code + 64 Data)
    dd GDT_start                    ;first addess of GDTable


error_message db "Error Reading Disk", 0
BOOT_DISK: db 0


[bits 32]                           ;Changed to 32 as start of 32 bit code
start_protected_mode:               ;Ring 0 sofar but out of real mode
    mov ax, DATA_SEG
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	
	mov ebp, 0x90000		; 32 bit stack base pointer
	mov esp, ebp
    mov eax, 0x02

   jmp KERNEL_ENTRY



times 510-($-$$) db 0              
dw 0xaa55
