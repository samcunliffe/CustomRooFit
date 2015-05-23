CustomRooFit
============

Minimal working example of a project with a custom roofit pdf.
I always forget what should go in the makefile (there is a ~~`rootcint`~~ `rootcling` step to auto-generate some libraries).
Then it builds a shared object which should be fairly portable.

### Prerequisites

 * A recent and decent version of root (with RooFit and python enabled). I used 6.02/05.
 * g++ > 4.8 (or edit the makefile for your favourite compiler)
 * The makefile uses `root-config` and `rootcling` which comes with [ROOT6](https://root.cern.ch/drupal/content/root-version-v6-02-00-patch-release-notes)
    * if you want to use ROOT5.. you will need to revert to `rootcint`
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
    
### Acknowledgements

Helpful hints from the [ROOT forum](https://root.cern.ch/phpBB3/viewtopic.php?f=15&t=12695) and [Michel's tWiki @ UZH](https://wiki.physik.uzh.ch/lhcb/root:custompdfsandworkspace)
