%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%---------------------------------
% Header
%---------------------------------
%
% Function: This is an example of using the data files to fit TCSFs.
% Programmer: Xiangzhen Kong
% E-mail: kongfundamentals@gmail.com
%
%---------------------------------
% Input
%---------------------------------
%
% The corrected L, M, S values of the isoluminant chromatic flicker
% (9 base colors × 4 modulation directions = 36)
% stimuli (when amplitude = threshold)
%
%---------------------------------
% Ouput
%---------------------------------
%
% R-squares, slopes, and intercepts of the 36 TCSFs respectively.
%
%---------------------------------
% Usage
%---------------------------------
%
% [Rsquares_36_conditions, slopes_36, intercepts_36] = xk_CIC_Figure6_v2(1)
% [Rsquares_36_conditions, slopes_36, intercepts_36] = xk_CIC_Figure6_v2(2)
% [Rsquares_36_conditions, slopes_36, intercepts_36] = xk_CIC_Figure6_v2(3)
%
%---------------------------------
% NB
%---------------------------------
%
% This program is not optimized in any way for memory allocation or
% performance. Instead, it demonstrates how to use the provided .csv files
% to fit TCSFs in a step-by-step manner.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Rsquares_36_conditions, slopes_36, intercepts_36] = xk_fit_TCSF_example(participantID)

%% Participant info and file info
global participantName;
global participantFileName;
if nargin == 0
    % By default Mij's data (as in accordance with the graph in the paper)
    participantName = 'Mij_Data';
    participantFileName = 'MB';
else
    if participantID == 1
        participantName = 'Kon_Data';
        participantFileName = 'XK';
        
    end
    if participantID == 2
        participantName = 'Ann_Data';
        participantFileName = 'AM';
    end
    if participantID == 3
        participantName = 'Mij_Data';
        participantFileName = 'MB';
    end
end

%% Hard-coded base color coordinates (2-degree)
colorsUV = [
0.127304	0.52131
0.225072	0.166347
0.450927	0.482579
0.289116	0.501944
0.176188	0.343829
0.337999	0.324463
0.267768	0.390079
0.239304	0.240924
0.389874	0.451746];

%% Visualization related parameters
fontSizeLabelAndLegend = 12;
MarkerSize = 10;
figure_total_size = 3.4;

%% Load the data

filename = ['..' filesep 'Data' filesep participantName];

[dataPure,header_label] = il_read_data_fromCSV([filename '.csv']); % read CSV file

%% Calculations 
DeltaUV = zeros(size(dataPure, 1), 3);  % 3 cols for DeltaU, DeltaV and DeltaUV.

DeltaLMS = zeros(size(dataPure, 1),7);  % 3 cols for DeltaL DeltaM DeltaS; 
                                        % 3 cols for DeltaL/L, DeltaM/M, DeltaS/S;
                                        % 1 col for DeltaLMS
                           
Deltalms = zeros(size(dataPure, 1),10); % 3 cols for l1, m1, s1; 
                                        % 3 cols for l2, m2, s2; 
                                        % 3 cols for Deltal, Deltam, Deltas.
                                        % 1 col for Deltalms.
                                                          
%% Step 0.1: DeltaU
idx = il_find_idx_from_header(header_label, '''U1_Corrected'''); % with double quote in array...
uPrime1 = dataPure(:,idx);
idx = il_find_idx_from_header(header_label, '''U2_Corrected'''); % with double quote in array...
uPrime2 = dataPure(:,idx);

DeltaUV(:,1) = abs(uPrime1 - uPrime2);

%% Step 0.2: DeltaV
idx = il_find_idx_from_header(header_label, '''V1_Corrected'''); % with double quote in array...
vPrime1 = dataPure(:,idx);
idx = il_find_idx_from_header(header_label, '''V2_Corrected'''); % with double quote in array...
vPrime2 = dataPure(:,idx);

DeltaUV(:,2) = abs(vPrime1 - vPrime2);

%% Step 0.3: DeltaUV
DeltaUV(:,3) = sqrt(DeltaUV(:,1).^2 + DeltaUV(:,2).^2);

%% Step 1.1: DeltaL
idx = il_find_idx_from_header(header_label, '''L1_Corrected'''); % with double quote in array...
L1 = dataPure(:,idx);
idx = il_find_idx_from_header(header_label, '''L2_Corrected'''); % with double quote in array...
L2 = dataPure(:,idx);

DeltaLMS(:,1) = abs(L1 - L2);

