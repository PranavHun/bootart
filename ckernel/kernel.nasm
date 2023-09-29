global _start 

_start:
[bits 32]
[extern kmain]
mov edx, 20

loop:
push edx
push edx
push 28
call kmain
pop edx
pop edx

test edx, edx
jz done
dec edx

; start delay

mov bp, 0x100
mov si, 0x100
delay2:
dec bp
nop
jnz delay2
dec si
cmp si,0    
jnz delay2
; end delay

jmp loop


done:
hlt
