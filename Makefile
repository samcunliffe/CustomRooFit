
all:
	# build pdf object using normal cpp
	g++ -O2 -Wall -fPIC -Xlinker -zmuldefs `root-config --cflags` -Iinclude -c src/RooExpAndGauss.cpp -o obj/RooExpAndGauss.o
	# now build rootcint object (fills in methods for inheritance from RooAbsPdf)
	rootcint -f dict/MyCustomPdfDictionaries.cxx -c  include/RooExpAndGauss.hpp+
	# now compile the root cint stuff
	g++ `root-config --cflags` -I./ -c dict/MyCustomPdfDictionaries.cxx -o dict/MyCustomPdfDictionaries.o
	# build shared object
	g++ -shared -O2 `root-config --cflags`  obj/RooExpAndGauss.o dict/MyCustomPdfDictionaries.o -o obj/libCustomRooFit.so

	# compile the executable
	

clean:
	rm -f obj/* dict/* bin/*
	
