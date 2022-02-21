
all:
	cc -Ofast -o LZSS LZSS.C

LZSS.o: LZSS.C
	cc -Ofast -c -o $@ $<
LZSS_encode.o: LZSS_encode.C
	cc -Ofast -c -o $@ $<

clean:
	rm LZSS *.o
	