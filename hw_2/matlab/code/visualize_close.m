function visualize_close(CLOSED)
%This function visualizes the 2D grid map
%consist of obstacles/start point/target point/optimal path.

%closed list
for close_cnt = 1:size(CLOSED,1)
    scatter(CLOSED(close_cnt,1)-0.5,CLOSED(close_cnt,2)-0.5,'r','filled');
    hold on;
end
end

