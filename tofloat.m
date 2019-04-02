function [out,revertclass] = tofloat(input)

identity = @(x) x;
tosingle = @im2single;

table = {'uint8', tosingle, @im2unit8
    'uint16', tosingle ,@im2unit16
    'int16', tosingle, @im2int16
    'logical', tosingle, @logical
    'double', identity, identity
    'single', identity, identity};

classIndex = find(strcmp(class(input), table(:,1)));

if isempty(classIndex)
   error('Unsupported input image class.');
end

out = table{classIndex, 2}(input);

revertclass = table{classIndex, 3};
