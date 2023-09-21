boot: clean
	nasm -f bin boot.nasm
clean :
	rm -f boot
