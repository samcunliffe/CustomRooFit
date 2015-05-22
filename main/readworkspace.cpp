
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
  // open the workspace
  TFile wsfile("workspace.root", "READ");
  RooWorkspace *ws = 0;
  wsfile.GetObject("ws", ws);
  ws->Print(); // hello!

  // get the pdf 
  RooExpAndGauss* pdf = (RooExpAndGauss*)ws->pdf("pdf");
  RooRealVar* x = ws->var("x");
 
  // plot it
  TCanvas canvas;
  RooPlot *plot = x->frame(50);
  pdf->plotOn(plot);
  plot->Draw();
  canvas.SaveAs("plots/afterSavingWorkspaceExpAndGauss.pdf");

  // tidy up
  wsfile.Close();
  delete plot;
  return 0;
}
