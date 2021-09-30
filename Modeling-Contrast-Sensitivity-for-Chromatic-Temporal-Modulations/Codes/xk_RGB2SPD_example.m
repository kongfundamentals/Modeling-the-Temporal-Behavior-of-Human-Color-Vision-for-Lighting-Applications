%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%---------------------------------
% Header
%---------------------------------
%
% Function: This is an example showing how to reconstruct the SPD of a
% stimulus given the normalized (i.e., between 0~1) R, G, B values.
% Programmer: Xiangzhen Kong
% E-mail: kongfundamentals@gmail.com
%
%---------------------------------
% Input
%---------------------------------
%
% The normalized (i.e., between 0~1) R, G, B values
%
%---------------------------------
% Ouput
%---------------------------------
%
% The SPD of the stimulus in SI unit.
%
%---------------------------------
% Usage
%---------------------------------
%
% [SPD] = xk_RGB2SPD_example(0.5, 0.5, 0.5);
% [SPD] = xk_RGB2SPD_example(1, 1, 1);
%
%---------------------------------
% NB
%---------------------------------
%
% This program is not optimized in any way for memory allocation or
% performance. Instead, it demonstrates how to use the provided .mat file
% to reconstruct the SPD.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [SPD] = xk_RGB2SPD_example(R, G, B)
if nargin ~= 3
    % By default, it shows the SPDs of the full Red, full Green and full Blue
    R = 1;
    G = 1;
    B = 1;
end

filename = ['..' filesep 'Data' filesep 'SPDs_fullRedFullGreenFullBlue2.mat'];

try
    % 380 nm - 1nm - 780 nm
    if exist('RGB_SPD', 'var') == 0
        persistent RGB_SPD;
        load(filename, 'RGB_SPD');
    end
    RGB_SPD = table2array(RGB_SPD);
    Red_SPD     = RGB_SPD(:,2);
    Green_SPD   = RGB_SPD(:,3);
    Blue_SPD    = RGB_SPD(:,4);
    
    %% Visualize the SPDs of the three primaries
    figure;
    subplot(1, 2, 1);
    hold on;
    title('SPDs of the primaries (RGB = [1 1 1])');
    plot(RGB_SPD(:, 1), Red_SPD,    'r-', 'LineWidth', 2);
    plot(RGB_SPD(:, 1), Green_SPD,  'g-', 'LineWidth', 2);
    plot(RGB_SPD(:, 1), Blue_SPD,   'b-', 'LineWidth', 2);
    xlabel('Wavelength (nm)');
    ylabel('Radiance (SI unit)');
    box on
    grid on
    axis square
    legend('Red', 'Green', 'Blue');
    
    SPD = Red_SPD.*R + Green_SPD.*G + Blue_SPD.*B;
    
    %% Visualize the SPD of the mixed light stimulus
    subplot(1, 2, 2);
    hold on;
    title(['SPDs of the input RGB values (RGB = [' num2str(R) ' ' num2str(G) ' ' num2str(B) '])']);
    plot(RGB_SPD(:, 1), SPD,    'k-', 'LineWidth', 2);
    xlabel('Wavelength (nm)');
    ylabel('Radiance (SI unit)');
    box on
    grid on
    axis square
    legend('SPD');
catch
    error('Please check whether the file path is correct or not!');
end

end

