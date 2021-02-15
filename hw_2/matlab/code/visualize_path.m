function visualize_path(path,OPEN)
%This function visualizes the 2D grid map
%consist of obstacles/start point/target point/optimal path.


%optimal path
for path_cnt = 2:size(path,2)-1
    scatter(OPEN(path(path_cnt),2)-0.5,OPEN(path(path_cnt),3)-0.5,'g','filled');
    hold on;
end
end

