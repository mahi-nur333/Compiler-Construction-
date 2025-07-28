main:
	"C:/GnuWin32/bin/bison.exe" -d cal.y
	"C:/GnuWin32/bin/flex.exe" cal.l
	gcc -o calc.exe cal.tab.c lex.yy.c
	calc.exe < input.txt > output.txt