%% Step 1.2: DeltaM
idx = il_find_idx_from_header(header_label, '''M1_Corrected'''); % with double quote in array...
M1 = dataPure(:,idx);
idx = il_find_idx_from_header(header_label, '''M2_Corrected'''); % with double quote in array...
M2 = dataPure(:,idx);

DeltaLMS(:,2) = abs(M1 - M2);

%% Step 1.3: DeltaS
idx = il_find_idx_from_header(header_label, '''S1_Corrected'''); % with double quote in array...
S1 = dataPure(:,idx);
idx = il_find_idx_from_header(header_label, '''S2_Corrected'''); % with double quote in array...
S2 = dataPure(:,idx);

DeltaLMS(:,3) = abs(S1 - S2);

%% Step 2: DeltaL/L, DeltaM/M, DeltaS/S.

DeltaLMS(:,4) = 2 * DeltaLMS(:,1)./ (L1 + L2);
DeltaLMS(:,5) = 2 * DeltaLMS(:,2)./ (M1 + M2);
DeltaLMS(:,6) = 2 * DeltaLMS(:,3)./ (S1 + S2);

DeltaLMS(:,7) = sqrt(DeltaLMS(:,1).^2 + DeltaLMS(:,2).^2 + DeltaLMS(:,3).^2);

%% Step 3.1: l1, m1, s1
Deltalms(:,1) = L1./ (L1 + M1 + S1);
Deltalms(:,2) = M1./ (L1 + M1 + S1);
Deltalms(:,3) = S1./ (L1 + M1 + S1);

%% Step 3.2: l2, m2, s2
Deltalms(:,4) = L2./ (L2 + M2 + S2);
Deltalms(:,5) = M2./ (L2 + M2 + S2);
Deltalms(:,6) = S2./ (L2 + M2 + S2);

%% Step 4: Deltal, Deltam, Deltas.
Deltalms(:,7) = abs(Deltalms(:,1) - Deltalms(:,4));
Deltalms(:,8) = abs(Deltalms(:,2) - Deltalms(:,5));
Deltalms(:,9) = abs(Deltalms(:,3) - Deltalms(:,6));

Deltalms(:,10) = sqrt(Deltalms(:,7).^2 + Deltalms(:,8).^2 + Deltalms(:,9).^2);

%% Use a filter
% dataResults = il_filter(dataPure,0,2,45,4);
% dataResults = il_filter(dataPure,1,2,45,4);
% Directions = [0 45 90 135];
% two different starting lumiance ratios
% SA = [0 1];
% BaseColors = [1:9];
Frequency = [2 4 8 10 15 20 25];
                                            % 1 2 3 4   5-11     12-21    22-24
data_BC_SA_D_F_LMS_lms_deltaUV = [dataPure(:,[1 2 5 6]) DeltaLMS Deltalms DeltaUV];


%% Plot
SUBPLOT_ROW = 3;
SUBPLOT_COLUMN = 3;
Directions = 0:45:135;
BaseColor = 1:9;

%% Three different ways of doing the fitting
Rsquares_36_conditions = [];
slopes_36 = [];
intercepts_36 = [];

