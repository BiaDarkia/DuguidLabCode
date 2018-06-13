function []= ConcatDAQ( name, daq1 , daq2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

a = loadAbfData(daq1); 
b = loadAbfData(daq2); 

Data = [a;b];
save(name); 


end

