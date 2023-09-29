global _start 

_start:
[bits 32]
[extern kmain]
mov ebx, 5
mov ecx, 0

loop:

push ebx
push ecx
push ebx
push ecx

call kmain

pop ecx
pop ebx
pop ecx
pop ebx

cmp ecx, 200/5
je done
inc ecx


; start delay

mov bp, 0x50
mov si, 0x50
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
