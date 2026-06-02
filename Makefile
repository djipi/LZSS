
UNAME := $(shell uname -s)
ifeq ($(findstring MINGW,$(UNAME)),MINGW)
	SUFFIX := .exe
else
	SUFFIX :=
endif
	
# PREFIX is environment variable, but if it is not set, then set default value
ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif
ifdef MINGW_PREFIX
	PREFIX := $(MINGW_PREFIX)/local
endif

PKGCONFIG_DIR ?= $(PREFIX)/lib/pkgconfig
PC_FILE = $(PKGCONFIG_DIR)/LZSS.pc

BUILD_DIR = build

all: $(BUILD_DIR)/LZSS \
	$(BUILD_DIR)/libLZSS.a

$(BUILD_DIR)/LZSS: $(BUILD_DIR)/LZSS.o
	@echo -e "\033[01;33m***\033[00;32m Building the tool...\033[00m"
	@gcc -Ofast -o $@ $<
$(BUILD_DIR)/LZSS.o: LZSS.C
	@echo -e "\033[01;33m***\033[00;32m Compiling $<...\033[00m"
	@gcc -Ofast -c -o $@ $<
$(BUILD_DIR)/LZSS_encode.o: LZSS_encode.C
	@echo -e "\033[01;33m***\033[00;32m Compiling $<... for the library\033[00m"
	@gcc -Ofast -c -o $@ $<
$(BUILD_DIR)/libLZSS.a: $(BUILD_DIR)/LZSS_encode.o
	@echo -e "\033[01;33m***\033[00;32m Building the library...\033[00m"
	@ar -rs $@ $<

clean:
	@echo -e "\033[01;33m***\033[00;32m Cleaning...\033[00m"
	@rm $(BUILD_DIR)/LZSS$(SUFFIX) $(BUILD_DIR)/*.o $(BUILD_DIR)/*.a

pkgconfig:
	@echo -e "\033[01;33m***\033[00;32m Create pkgconfig...\033[00m"
	@mkdir -p $(PKGCONFIG_DIR)
	@echo "prefix=$(PREFIX)" > $(PC_FILE)
	@echo "exec_prefix=\$${prefix}" >> $(PC_FILE)
	@echo "libdir=\$${exec_prefix}/lib" >> $(PC_FILE)
	@echo "includedir=\$${prefix}/include" >> $(PC_FILE)
	@echo "" >> $(PC_FILE)
	@echo "Name: LZSS" >> $(PC_FILE)
	@echo "Description: LZSS compression library" >> $(PC_FILE)
	@echo "Version: 4/6/1989 Haruhiko Okumura" >> $(PC_FILE)
	@echo "Libs: -L\$${libdir} -lLZSS" >> $(PC_FILE)
	@echo "Cflags: -I\$${includedir}" >> $(PC_FILE)

uninstall:
	@echo -e "\033[01;33m***\033[00;32m Uninstalling the library and the tool...\033[00m"
	@rm $(DESTDIR)$(PREFIX)/lib/libLZSS.a
	@rm -rf $(DESTDIR)$(PREFIX)/include/LibLZSS.h
	@rm $(DESTDIR)$(PREFIX)/bin/LZSS$(SUFFIX)
	@rm $(PKGCONFIG_DIR)/LZSS.pc

install: $(BUILD_DIR)/libLZSS.a pkgconfig
	@echo -e "\033[01;33m***\033[00;32m Installing the library and the tool...\033[00m"
	install -d $(DESTDIR)$(PREFIX)/lib/
	install -m 644 $(BUILD_DIR)/libLZSS.a $(DESTDIR)$(PREFIX)/lib/
	install -d $(DESTDIR)$(PREFIX)/include/
	install -m 644 LibLZSS.h $(DESTDIR)$(PREFIX)/include/
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 751 $(BUILD_DIR)/LZSS$(SUFFIX) $(DESTDIR)$(PREFIX)/bin/
