function visualize_open(OPEN)
%This function visualizes the 2D grid map
%consist of obstacles/start point/target point/optimal path.

%open list
for open_cnt = 1:size(OPEN,1)
    scatter(OPEN(open_cnt,2)-0.5,OPEN(open_cnt,3)-0.5,'b');
    hold on;
end

end

