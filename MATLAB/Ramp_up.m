function [Potential_output] = Ramp_up(Potential_output, I_Input, t_write, Resistor, Capacitor)
    Potential_output = Potential_output*exp(-t_write/(Resistor*Capacitor)) + Resistor*I_Input*(1-exp(-t_write/(Resistor*Capacitor)));
end