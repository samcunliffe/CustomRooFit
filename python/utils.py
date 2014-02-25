
def load_shared_object(name = "libCustomRooFit.so"):
    """Global gROOT command that loads the so"""
    from ROOT import gSystem
    gSystem.Load("lib/" + name) 
    return 

