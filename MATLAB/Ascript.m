tic
clearvars 
% load('Test#1')
%% Simuation Parameter & Initialize NN
[input_size,output_neuron_number,t_write,t_relax,   a_p, g_hrs_p, g_lrs_p,a_d, g_hrs_d, g_lrs_d,    v_read,Circuit_amp,v_th,Vrest, Resistor, Capacitor ] = parameter();
[cond_init,cond_second_init] = Initialize_Wieght(output_neuron_number,input_size,g_lrs_p,g_hrs_p);

%% Import Image
Input_Norm = 32;
images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');
images_test = loadMNISTImages('t10k-images.idx3-ubyte');
labels_test = loadMNISTLabels('t10k-labels.idx1-ubyte');
for i = 1:60000
    images_new(:,i) = Normalization_Input(images(:,i), Input_Norm);
end
for i = 1:10000
    images_test_new(:,i) = Normalization_Input(images_test(:,i), Input_Norm);
end

%% Trainig Phase
mini_batch = [500,100];
[cond_first_save,cond_second_save] =  Mini_Batch_MNIST_Training(images_new,labels,mini_batch,cond_init,cond_second_init);

for i=1:1
%% Inference Phase
test_batch = 200;
i
%[cond_first_save_new] = Normalize_Conductance(cond_first_save);
[Recognition_rate] = Inference(images_test_new,labels_test,test_batch,mini_batch,cond_first_save,cond_second_save);
% [Recognition_rate] = Inference(images_test_new,labels_test,test_batch,mini_batch,cond_first_save_new,cond_second_save);
Recognition_rate_record(:,i) = Recognition_rate(:,2);
end

clearvars -except cond_init cond_second_init cond_first_save cond_second_save Recognition_rate Recognition_rate_record mini_batch
save('Test_Neuron#50.mat', 'cond_init', 'cond_second_init', 'cond_first_save', 'cond_second_save', 'Recognition_rate', 'mini_batch')

toc