function [Potential_output] = Ramp_down(Potential_output,t_relax, Resistor, Capacitor)
    Potential_output = Potential_output*exp(-t_relax/(Resistor*Capacitor));
end