[org 0x7c00]                            ; Offset memory by 0x7c00
      

mov [BOOT_DISK], dl                     ; Move disk number to BOOT_DISK

CODE_SEG equ GDT_code - GDT_start       ; Label for length of Code part of Global Descriptor Table
DATA_SEG equ GDT_data - GDT_start       ; Label for length of Data part of Global Descriptor Table

mov ah, 0x06                    ; clear screen
mov al, 0x00                    ;
mov bh, 0x34                    ;display attribute - colors
mov ch, 0                       ;start row
mov cl,   0                     ;start col
mov dh,  24                     ;end of row
mov dl,  79                     ;end of col
int 0x10                        ;


cli                                     ; stop bios interrupts (to prevent messing while switching to 32 bit)
lgdt [GDTable]                          ; load the GDT

mov eax, cr0                            ; mov all bits from cr0 to eax
or eax, 1                               ; change lowest bit of eax to 1
mov cr0, eax                            ; move all bits of eax back to cr0
jmp CODE_SEG:start_protected_mode       ; Long Jump to protected mode code

jmp $                                     

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


[bits 32]                           ;Changed to 32 as start of 32 bit code
start_protected_mode:               ;Ring 0 sofar but out of real mode
    mov bx, splash_message          ; pointer to variable defined below
    mov ah, 0x34
    mov ecx, 0xb87b2

    print_prompt:
        mov al, [bx]                    ; load byte from memlocation in bx
        cmp al, 0                       ; cmp for null termination
        je done_print_prompt            ; quit if al == 0
        mov [ecx], ax                   ; Interrupt 10h
        inc cx                          ; next mem address in memoryVariable
        inc cx                          ; next mem address in memoryVariable
        inc bx                          ; next mem address in memoryVariable
        jmp print_prompt                ; loop for next character

    done_print_prompt:

;    mov al, 'A'                     ;Now writing is done to the video mem not bios interrupts
;    mov ah, 0x34                    ;color White
;    mov [0xb8032], ax               ; write entire thing to special memory address
    jmp $                           ; jmp to end

BOOT_DISK: db 0                                     
splash_message: db "Welcome to the Protected Mode!", 0

times 510-($-$$) db 0              
dw 0xaa55
