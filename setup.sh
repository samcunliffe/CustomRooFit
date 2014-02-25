#!/bin/bash

# check root stuff
type root >/dev/null 2>&1 || { echo >&2 "We require ROOT but it's not in your PATH."; exit 1; }
type root-config >/dev/null 2>&1 || { echo >&2 "We require root-config but it's not in your PATH."; exit 1; }
echo "ROOT version is: ............." `root-config --version`
echo "Do you have RooFit? .........." `root-config --has-roofit`
echo "Do you have pyROOT? .........." `root-config --has-python`
echo "pyROOT for python version ...." `root-config --python-version`

# need to add the path to this project's shared object
export LD_LIBRARY_PATH=$PWD/lib:$LD_LIBRARY_PATH
