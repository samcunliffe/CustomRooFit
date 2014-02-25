CustomRooFit
============

Minimal working example of a project with a custom roofit pdf.
I always forget what should go in the makefile (there is a `rootcint` step to auto-generate some libraries).

### Prerequisites

 * A recent and decent version of root (with RooFit and python enabled)
 * g++ (or edit the makefile for your favourite compiler)
 * The makefile uses `root-config` ... so this should point to a sensible place.
 * Running the python code (optional) assumes the `PYTHONPATH` environmental variable has a path to `ROOT.py`

### Usage
This project builds a shared object, so you have to add the lib directory to your `LD_LIBRARY_PATH` in order to run any of the executables.

    source setup.sh # does this

If all has gone well, you have `ROOT` with `pyROOT` and a `root-config`, so you can just

    make

Then run the test C++ code with:

    ./bin/generate # or whatever

And the python code is run with:

    python python/generate.py # or whatever
