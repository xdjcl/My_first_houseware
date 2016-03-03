% coding for relief
% jcl 2016/3/3

% get data from .csv
data = csvread('E:\Users\Matlab\watermelon.csv',1,0)
[a,b] = size(data)

% define diff
diff = @(x,y) abs(x-y)

sigma = 1:b-1
% loop for the k-th feature
for k = 1:b-1
    resulst = 1:a
    % for the p-sample
    for p = 1:a
        % for the same class
        positive_class = data(find(data(:,b) == data(p,b)),:)
        
        % find the near_hit
        temp1 = positive_class(:,k) - data(p,k)
        positive_class(find(temp1 == min(temp1),1),:) = []
        location = find(abs(temp1) == min(abs(temp1)),1)
        result_positive = diff(data(p,k),positive_class(location,k))
        
        % for the different class
        negative_class = data(find(data(:,b) ~= data(p,b)),:)
        
        % find the near_miss
        temp1 = negative_class(:,k) - data(p,k)
        location = find(abs(temp1) == min(abs(temp1)),1)
        result_negative = diff(data(p,k),negative_class(location,k))
        
        % result
        result(p) = -result_negative + result_positive
    end
    
    segma(k) = sum(result)
end
segma
