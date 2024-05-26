function [cond_first_save,cond_second_save] = Mini_Batch_MNIST_Training(images_new,labels,mini_batch,cond_first,cond_second)
[input_size,output_neuron_number,t_write,t_relax,   a_p, g_hrs_p, g_lrs_p,a_d, g_hrs_d, g_lrs_d,    v_read,Circuit_amp,v_th,Vrest, Resistor, Capacitor ] = parameter();

cond_first_save = zeros(output_neuron_number,input_size,mini_batch(2));
cond_second_save = zeros(output_neuron_number,10,mini_batch(2));
%% Mini Batch Training
for conductance_save_point = 1:mini_batch(2)
    %% Random Batch Extraction
    for i=1:mini_batch(1)
        a = floor(rand()*size(images_new,2))+1;
        image_training(:,i) = images_new(:,a);    
        labels_training(i,1) = labels(a,1);
    end

    %% Training Phase
    for training_count = 1:mini_batch(1)
        Potential_output = Vrest*ones(output_neuron_number,1);
        fire_number = zeros(1,output_neuron_number);
        for j = 1:input_size
            input_timing(j) = image_training(j,training_count);
        end

        %% Time Code
        for t = 1:150
        current_sum = zeros(output_neuron_number,1);    
            %% Gate Pulse Calculation
            for first_columm = 1:output_neuron_number
                for j=1:input_size
                    if input_timing(j) > t
                        current_sum(first_columm,1) = current_sum(first_columm,1) + v_read * cond_first(first_columm,j);
                    end
                end
            end
            I_Input = Circuit_amp*current_sum;

            %% Membrane Potential Update (Ramp Up)
            for first_columm = 1:output_neuron_number
                Potential_output(first_columm,1) = Ramp_up(Potential_output(first_columm,1), I_Input(first_columm), t_write, Resistor, Capacitor);
            end

                    %% Detect Firing Neuron & STDP
            maximum_potential_label = find((Potential_output) == max(Potential_output));
            if Potential_output(maximum_potential_label,1) > v_th
                %% Seconde Layer STDP
                for second_layer = 1 : 10 
                    if second_layer == labels_training(training_count,1)+1 
                        cond_second(maximum_potential_label,second_layer) = potentiaion(cond_second(maximum_potential_label,second_layer), a_p, g_hrs_p, g_lrs_p);
                    else 
                        cond_second(maximum_potential_label,second_layer) = depression(cond_second(maximum_potential_label,second_layer), a_d, g_hrs_d, g_lrs_d);
                    end
                end  % 아웃풋에서 라벨이랑 맞는지 확인하고, 맞으면 p 틀리면 d       
                %% First Layer STDP
                for j=1:input_size                 
                    if t < input_timing(j)
                        cond_first(maximum_potential_label,j) = potentiaion(cond_first(maximum_potential_label,j), a_p, g_hrs_p, g_lrs_p);
                    else 
                        cond_first(maximum_potential_label,j) = depression(cond_first(maximum_potential_label,j), a_d, g_hrs_d, g_lrs_d);
                    end
                end
                break
            end

            %% Membrane Potential Update (Ramp Down)
            for first_columm = 1:output_neuron_number
                Potential_output(first_columm,1) = Ramp_down(Potential_output(first_columm,1),t_relax, Resistor, Capacitor);
            end
        end
    end
    cond_first_save(:,:,conductance_save_point) = cond_first(:,:);
    cond_second_save(:,:,conductance_save_point) = cond_second(:,:);
end

end