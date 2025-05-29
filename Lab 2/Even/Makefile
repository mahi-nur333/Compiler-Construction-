all:
	gcc -o even even.c
	gcc -E even.c > even.i
	gcc -S -masm=intel even.c -o even.s
	gcc -c even.s -o even.o
	objdump -M intel -d even.o > even.dump
	gcc -c even.c -o even.o
	objdump -M intel -d even.o > even2.dump
.