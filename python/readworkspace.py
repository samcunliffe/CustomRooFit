
# a python code to open the workspace

# import things from ROOT
from ROOT import TFile, TCanvas, RooWorkspace

# load this project's library
from utils import load_shared_object
load_shared_object()
from ROOT import RooExpAndGauss

def main():
    # open the file
    wsfile = TFile("workspace.root", "READ")
    ws = wsfile.Get("ws")
    ws.Print()

    # get things from the workspace
    x = ws.var("x")
    pdf = ws.pdf("pdf")

    # plot it again
    canvas = TCanvas()
    plot = x.frame()
    pdf.plotOn(plot)
    plot.Draw()
    canvas.SaveAs("plots/readFromWorkspaceExpAndGauss.pdf")

    return

# run the main function
if __name__ == "__main__":
    main()
