% k_means demo
% jcl 016-2-29

% generate x && y stochastically
M = 100
x = rand(M,1);
y = rand(M,1);

% give the value of k and
% initialization
k = input('please give the value of k: ');
x_init = rand(k,1);
y_init = rand(k,1);
diff = 2

dist = @(x1,x2,y1,y2) (x2-x1)^2+(y2-y1)^2;

% loop
while(diff > 0.0001)    
    % get the dist_mat
    dist_mat = ones(k,M);
    for m = 1:k
        for n = 1:M
            dist_mat(m,n) = dist(x(n),x_init(m),y(n),y_init(m));
        end
    end
    
    % find the neig_mat
    neig_mat = ones(M,1);
    for n = 1:M
        neig_mat(n) = find(dist_mat(:,n) == min(dist_mat(:,n)),1);
    end
    
    x_new = ones(k,1)
    y_new = ones(k,1)
    pause(1)
    figure

    for m = 1:k
        category = find(neig_mat == m);
        plot(x(category),y(category),'Marker',...
            '.','Color',[1-m/k,0,m/k],'LineStyle','none')
        hold on
        
        % regain the cluster
        x_new(m) = mean(x(category));
        y_new(m) = mean(y(category));
    end
    
  
    diff = max(abs(max([x_new-x_init; y_new-y_init])))
    x_init = x_new
    y_init = y_new
    plot(x_init,y_init,'r*')
end
