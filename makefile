# out: scanner

# scanner: token.o lex.yy.o
# 	gcc -o token.o lex.yy.o -o scanner

# lex.yy.o: lex.yy.c lex.yy.h
# 	gcc -c lex.yy.c -o lex.yy.o

# token.o: token.c token.h
# 	gcc -c token.c -o token.o

# lex.yy.c: scanner.l
# 	flex $<

out: scanner

scanner: lex.yy.c token.h
	gcc -o $@ $<

lex.yy.c: scanner.l
	flex $<