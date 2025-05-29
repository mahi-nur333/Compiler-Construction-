CC = gcc
CFLAGS = -I.
DEPS = fibonacchimake.h
OBJS = fibonacchimake.o fibonacchifunc.o

all:
	gcc -o fibonacchi fibonacchi.c
	gcc -E fibonacchi.c > fibonacchi.i 
	gcc -S -masm=intel fibonacchi.i
	as -o fibonacchi.o fibonacchi.s
	objdump -M intel -d fibonacchi.o > fibonacchi.dump
	gcc -c -o fibonacchi.o fibonacchi.c
	objdump -M intel -d fibonacchi.o > fibonacchi2.dump

fibonacchimake: fibonacchimake.c fibonacchifunc.c
	gcc -o fibonacchimake fibonacchimake.c fibonacchifunc.c -I.

fibonacchimake2: hellomake.o fibonacchifunc.o
	$(CC) -o hellomake hellomake.o fibonacchifunc.o $(CFLAGS)

# hellomake.o: hellomake.c
# 	gcc -c -o hellomake.o hellomake.c -I.

# hellofunc.o: hellofunc.c
# 	gcc -c -o hellofunc.o hellofunc.c -I.
fibonacchimake3: $(OBJS)
	$(CC) -o $@ $^ $(CFLAGS)

%.o: %.c $(DEPS) 
	gcc -c -o $@ $< -I.

.PHONY: clean

clean:
	rm -f *.o

assembler:
	C:\masm32\bin\ml /c /coff /Cp prog1.asm
	C:\masm32\bin\link -entry:main /subsystem:console prog1.obj
	prog1