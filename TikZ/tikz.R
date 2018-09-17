
## Draw R plot then add TikZ skewed curve with arrow between
## text label and data point

library(lattice)
library(grid)
library(grImport)

tikzLine <- function(x1, y1, x2, y2, w, h) {
    tzcode <- c("\\documentclass[dvips]{standalone}",
                "\\usepackage{tikz}",
                "\\usetikzlibrary{shapes.geometric}",
                "\\usetikzlibrary{arrows.meta,arrows}",
                "\\usetikzlibrary{bending}",
                "\\usepackage{geometry}",
                paste0("\\geometry{paperwidth=", w, "cm,",
                       "paperheight=", h, "cm}"),
                "\\begin{document}",
                "\\begin{tikzpicture}",
                "\\draw [arrows={-Stealth[length=10pt,bend,sep]}] ",
                paste0("(", x1, "cm,", y1, "cm) to[out=180, in=315] "),
                paste0("(", x2, "cm,", y2, "cm);"),
                "\\end{tikzpicture}",
                "\\end{document}")
    wd <- "." ## tempdir()
    texfile <- file.path(wd, "tikz.tex")
    dvifile <- file.path(wd, "tikz.dvi")
    psfile <- file.path(wd, "tikz.ps")
    xmlfile <- file.path(wd, "tikz.xml")
    writeLines(tzcode, texfile)
    system(paste0("latex ", texfile))
    system(paste0("dvips ", dvifile))
    PostScriptTrace(psfile, xmlfile)
    line <- readPicture(xmlfile)
    grid.picture(line, exp=0,
                 x=unit((x1 + x2)/2, "cm"), y=unit((y1 + y2)/2, "cm"),
                 width=unit(w, "cm"), height=unit(h, "cm"))
}

## tikzLine(1,1,2,2, 4, 4)

mpLine <- function(x1, y1, x2, y2, w, h) {
    mpcode <- c("prologues := 3;",
                'outputtemplate := "%j.ps";',
                "input mparrows;",
                "setarrows(barbed);",
                "barbedarrowindent := .6;",
                "ahlength := 8mm;",
                "beginfig(1);",
                paste0("draw (0,0)--(",
                       w, "cm,0)--(",
                       w, "cm,", h, "cm)--(",
                       "0,", h, "cm)--cycle;"),
                paste0("z0 = (", x1, "cm,", y1, "cm);"),
                paste0("z1 = (", x2, "cm,", y2, "cm);"),
                "drawarrow z0{dir 180}..z1{dir 135};",
                "pickup pencircle xscaled 5pt yscaled .5pt rotated 135;",
                "draw z0{dir 180}..z1{dir 135};",
                "endfig;",
                "end")
    wd <- "." ## tempdir()
    mpfile <- file.path(wd, "line.mp")
    psfile <- file.path(wd, "line.ps")
    xmlfile <- file.path(wd, "line.xml")
    writeLines(mpcode, mpfile)
    system(paste0("mpost ", mpfile))
    PostScriptTrace(psfile, xmlfile)
    pic <- readPicture(xmlfile)
    line <- pic[-1]
    line@summary@xscale <- pic@summary@xscale
    line@summary@yscale <- pic@summary@yscale
    grid.picture(line, exp=0)
}
                   
## mpLine(1, 1, 2, 2, 4, 4)
    
print(
    xyplot(mpg ~ disp, mtcars,
           panel=function(...) {
               panel.xyplot(...)
               textLeft <- unit(400, "native")
               textY <- unit(30, "native")
               grid.text(rownames(mtcars)[1], textLeft, textY, just="left")
               textLeftCM <- convertX(textLeft - unit(1, "mm"), "cm",
                                      valueOnly=TRUE)
               textYCM <- convertY(textY, "cm", valueOnly=TRUE)
               pointRightCM <- convertX(unit(mtcars$disp[1], "native") +
                                      unit(2, "mm"), "cm",
                                      valueOnly=TRUE)
               pointYCM <- convertY(unit(mtcars$mpg[1], "native") -
                                  unit(2, "mm"), "cm",
                                  valueOnly=TRUE)
               panelWidthCM <- convertWidth(unit(1, "npc"), "cm",
                                            valueOnly=TRUE)
               panelHeightCM <- convertHeight(unit(1, "npc"), "cm",
                                              valueOnly=TRUE)
               ## grid line
               ## grid.segments(textLeftCM, textYCM, pointRightCM, pointYCM,
               ##               default.units="cm")
               ## TikZ line
               ## tikzLine(textLeftCM, textYCM, pointRightCM, pointYCM,
               ##          panelWidthCM, panelHeightCM)
               ## MetaPost line
               mpLine(textLeftCM, textYCM, pointRightCM, pointYCM,
                      panelWidthCM, panelHeightCM)
           })
)
