function [Recognition_rate,confusion_matrix] = Inference_confusion_matrix(images_test,labels_test,test_batch,mini_batch,cond_first_save,cond_second_save)
[input_size,output_neuron_number,t_write,t_relax,   a_p, g_hrs_p, g_lrs_p,a_d, g_hrs_d, g_lrs_d,    v_read,Circuit_amp,v_th,Vrest, Resistor, Capacitor ] = parameter();

confusion_matrix = zeros(10,10);

% v_th = 0.7
Recognition_rate=zeros(mini_batch(2),2);
for test_save_point = mini_batch(2):mini_batch(2)
    right_recognition = 0;
    %% Random Batch Extraction
    for i=1:test_batch
        a = floor(rand()*size(images_test,2))+1;
        image_testing(:,i) = images_test(:,a);    
        labels_testing(i,1) = labels_test(a,1);
    end


    %% Inference Phase
    for test_count = 1:test_batch
        Potential_output = Vrest*ones(output_neuron_number,1);
        fire_number = zeros(1,output_neuron_number);
        for j = 1:input_size
            input_timing(j) = image_testing(j,test_count);
        end
        
        %% Time Code
        for t = 1:150
        current_sum = zeros(output_neuron_number,1);    
            %% Gate Pulse Calculation
            for first_columm = 1:output_neuron_number
                for j=1:input_size
                    if input_timing(j) > t
                        current_sum(first_columm,1) = current_sum(first_columm,1) + v_read * cond_first_save(first_columm,j,test_save_point);
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
                classification_result = find(cond_second_save(maximum_potential_label,:,test_save_point) == max(cond_second_save(maximum_potential_label,:,test_save_point)));
                confusion_matrix(classification_result,labels_testing(test_count,1)+1) = confusion_matrix(classification_result,labels_testing(test_count,1)+1) + 1;
                % x축 추론 출력 / y축 실제 입력
                if classification_result == labels_testing(test_count,1)+1 
                    right_recognition = right_recognition + 1;
                end
                break
            end

            %% Membrane Potential Update (Ramp Down)
            for first_columm = 1:output_neuron_number
                Potential_output(first_columm,1) = Ramp_down(Potential_output(first_columm,1),t_relax, Resistor, Capacitor);
            end
        end
    end
    
    Recognition_rate(test_save_point,1) = test_save_point*mini_batch(1);
    Recognition_rate(test_save_point,2) = right_recognition / test_batch * 100.;
    
end