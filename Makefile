
all:
	### build pdf object using normal cpp (fpic flag is important)
	g++ -O2 -Wall -fPIC -Xlinker -zmuldefs `root-config --cflags --libs` -Iinclude -c src/RooExpAndGauss.cpp -o obj/RooExpAndGauss.o

	### now build rootcint object (fills in methods for inheritance from RooAbsPdf)
	rootcint -f dict/MyCustomPdfDictionaries.cxx -c  include/RooExpAndGauss.hpp+
	### now compile the root cint stuff into an object (fpic flag is important)
	g++ -O2 -fPIC `root-config --cflags` -I./ -c dict/MyCustomPdfDictionaries.cxx -o dict/MyCustomPdfDictionaries.o

	###  link objects into shared object
	g++ -shared -O2 `root-config --cflags`  obj/RooExpAndGauss.o dict/MyCustomPdfDictionaries.o -o lib/libCustomRooFit.so

	### compile the executable
	g++ -O2 -Iinclude `root-config --cflags --libs` -Llib -lCustomRooFit main/generate.cpp -o bin/generate
	

clean:
	rm -f obj/* dict/* bin/*
	
