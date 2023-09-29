boot_minimal: 
	nasm -f bin -o build/boot_minimal boot_minimal.nasm

boot_keyboard_input: 
	nasm -f bin -o build/boot_keyboard_input boot_keyboard_input.nasm

boot_heart: 
	nasm -f bin -o build/boot_heart boot_heart.nasm

boot_read_disk: 
	nasm -f bin -o build/boot_read_disk boot_read_disk.nasm

boot_protected_mode: 
	nasm -f bin -o build/boot_protected_mode boot_protected_mode.nasm

boot_protected_mode_graphics: 
	nasm -f bin -o build/boot_protected_mode_graphics boot_protected_mode_graphics.nasm

boot_ckernel:
	nasm -f bin -o build/zeros.bin ckernel/zeros.nasm
	nasm -f bin -o build/boot_ckernel_header.bin boot_ckernel.nasm
	nasm -f elf32 -o build/kernel.o ckernel/kernel.nasm
	i386-elf-gcc -ffreestanding -m32 -g -c ckernel/main.c -o build/main.o
	i386-elf-ld -o build/full_kernel.bin -Ttext=0x1000 build/kernel.o build/main.o --oformat binary
	cat build/boot_ckernel_header.bin build/full_kernel.bin build/zeros.bin > build/boot_ckernel

clean :
	rm -f build/*