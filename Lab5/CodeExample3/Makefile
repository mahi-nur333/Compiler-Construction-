input = input.txt
output = output.txt

main: parser.y lexer.l
	bison -d parser.y
	flex lexer.l
	gcc parser.tab.c lex.yy.c 
	a < $(input) > $(output)

