function x = potentiaion(x, alpha, min, max)
    if x < max
       x = abs(x + (x-min-(max-min) / (1-exp(-alpha)))*(1-exp(alpha/63.))  );
    end    
end