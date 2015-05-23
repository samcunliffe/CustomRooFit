
// ROOT
#include "TCanvas.h"
#include "TFile.h"

// RooFit
#include "RooRealVar.h"
#include "RooDataSet.h"
#include "RooArgSet.h"
#include "RooPlot.h"
#include "RooWorkspace.h"


// from this framework
#include "RooExpAndGauss.hpp"

int main()
{
  // independent variable
  RooRealVar x("x", "x", -10, 10);

  // parameters
  RooRealVar width("width", "gaussian width", 2.,   0., 10.);
  RooRealVar mean ("mean",  "gaussian mean",  0., -10., 10.);
  RooRealVar decay("decay", "decay coeff",   -0.5, -1.0, 0.);

  // instantiate the custom pdf
  RooExpAndGauss pdf("pdf", "custom pdf", x, mean, width, decay);

  // plot it
  TCanvas canvas;
  RooPlot *plot = x.frame(50);
  pdf.plotOn(plot);
  plot->Draw();
  canvas.SaveAs("plots/beforeSavingWorkspaceExpAndGauss.pdf");

  // instantiate a workspace
  TFile wsfile("workspace.root", "RECREATE");
  RooWorkspace ws("ws", "ws");

  // save the code...
  // https://root.cern.ch/phpBB3/viewtopic.php?f=15&t=12695
  ws.addClassDeclImportDir("./include/");
  ws.addClassImplImportDir("./src/");
  ws.importClassCode(RooExpAndGauss::Class(),kTRUE);

  // save the pdf and all parameters
  ws.import(pdf);
  ws.Write();

  // tidy up
  wsfile.Close();
  delete plot;
  return 0;
}
