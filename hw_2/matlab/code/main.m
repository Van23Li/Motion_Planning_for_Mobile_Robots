% Used for Motion Planning for Mobile Robots
% Thanks to HKUST ELEC 5660 
close all; clear all; clc;

setup_paths();

set(gcf, 'Renderer', 'painters');
set(gcf, 'Position', [500, 50, 700, 700]);

% Environment map in 2D space 
xStart = 1.0;
yStart = 1.0;
xTarget = 9.0;
yTarget = 9.0;
MAX_X = 10;
MAX_Y = 10;
map = obstacle_map(xStart, yStart, xTarget, yTarget, MAX_X, MAX_Y);

% Waypoint Generator Using the A* 
[path,OPEN,flag_NoPath] = A_star_search(map, MAX_X,MAX_Y);

% visualize the 2D grid map
if (flag_NoPath <= MAX_X * MAX_Y)
    visualize_map(map);
    visualize_path(path,OPEN);
else
    visualize_map(map);
    fprintf("There is not operated path")
end
