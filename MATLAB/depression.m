function x = depression(x, alpha, min, max)
    if x > min
       x = abs (x + (x-max+(max-min) / (1-exp(-alpha)))*(1-exp(alpha/63.))  );
       if x > max
           x = max;
       end
    end
end