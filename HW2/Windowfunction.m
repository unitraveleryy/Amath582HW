function g = Windowfunction(wid,tslide,t,type)
%FILTER Summary of this function goes here
%   Detailed explanation goes here
    if strcmp(type,"StepSize")
        keep = (abs(t-tslide) < 2*wid);
        g = zeros(1,length(t));
        g(keep) = 1;
    elseif strcmp(type,"MexicanHat")
        g = (1-(t-tslide).^2/(wid^2)).*exp(-(t-tslide).^2/(2*wid^2));
    else
        g = exp(-wid*(t-tslide).^2);
    end
end

