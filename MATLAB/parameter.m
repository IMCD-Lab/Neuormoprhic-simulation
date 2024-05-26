function [input_size,output_neuron_number,t_write,t_relax,   a_p, g_hrs_p, g_lrs_p,a_d, g_hrs_d, g_lrs_d,    v_read,Circuit_amp,v_th,v_rest, Resistor, Capacitor ] = parameter()

% NN parameter
input_size = 784;
output_neuron_number = 200;
% 수정 파라미터
t_write = 0.001;
t_relax = 0.009;
% Synpase Parameter
a_p = 2.77259;
g_hrs_p = 5.1332E-7 * 1.2e4;
g_lrs_p = 8.05568E-6 * 1.2e4;
a_d = 2.12037;
g_hrs_d = 4.56841E-7 * 1.2e4;
g_lrs_d = 7.59863E-6 * 1.2e4;
% states = 200;
% g_lrs = 0.1;
% g_hrs = g_lrs/states;
v_read = 0.1;
% Neuron
Circuit_amp = 1e-5;
v_th= 1.0; %%%%%%%%%%%%%%%% 이거는 0.7 이 기준
v_rest = 0.0;
RC = 5. * (t_write+t_relax);
Capacitor = 5e-9;
Resistor = RC/Capacitor;
end