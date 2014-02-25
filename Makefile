
all: obj/RooExpAndGauss.o dict/MyCustomPdfDictionaries.o lib/libCustomRooFit.so bin/generate

obj/RooExpAndGauss.o: src/RooExpAndGauss.cpp
	### build pdf object using normal cpp (fpic flag is important)
	g++ -O2 -Wall -fPIC -Xlinker -zmuldefs `root-config --cflags` -Iinclude -c $^ -o $@

dict/MyCustomPdfDictionaries.o: obj/RooExpAndGauss.o
	### now build rootcint object (fills in methods for inheritance from RooAbsPdf)
	rootcint -f dict/MyCustomPdfDictionaries.cxx -c  include/RooExpAndGauss.hpp+
	### now compile the root cint stuff into an object (fpic flag is important)
	#g++ -O2 -fPIC `root-config --cflags --libs` -lRooFit -lRooFitCore -I./ -c dict/MyCustomPdfDictionaries.cxx -o dict/MyCustomPdfDictionaries.o
	g++ -O2 -fPIC `root-config --cflags` -I./ -c dict/MyCustomPdfDictionaries.cxx -o dict/MyCustomPdfDictionaries.o

lib/libCustomRooFit.so: obj/RooExpAndGauss.o dict/MyCustomPdfDictionaries.o
	### link my objects into shared object
	g++ -shared -O2 `root-config --cflags` obj/RooExpAndGauss.o dict/MyCustomPdfDictionaries.o -o lib/libCustomRooFit.so

bin/generate: main/generate.cpp
	### compile the executable
	g++ -O2 -Iinclude `root-config --cflags --libs` -lRooFit -Llib -lCustomRooFit main/generate.cpp -o bin/generate

clean:
	rm -f obj/* dict/* bin/* lib/*
