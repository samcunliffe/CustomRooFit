
// RooFit
#include "RooDataSet.h"
#include "RooRealVar.h"
#include "RooPlot.h"

// from this framework
#include "RooExpAndGauss.hpp"

int main()//(int argc, char *argv[])
{
  // independent variable
  RooRealVar x("x", "x", -10, 10);

  // parameters
  RooRealVar width("width", "gaussian width", 2.,   0., 10.);
  RooRealVar mean ("mean",  "gaussian mean",  0., -10., 10.);
  RooRealVar decay("decay", "decay coeff",   0.5,  );

  // instantiate the custom pdf
  RooExpAndGauss pdf("pdf", "custom pdf", x, mean, width, decay);

  // generate random dataset
  RooDataSet *toydata = pdf.generate(5000);
  
  // fit back to the dataset (I expect it will fit quite well!)
  pdf.fitTo(toydata, RooFit::Strategy(2));

  // plot the thing
  TCanvas canvas;
  RooPlot *plot = x.frame(50);
  toydata.plotOn(plot);
  pdf.plotOn(plot);
  plot->Draw();
  canvas.SaveAs("plot/fittedRooExpAndGauss.pdf");

  // tidy up
  delete toydata;
  delete plot;
  return 0;
}
