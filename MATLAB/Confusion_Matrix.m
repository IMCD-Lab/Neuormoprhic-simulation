load('Test#1')
images_test = loadMNISTImages('t10k-images.idx3-ubyte');
labels_test = loadMNISTLabels('t10k-labels.idx1-ubyte');
Input_Norm = 32;
for i = 1:10000
    images_test_new(:,i) = Normalization_Input(images_test(:,i), Input_Norm);
end
test_batch = 10000;
[Recognition_rate,confusion_matrix] = Inference_confusion_matrix(images_test_new,labels_test,test_batch,mini_batch,cond_first_save,cond_second_save);

max_firing = max(max(confusion_matrix));

figure(1)    
clims = [0, max_firing];
imagesc(confusion_matrix,clims);
colorbar

figure(2)    
confusionchart(confusion_matrix);

max_firing = max(max(confusion_matrix));

figure(1)    
clims = [0, max_firing];
imagesc(confusion_matrix,clims);
colorbar

figure(2)    
labels = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};
cm=confusionchart(confusion_matrix,labels);
cm.Title = 'Confusion Matrix';
cm.XLabel = 'Inferred Outpud Digit';
cm.YLabel = 'Desired Outpud Digit';
cm.DiagonalColor = [0,0,1];
cm.OffDiagonalColor = [0,0,1];
cm.FontColor = [0,0,0];

save('ConfusionMat.mat', 'confusion_matrix')

clearvars -except confusion_matrix