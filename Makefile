	
# PREFIX is environment variable, but if it is not set, then set default value
ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

all: LZSS \
	LibLZSS.a

LZSS: LZSS.o
	@echo -e "\033[01;33m***\033[00;32m Building the tool...\033[00m"
	@gcc -Ofast -o $@ $<
LZSS.o: LZSS.C
	@echo -e "\033[01;33m***\033[00;32m Compiling $<...\033[00m"
	@gcc -Ofast -c -o $@ $<
LZSS_encode.o: LZSS_encode.C
	@echo -e "\033[01;33m***\033[00;32m Compiling $<... for the library\033[00m"
	@gcc -Ofast -c -o $@ $<
LibLZSS.a: LZSS_encode.o
	@echo -e "\033[01;33m***\033[00;32m Building the library...\033[00m"
	@ar -rs $@ $<

clean:
	@echo -e "\033[01;33m***\033[00;32m Cleaning...\033[00m"
	@rm LZSS *.o *.a

install: LibLZSS.a
	@echo -e "\033[01;33m***\033[00;32m Installing the library and the tool...\033[00m"
	install -d $(DESTDIR)$(PREFIX)/lib/
	install -m 644 LibLZSS.a $(DESTDIR)$(PREFIX)/lib/
	install -d $(DESTDIR)$(PREFIX)/include/
	install -m 644 LibLZSS.h $(DESTDIR)$(PREFIX)/include/
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 751 LZSS $(DESTDIR)$(PREFIX)/bin/
