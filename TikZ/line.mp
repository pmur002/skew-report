prologues := 3;
outputtemplate := "%j.ps";
input mparrows;
setarrows(barbed);
barbedarrowindent := .6;
ahlength := 8mm;
beginfig(1);
draw (0,0)--(15.0370911111111cm,0)--(15.0370911111111cm,14.7527522222222cm)--(0,14.7527522222222cm)--cycle;
z0 = (11.6448135429835cm,11.6992243733151cm);
z1 = (4.04832216904266cm,6.54309260773091cm);
drawarrow z0{dir 180}..z1{dir 135};
pickup pencircle xscaled 5pt yscaled .5pt rotated 135;
draw z0{dir 180}..z1{dir 135};
endfig;
end
