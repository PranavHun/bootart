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


clean :
	rm -f build/*