all:
	gcc -o array array.c
	gcc -E array.c > array.i
	gcc -S -masm=intel array.c -o array.s
	gcc -c array.s -o array.o
	objdump -M intel -d array.o > array.dump
	gcc -c array.c -o array.o
	objdump -M intel -d array.o > array2.dump
