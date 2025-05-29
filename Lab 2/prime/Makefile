all:
	gcc -o prime prime.c

	gcc -E prime.c > prime.i

	gcc -S -masm=intel prime.c -o prime.s

	gcc -c prime.s -o prime.o

	objdump -M intel -d prime.o > prime.dump

	gcc -c prime.c -o prime.o
	objdump -M intel -d prime.o > prime2.dump
