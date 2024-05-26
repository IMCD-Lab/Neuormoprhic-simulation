load('Test#1')
[input_size,output_neuron_number,t_write,t_relax,   a_p, g_hrs_p, g_lrs_p,a_d, g_hrs_d, g_lrs_d,    v_read,Circuit_amp,v_th,Vrest, Resistor, Capacitor ] = parameter();
LRS = max(g_lrs_p,g_lrs_d);
output_neuron_number = size(cond_init,1);

image_output = zeros(28*output_neuron_number/10,28*10);

kkk = size(cond_first_save,3);
    for k=1:output_neuron_number/10
        for kk=1:10
            for i = 1:28
                for j = 1:28
%                    image_output(j+(k-1)*28,i+(kk-1)*28)=cond_init((kk-1)*output_neuron_number/10+k,(i-1)*28+j); %% 초기 전도도
                    image_output(j+(k-1)*28,i+(kk-1)*28)=cond_first_save((kk-1)*output_neuron_number/10+k,(i-1)*28+j,kkk); %% 학습 이후 전도도
                end
            end
        end
    end
    figure(1)    
    clims = [0, LRS];
    imagesc(image_output,clims);
    colorbar

clearvars -except output_neuron_number mini
