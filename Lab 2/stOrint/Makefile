all:
	gcc -o stOrint stOrint.c
	gcc -E stOrint.c > stOrint.i
	gcc -S -masm=intel stOrint.c -o stOrint.s
	gcc -c stOrint.s -o stOrint.o
	objdump -M intel -d stOrint.o > stOrint.dump
	gcc -c stOrint.c -o stOrint.o
	objdump -M intel -d stOrint.o > stOrint2.dump
