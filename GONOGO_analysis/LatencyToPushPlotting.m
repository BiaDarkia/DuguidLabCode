num_subplot = size(AllPushesRT,2); % To calculate the num of subplots
n = round(num_subplot/3); % Three columns of plots
m = round(num_subplot/n); % num of rows of plots
p = 1; % subplot num flag

a = [1:250:15000; zeros(1,length(1:250:15000))];
AllPushesRT(AllPushesRT == 0) = NaN; 

figure;

for ii = 1:size(AllPushesRT,2);
    for i = 1:size(AllPushesRT,1);
        PushTime = round(AllPushesRT(i,ii)); 
        if isnan(PushTime) ~= 1
            if PushTime < 250
                a(2,1) = a(2,1)+1; 
            else
                for cc = 2:size(a,2)
                    if PushTime > a(1,cc-1) && PushTime < a (1,cc)
                        a(2,cc) = a(2,cc) + 1; 
                    end
                end
            end
        end
    end
    subplot(m,n,p);
    bar(a(2,:), 'FaceColor', [0.8 0.8 0.8]);
    %axis([0 14000 0 inf]); 
    if p < (num_subplot)
        p = p+1;
    end
end





