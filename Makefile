
all: LZSS \
	LibLZSS.a
	

LZSS: LZSS.o
	cc -Ofast -o $@ $<
LZSS.o: LZSS.C
	cc -Ofast -c -o $@ $<
LZSS_encode.o: LZSS_encode.C
	cc -Ofast -c -o $@ $<
LibLZSS.a: LZSS_encode.o
	ar -rs LibLZSS.a $<

clean:
	rm LZSS *.o *.a
