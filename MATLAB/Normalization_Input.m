function [output] = Normalization_Input(fea, value)
    sz = 784;
    ave = 0;
    for i = 1:sz
        ave = ave+fea(i,1)*fea(i,1)/sz;
    end
    ave = sqrt(ave);
%% Digitalization
    for i = 1:sz
        if fea(i,1) < ave
            fea(i,1) = 0;
        end
    end
%% Normalization
    fea = fea*value/ave;
    output = round(fea);
end