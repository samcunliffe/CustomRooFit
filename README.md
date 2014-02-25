customRooFit
============

Minimal working example of a project with a custom roofit pdf.
I always forget what should go in the makefile (there is a `rootcint` step to auto-generate some libraries).

### Prerequisites

 * A recent and decent version of root (with RooFit and python enabled)
 * g++ (or edit the makefile for your favourite compiler)
 * The makefile uses `root-config` ... so this should point to a sensible place.
 * The python code assumes the `PYTHONPATH` environmental variable has a path to `ROOT.py`
