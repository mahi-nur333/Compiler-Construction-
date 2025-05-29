all:
	gcc -o odd odd.c
	gcc -E odd.c > odd.i
	gcc -S -masm=intel odd.c -o odd.s
	gcc -c odd.s -o odd.o
	objdump -M intel -d odd.o > odd.dump
	gcc -c odd.c -o odd.o
	objdump -M intel -d odd.o > odd2.dump