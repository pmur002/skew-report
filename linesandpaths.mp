prologues := 3;
outputtemplate := "%j.ps";
beginfig(1);
z1 = (0, 0);
z2 = (50, 0);
penpos1(0, 90);
penpos2(10, 90);
penstroke z1e..z2e;
pickup pencircle scaled 10;
draw (0, 50)--(50, 50);
endfig;
end
