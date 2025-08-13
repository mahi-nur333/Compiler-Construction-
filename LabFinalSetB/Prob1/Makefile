input = input.txt
output = output.txt
main:
	bison -d cal.y
	flex cal.l
	gcc cal.tab.c lex.yy.c 
	a < $(input) > $(output)