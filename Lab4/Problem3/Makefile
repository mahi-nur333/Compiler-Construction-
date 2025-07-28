input = input.txt
output = output.txt

main:
	del *.tab.* lex.yy.c 2>nul
	bison -d cal.y
	flex cal.l
	gcc cal.tab.c lex.yy.c -o calc.exe
	calc.exe < $(input) > $(output) 2>&1