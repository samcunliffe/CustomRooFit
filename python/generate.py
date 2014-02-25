
# a python implementation of main/generate.cpp

# import things from ROOT
from ROOT import TCanvas, RooRealVar, RooDataSet, RooArgSet, RooPlot
from ROOT import RooFit as rf # the RooFit namespace

# load this project's library
from utils import load_shared_object
load_shared_object()
from ROOT import RooExpAndGauss

def main():
    # independent variable
    x = RooRealVar("x", "x", -10, 10)

    # parameters
    width = RooRealVar("width", "gaussian width", 2.,   0., 10.)
    mean  = RooRealVar("mean",  "gaussian mean",  0., -10., 10.)
    decay = RooRealVar("decay", "decay coeff",   -0.5, -1.0, 0.)

    # instantiate the custom pdf
    pdf = RooExpAndGauss("pdf", "custom pdf", x, mean, width, decay)

    # generate random dataset
    toydata = pdf.generate(RooArgSet(x), 5000)

    # fit back to the dataset (I expect it will fit quite well!)
    pdf.fitTo(toydata, rf.Strategy(2))

    # plot the thing
    canvas = TCanvas()
    plot = x.frame(50)
    toydata.plotOn(plot)
    pdf.plotOn(plot)
    plot.Draw()
    canvas.SaveAs("plots/fittedRooExpAndGauss_fromPython.pdf")

    return

# run the main function
if __name__ == "__main__":
    main()
