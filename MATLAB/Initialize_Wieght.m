function [cond,cond_second] = Initialize_Wieght(output_neuron_number,input_size,g_lrs_p,g_hrs_p)
para = 0.2;
cond = rand(output_neuron_number,input_size);
cond_second = rand(output_neuron_number,10);
%%%%%%%%%%%%% 초기 높은 전도도 모든 뉴런 Firing
cond = (g_lrs_p-para*(g_lrs_p-g_hrs_p)*cond);
cond_second = (g_lrs_p-para*(g_lrs_p-g_hrs_p)*cond_second);
end