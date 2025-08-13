input = input.txt
output = output.txt

main: cal.y cal.l symtab.c symtab.h
	bison -d cal.y
	flex cal.l
	gcc cal.tab.c lex.yy.c symtab.c -o a.exe
	a < $(input) > $(output)


