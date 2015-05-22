
COMPILE       = g++ -std=c++11 -O2 -Wall -fPIC -Xlinker -zmuldefs -Wno-unused-local-typedefs -pthread -Wno-deprecated-declarations -m64
LOCALINCLUDE  = -Iinclude
ROOTINCLUDE   = -I$(ROOTSYS)/include
ROOTLIBS      = $(shell root-config --libs) -lRooFitCore -lRooFit -lRooStats
ROOTGLIBS     = $(shell root-config --glibs) -lRooFit -lRooStats# this is needed for roofit

# build the library first, then the executables 
all: lib/libCustomRooFit.so executables

# make the class object
obj/RooExpAndGauss.o: src/RooExpAndGauss.cpp
	$(COMPILE) $(ROOTINCLUDE) $(LOCALINCLUDE) $(ROOTLIBS) -c $^ -o $@

# the 'rootcling' step to generate the extra functions required
# ... build and compile the dictionary object
dict/Dict.o:
	rootcling -f dict/Dict.cxx -c $(LOCALINCLUDE) RooExpAndGauss.hpp LinkDef.h
	$(COMPILE) $(ROOTINCLUDE) $(LOCALINCLUDE) $(ROOTLIBS) -c dict/Dict.cxx -o dict/Dict.o

# build the shared object
lib/libCustomRooFit.so: obj/RooExpAndGauss.o dict/Dict.o
	g++ -shared $^ -o $@ $(ROOTGLIBS)

# can compile anything which links to the shared library and can see the headers
executables: 
	$(COMPILE) $(ROOTINCLUDE) $(LOCALINCLUDE) main/generate.cpp      -L./lib  -lCustomRooFit $(ROOTLIBS) -o bin/generate      
	$(COMPILE) $(ROOTINCLUDE) $(LOCALINCLUDE) main/saveworkspace.cpp -L./lib  -lCustomRooFit $(ROOTLIBS) -o bin/saveworkspace 
	$(COMPILE) $(ROOTINCLUDE) $(LOCALINCLUDE) main/readworkspace.cpp -L./lib  -lCustomRooFit $(ROOTLIBS) -o bin/readworkspace 

clean:
	rm dict/* lib/*.so bin/* obj/* -rf
