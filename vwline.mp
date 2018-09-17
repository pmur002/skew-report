prologues := 3;
outputtemplate := "%j.ps";
beginfig(1);
z1 = (0, 0);
z2 = (50, 50);
z3 = (100, 0);
penpos1(5, 0);
penpos2(10, 90);
penpos3(20, 0);
penstroke z1e..z2e..z3e;
endfig;
end
