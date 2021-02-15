function [path,OPEN,flag_NoPath] = A_star_search(map,MAX_X,MAX_Y)
%%
a_weight = 1;
b_weight = 0;
visualize_debug = 0;
%This part is about map/obstacle/and other settings
%pre-process the grid map, add offset
size_map = size(map,1);
Y_offset = 0;
X_offset = 0;

%Define the 2D grid map array.
%Obstacle=-1, Target = 0, Start=1
MAP=2*(ones(MAX_X,MAX_Y));

%Initialize MAP with location of the target
xval=floor(map(size_map, 1)) + X_offset;
yval=floor(map(size_map, 2)) + Y_offset;
xTarget=xval;
yTarget=yval;
MAP(xval,yval)=0;

%Initialize MAP with location of the obstacle
for i = 2: size_map-1
    xval=floor(map(i, 1)) + X_offset;
    yval=floor(map(i, 2)) + Y_offset;
    MAP(xval,yval)=-1;
end

%Initialize MAP with location of the start point
xval=floor(map(1, 1)) + X_offset;
yval=floor(map(1, 2)) + Y_offset;
xStart=xval;
yStart=yval;
MAP(xval,yval)=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LISTS USED FOR ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%OPEN LIST STRUCTURE
%--------------------------------------------------------------------------
%IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n)
%|g(n)|f(n)|index|parent_index
%--------------------------------------------------------------------------
OPEN=[];
%CLOSED LIST STRUCTURE
%--------------
%X val | Y val |
%--------------
% CLOSED=zeros(MAX_VAL,2);
CLOSED=[];

%Put all obstacles on the Closed list
k=1;%Dummy counter
for i=1:MAX_X
    for j=1:MAX_Y
        if(MAP(i,j) == -1)
            CLOSED(k,1)=i;
            CLOSED(k,2)=j;
            k=k+1;
        end
    end
end
CLOSED_COUNT=size(CLOSED,1);
%set the starting node as the first node
xNode=xval;
yNode=yval;
OPEN_COUNT=1;
goal_distance=distance(xNode,yNode,xTarget,yTarget);
path_cost=0;
OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,xNode,yNode,goal_distance,path_cost,b_weight*goal_distance + a_weight*path_cost,1,0);
OPEN(OPEN_COUNT,1)=0;
NoPath=1;
if (visualize_debug == 1)
    visualize_map(map);
end
%%
%This part is your homework
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% START ALGORITHM
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag_NoPath = 0;
total_num = MAX_X * MAX_Y;
while(NoPath && flag_NoPath <= total_num) %you have to dicide the Conditions for while loop exit
    [i_min, flag_goal] = min_fn(OPEN,OPEN_COUNT,xTarget,yTarget);
    if(flag_goal == 1)
        index_target = i_min;
        NoPath = 0;
    end
    if(i_min == -1)
        i_min = 1;
    end
    OPEN(i_min,1)=0;
    CLOSED_COUNT = CLOSED_COUNT + 1;
    CLOSED(CLOSED_COUNT,1) = OPEN(i_min,2);
    CLOSED(CLOSED_COUNT,2) = OPEN(i_min,3);
    node_x = OPEN(i_min,2);
    node_y = OPEN(i_min,3);
    gn = OPEN(i_min,7);
    exp_array = expand_array(node_x,node_y,gn,xTarget,yTarget,CLOSED,MAX_X,MAX_Y,a_weight,b_weight);
    flag_OPEN = 1;
    for i = 1 : size(exp_array,1)
        for j = 1 : size(OPEN,1)
            if (OPEN(j,2) == exp_array(i,1) && OPEN(j,3) == exp_array(i,2))
                flag_OPEN = 0;break;
            end
        end
        if (flag_OPEN == 1)
            OPEN_COUNT = OPEN_COUNT + 1;
            xNode = exp_array(i,1);
            yNode = exp_array(i,2);
            goal_distance = exp_array(i,3);
            path_cost = exp_array(i,4);
            OPEN(OPEN_COUNT,:)=insert_open(xNode,yNode,node_x,node_y,goal_distance,path_cost,b_weight*goal_distance + a_weight*path_cost,OPEN_COUNT,i_min);
            if(visualize_debug == 1)
                visualize_open(OPEN(size(OPEN,1),:));
            end
        else
            if (OPEN(j,7) > exp_array(i,4))
                OPEN(j,4) = node_x;
                OPEN(j,5) = node_y;
                OPEN(j,6) = exp_array(i,3);
                OPEN(j,7) = exp_array(i,4);
                OPEN(j,8) = exp_array(i,5);
                OPEN(j,10) = i_min;
            end
            flag_OPEN = 1;
        end %End of While Loop
        
    end
    if(visualize_debug == 1)
        visualize_close(CLOSED(size(CLOSED,1),:));
    end
    flag_NoPath = flag_NoPath + 1;
end
% visualize_pro(OPEN,CLOSED);
%Once algorithm has run The optimal path is generated by starting of at the
%last node(if it is the target node) and then identifying its parent node
%until it reaches the start node.This is the optimal path

%
%How to get the optimal path after A_star search?
%please finish it
%

path = [index_target];
while (OPEN(path(1),10) ~= 0)
    path = [OPEN(path(1),10),path];
end
end