%% Visualization
hFig = figure;
hold on;
COLUMN = 11;
% changing the Lightness thus change the RGB values of the lines
RGB_L_of_UVL = 50:10:80;
for numberSubplot = 1: SUBPLOT_ROW * SUBPLOT_COLUMN
    switch numberSubplot
        case 1
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 2
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 3
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 4
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 5
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 6
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 7
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 8
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        case 9
            handle = subplot(SUBPLOT_ROW,SUBPLOT_COLUMN,numberSubplot);
        otherwise
    end
    
    hold(handle,'on')
    grid on
    symbols = {'o','d','s','<'};
    hPointsTemp = [];
    for DIRECTION = 1:length(Directions)  
        dataResults_SA_0 = [];
        dataResults_SA_1 = [];
        for F=1:length(Frequency)
            % numberSubplot =         1     2     3     4     5     6     7     8     9    10    11    12
            % ceil(numberSubplot/3) = 1     1     1     2     2     2     3     3     3     4     4     4
            % Each row means the same direction
            dataResults_SA_0 = [dataResults_SA_0 il_filter(data_BC_SA_D_F_LMS_lms_deltaUV,BaseColor(numberSubplot),0,Directions(DIRECTION),Frequency(F))]; %#ok
            dataResults_SA_1 = [dataResults_SA_1 il_filter(data_BC_SA_D_F_LMS_lms_deltaUV,BaseColor(numberSubplot),1,Directions(DIRECTION),Frequency(F))]; %#ok
        end
        [temp_row, temp_col] = size(data_BC_SA_D_F_LMS_lms_deltaUV); %#ok
        plotData_SA_0 = reshape(dataResults_SA_0,temp_col,int8(length(dataResults_SA_0)/temp_col))';
        plotData_SA_1 = reshape(dataResults_SA_1,temp_col,int8(length(dataResults_SA_1)/temp_col))';
        
        %% Pay attention how to do the average
        plotData_SA_Average = (plotData_SA_0 + plotData_SA_1) / 2;
        dataFitX = Frequency';
        dataFitY = log(1./plotData_SA_Average(:,COLUMN));
        beta = polyfit(dataFitX, dataFitY, 1);
        regstats(dataFitY,dataFitX,'linear',{'rsquare'})
        Rsquares_36_conditions = [Rsquares_36_conditions ans.rsquare]; %#ok
        ylabel('$$1/log_{e}\Delta\it LMS$$','FontSize',fontSizeLabelAndLegend,'interpreter','latex');
        ylabel('$$\frac{1}{log_{e}\Delta\it LMS}$$','FontSize',fontSizeLabelAndLegend,'Rotation',90,'interpreter','latex');
        ylabel('$$\it ln\frac{1}{\Delta\it LMS}$$','FontSize',fontSizeLabelAndLegend,'Rotation',90,'interpreter','latex');
        colorRGB = il_MIJ_uvltorgb(colorsUV(numberSubplot,1), colorsUV(numberSubplot,2), RGB_L_of_UVL(DIRECTION));
        hTemp = plot(handle, Frequency',dataFitY ,symbols{DIRECTION},'color',colorRGB,'LineWidth',0.5,'MarkerSize',MarkerSize,'MarkerEdgeColor',colorRGB,'MarkerFaceColor',colorRGB);
        hPointsTemp = [hPointsTemp hTemp]; %#ok
        x = 1:25;
        plot(x, beta(1) * x + beta(2), '-','color',colorRGB,'LineWidth',0.5,'MarkerSize',MarkerSize,'MarkerEdgeColor',colorRGB,'MarkerFaceColor',colorRGB);
        slopes_36 = [slopes_36 beta(1)]; %#ok
        intercepts_36 = [intercepts_36 beta(2)]; %#ok
    end
        hLegend = legend([hPointsTemp],[num2str(Directions(1)) '$$^{\circ}$$'],[num2str(Directions(2)) '$$^{\circ}$$'],[num2str(Directions(3)) '$$^{\circ}$$'],[num2str(Directions(4)) '$$^{\circ}$$'],'location','best');%#ok
        legend('boxoff');
        set(hLegend,'FontSize',fontSizeLabelAndLegend-3,'interpreter','latex');
        set(gca,'FontName','Times New Roman','YLim',[2 10],'ytick',2:2:10,'xtick',Frequency, 'xticklabel',Frequency,'XLim',[0 25],'FontSize',fontSizeLabelAndLegend);
        title([ upper(participantFileName) ' BC ' num2str(BaseColor(numberSubplot)) ],'interpreter','latex','FontSize',fontSizeLabelAndLegend);
        xlabel('Frequency (Hz)','FontSize',fontSizeLabelAndLegend,'interpreter','latex');

end
%% Uncomment some of the lines to save the output or save the figures
    %save([upper(participantFileName) '_Rsquares_Slopes_intercepts_36_conditions.mat'], 'Rsquares_36_conditions','slopes_36', 'intercepts_36');
    %disp('Output:\n')
    %disp('Mean R2 of each base color');
    %mean(reshape(Rsquares_36_conditions,4,9),1)
    %disp('Overall mean R2');
    %mean(mean(reshape(Rsquares_36_conditions,4,9)))
    set(hFig,'PaperUnits','inches','PaperPosition',[0 0 figure_total_size figure_total_size]);
    %set(hFig,'PaperUnits','inches','PaperPosition',[0 0 5 5]);
    %filename     = [participantName '_BC_' num2str(bc) '.tiff'];
    %filename_png = [upper(participantFileName) '_BC_' num2str(BaseColor) '.png'];
    %print('-dtiff', filename,       '-r600');
    %print('-dpng',  filename_png,   '-r600');
    %close(hFig);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [dataPure,header_label] = il_read_data_fromCSV(filename)

data = il_aaov_Get_text_from_txt(filename); % each line in a separate cell
rows2read = 2; % first row to read
cols2read = 2; % first col to read

header_label = il_aaov_strsplit(data{1},',');
header_label = header_label(cols2read:end);

for i = rows2read:size(data,2)
    
    data_cell = il_aaov_strsplit(data{i},',');
    for j = cols2read:length(data_cell)
        dataPure(i-1,j-1) = str2num(data_cell{j}); %#ok
    end   
end

%disp('')
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dataResults = il_filter(data_BC_SA_D_F_LMS_lms,BC,SA,Direction,F)

% BC
dataResults= data_BC_SA_D_F_LMS_lms(find(data_BC_SA_D_F_LMS_lms(:,1)== BC),:);  %#ok
% Starting amplitude
dataResults = dataResults(find(dataResults(:,2)== SA),:);                       %#ok
% Direction
dataResults = dataResults(find(dataResults(:,3)== Direction),:);                %#ok
% F
dataResults = dataResults(find(dataResults(:,4)== F),:);                        %#ok
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function idx = il_find_idx_from_header(header_label,label2find)

bFound = 0;

Nlabels = length(header_label);
count = 1;

while bFound == 0 | count < Nlabels %#ok
    try % try and catch only used to debug
        bMatch = strcmp(header_label{count},label2find);
    catch
%         disp('')
    end
    if bMatch == 1
        idx = count;
        bFound = 1;
    end
    count = count+1;
end

if bFound == 0
    warning('Header not found...')
end
end


function txtout = il_aaov_Get_text_from_txt(file)
fid             = fopen(file);
tline           = fgetl(fid);

i = 1;
while ischar(tline)
    txtout{i} = tline; %#ok
    tline = fgetl(fid);
    i = i+1;
end

fclose(fid);

end



function r = il_aaov_strsplit(s,d)
% split string s into cell of strings using delimiter d
r={};
prev=1;
count=1;
for i=1:length(s)
    if (s(i)==d)
        if (prev<=i-1)
            r{count}=s(prev:i-1); %#ok
        end
        count=count+1;
        prev=i+1;
    end
end

r{count}=s(prev:end);
end



function rgb = il_MIJ_uvltorgb(U, V, L)

RefX = 95.047;
RefY = 100.000;
RefZ = 108.883;
Ua = 13 * L * (U - 0.2009);
Va = 13 * L * (V - 0.4610);

var_Y = (L + 16) / 116;

if (var_Y ^ 3) > 0.008856
    var_Y = var_Y ^ 3;
else
    var_Y = (var_Y - 16 / 116) / 7.787;
end

ref_U = (4 * RefX) / (RefX + (15 * RefY) + (3 * RefZ));
ref_V = (9 * RefY) / (RefX + (15 * RefY) + (3 * RefZ));

var_U = Ua / (13 * L) + ref_U;
var_V = Va / (13 * L) + ref_V;

Y = var_Y * 100;
X = -(9 * Y * var_U) / ((var_U - 4) * var_V - var_U * var_V);
Z = (9 * Y - (15 * var_V * Y) - (var_V * X)) / (3 * var_V);

var_X = X / 100;
var_Y = Y / 100;
var_Z = Z / 100;

var_R = var_X * 3.2406 + var_Y * -1.5372 + var_Z * -0.4986;
var_G = var_X * -0.9689 + var_Y * 1.8758 + var_Z * 0.0415;
var_B = var_X * 0.0557 + var_Y * -0.2040 + var_Z * 1.0570;

if (var_R > 0.0031308) 
    var_R = 1.055 * (var_R ^(1 / 2.4)) - 0.055;
else
    var_R = 12.92 * var_R;
end
if (var_G > 0.0031308) 
    var_G = 1.055 * (var_G ^(1 / 2.4)) - 0.055;
else
    var_G = 12.92 * var_G;
end

if (var_B > 0.0031308) 
    var_B = 1.055 * (var_B ^(1 / 2.4)) - 0.055;
else
    var_B = 12.92 * var_B;
end


if var_R < 0
    var_R = 0;
elseif var_R > 1
    var_R = 1;
end
if var_G < 0
    var_G = 0;
elseif var_G > 1
    var_G = 1;
end
if var_B < 0
    var_B = 0;
elseif var_B > 1
    var_B = 1;
end


rgb = [var_R, var_G, var_B];

end





