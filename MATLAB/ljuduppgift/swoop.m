
inst_f = [linspace(1500, 1500, 0.1*44100)];
phi = 2 * pi * cumsum(inst_f) / 44100;
beep = [sin(phi)' sin(phi)'];


sound(sweep);