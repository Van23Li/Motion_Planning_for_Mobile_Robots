function setup_paths()

% Add the neccesary paths

[pathstr,~,~] = fileparts(mfilename('fullpath'));

addpath(genpath([pathstr '/']));