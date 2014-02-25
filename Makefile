
all:
	echo "build pdf object using normal cpp"
	g++ -O2 -Wall -fPIC -Xlinker -zmuldefs -Iinclude -I -pthread -m64 -I/usr/include/root  -c src/RooExpAndGauss.cpp -o obj/RooExpAndGauss.o
	echo "now build rootcint object (fills in methods for inheritance from RooAbsPdf)"
	root
