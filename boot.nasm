[BITS 16]


boot:
        mov ah, 0x06    ;clears screen
        mov al, 0x00
        int 0x10

        mov ah, 0x00    ;sets video mode to 640x480 color
        mov al, 0x12
        int 0x10

        mov ah, 0x0C     ;draws a diagonal line
        mov al, 0x0D     ;color=Magenta
        mov bh, 0x01


        mov dx, 0x00
loopy:
        cmp dx, 0x1E0     ; y=480
        je done
        mov cx, 0x00
loopx:
;        mov dx, cx
        int 0x10
        cmp cx, 0x280      ; x=640
        je loopxdone
        inc cx
        jmp loopx
loopxdone:
        inc dx
        jmp loopy
done:
        jmp $

times 510-($-$$) db 0

db 0x55
db 0xaa
