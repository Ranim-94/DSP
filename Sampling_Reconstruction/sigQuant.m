function quantizedSignal = sigQuant(x,B)

%x - input signal (assume quantization bits of input is greater than
%requested quantization level)
%B - # of bit levels to quantize to

%normalize signal to pm 1
xNorm = x./min(abs([max(x) min(x)]));

%round signal in increment of quantLevel
quantLevel = 2^(B-1);

%compute the quantization level
quantizedSignal = round((quantLevel-1)*xNorm)/quantLevel;

return