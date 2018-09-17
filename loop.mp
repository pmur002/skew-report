prologues := 3;
outputtemplate := "%j.ps";
beginfig(1);
  z0 = (0.5cm,1.5cm); 
  z1 = (2.5cm,2.5cm);
  z2 = (6.5cm,0.5cm); 
  z3 = (3.0cm,1.5cm);

  pickup pencircle xscaled 2mm yscaled 4mm rotated 30;
  
  draw z0..z1..z2..z3..z0..cycle;
endfig;
end
 
