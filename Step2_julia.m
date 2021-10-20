close all; clear all; clc
addpath(genpath('/Users/juliapaterson/Desktop/eeglab2021.0/'));%*
eeglab;
% ------------------------------------- ADHD * -----------------------------------------------------
% datafolder = '/Users/juliapaterson/Desktop/data/Raw/ADHD/'; 
% matfolder =  '/Users/juliapaterson/Desktop/data/Raw/ADHD/';
% 
% subject_folder = {'AD33C' 'AD34C' 'AD35C' 'AD36C' 'AD37C' 'AD81C' 'AD82C' 'AD83C' 'AD85C' 'AD84C' 'AD86C' 'AD88C' ...
% 'AD40C' 'AD11C' 'AD43C' 'AD18C' 'AD24C' 'AD52C' 'AD5C'...
%     'AD54C' 'AD75C' 'AD15C' 'AD49C' 'AD69C' 'AD32C' 'AD16C' 'AD72C'...
%     'AD59C' 'AD27C' 'AD46C' 'AD22C' 'AD26C' 'AD99C' 'AD48C' 'AD57C'...
%     'AD51C' 'AD19C' 'AD98C' 'AD25C' 'AD23C' };
% 
% %monash
% %'AD33' 'AD34' 'AD35' 'AD36' 'AD37' 'AD81' 'AD82' 'AD83' 'AD85' 'AD84C' 'AD86C' 'AD88C'
% 
% %uq
% %'AD40' 'AD11' 'AD43' 'AD18' 'AD24' 'AD52' 'AD5'...
%     %'AD54' 'AD75' 'AD15' 'AD49' 'AD69' 'AD32' 'AD16' 'AD72'...
%     %'AD59' 'AD27' 'AD46' 'AD22' 'AD26' 'AD99' 'AD48' 'AD57'...
%     %'AD51' 'AD19' 'AD98' 'AD25' 'AD23' 
% 
% sessionID = {'1_33' '1_34' '1_35' '1_36' '1_37' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86' '1_88' ...
%     '1_40' '1_11' '1_43' '1_18' '1_24' '1_52' '1_5'...
%     '1_54' '1_75' '1_15' '1_49' '1_69' '1_32' '1_16'...
%     '1_72' '1_59' '1_27' '1_46' '1_22' '1_26' '1_99' '1_48' '1_57'...
%     '1_51' '1_19' '1_98' '1_25' '1_23'};
% 
% %monash
% %'1_33' '1_34' '1_35' '1_36' '1_37' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86' '1_88'
% 
% %uq
% %  '1_40' '1_11' '1_43' '1_18' '1_24' '1_52' '1_5'...
%     %'1_54' '1_75' '1_15' '1_49' '1_69' '1_32' '1_16'...
%     %'1_72' '1_59' '1_27' '1_46' '1_22' '1_26' '1_99' '1_48' '1_57'...
%     %'1_51' '1_19' '1_98' '1_25' '1_23' 
%     
% monashSessionID = {'1_33' '1_34' '1_35' '1_36' '1_37' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86' '1_88'};
% %   '1_33' '1_34' '1_35' '1_36' '1_37' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86' '1_88'
% 
% allBlocks = {[1:10] [1:10] [1:10] [1:10] [1:10] [1:5] ... %s 6 ad81 check block by block 
%     [1:10] [1:5] [1:10] [1:10] [1:10] [1:10] ...
%     [1:10] [1:10] [1:7] [1:10] [1:10] [1:10] [1:10] [1:10] [1:11],...
%     [1:10] [1:10] [1:10] [1:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:9] [1:10],...
%     [1:10] [1:10] [1:11] [1:10] [1:10] [1:10]};
% 
% %monash
% % [1:10] [1:10] [1:10] [1:10] [1:10] [1:5] [1:10] [1:5] [1:10] [1:10] [1:10] [1:10]
% 
% %uq
% % [1:10] [1:10] [1:7] [1:10] [1:10] [1:10] [1:10] [1:10] [1:11],...
%     %[1:10] [1:10] [1:10] [1:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:9] [1:10],...
%     %[1:10] [1:10] [1:11] [1:10] [1:10] [1:10] 
% %-------------------------------------------------------------------------------------------------


% ------------------------------------- Control *---------------------------------------------------
datafolder = '/Users/juliapaterson/Desktop/data/Raw/Controls/'; 
matfolder =  '/Users/juliapaterson/Desktop/data/Raw/Controls/';

subject_folder = {'C133' 'C134' 'C135' 'C136' 'C137' 'C138' 'C139' 'C141' 'C500' 'C501' 'C502' ...
    'C503' 'C504' 'C505' 'C506' 'C507' 'C508' 'C509' 'C510' 'C511' 'C512' '001_KK' 'C12' 'C21' ...
    '002_LK' 'C50' 'C131' 'C20' 'C132' 'C213' 'C204' 'C171' 'C13' 'C119' 'C121' 'C194' 'C168' ...
    'C14' 'C49' 'C400' 'C100' 'C117' 'C115' 'C110' 'C183' 'C144' 'C252' 'C140' 'C259' 'C143' ...
    'C89' 'C62' 'C88' 'C84' 'C87'}; 
    
    %monash
    %'C133' 'C134' 'C135' 'C136' 'C137' 'C138' 'C139' 'C141' 'C500' 'C501' 'C502' ...
    %'C503' 'C504' 'C505' 'C506' 'C507' '508' 'C509' '510' 'C511' 'C512'}; 
    
    %uq
    %'001_KK' 'C12' 'C21' ...
    %'002_LK' 'C50' 'C131' 'C20' 'C132' 'C213' 'C204' 'C171' 'C13' 'C119' 'C121' 'C194' 'C168' ...
    %'C14' 'C49' 'C400' 'C100' 'C117' 'C115' 'C110' 'C183' 'C144' 'C252' 'C140' 'C259' 'C143' ...
    %'C89' 'C62' 'C88' 'C84' 'C87'};

sessionID = {'133' '134' '135' '136' '137' '138' '139' '141' '500' '501' '502' ...
    '503' '504' '505' '506' '507' '508' '509' '510' '511' '512' '001' '12' '21' ...
    '002' '50' '131' '20' '132' '213' '204' '171' '13' '119' '121' '194' '168' ...
    '14' '49' '400' '100' '117' '115' '110' '183' '144' '252' '140' '259' '143' ...
    '89' '62' '88' '84' '87'}; 

    %monash
    %'133' 'C134' '135' '136' '137' '138' '139' '141' 'C500' 'C501' '502' ...
    %'503' '504' '505' '506' '507' '508' '509' '510' '511' '512'}; 
    
    %uq
    %'001' '12' '21' ...
    %'002' '50' '131' '20' '132' '213' '204' '171' '13' '119' '121' '194' '168' ...
    %'14' '49' '400' '100' '117' '115' '110' '183' '144' '252' '140' '259' '143' ...
    %'89' '62' '88' '84' '87'};

monashSessionID = {'508' '133' '134' '135' '136' '137' '138' '139' '141' 'C500' 'C501' ...
    '502' '503' '504' '505' '506' '507' '508' '509' '510' '511' '512'}; 

    %monash
    %'133' '134' '135' '136' '137' '138' '139' '141' 'C500' 'C501' '502' '503' '504' '505' ...
    %'506' '507' '508' '509' '510' '511' '512'}; 

allBlocks = {[1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:5] [1:10] [1:10] [1:5] [1:5] [1:10] ...
    [1:10] [1:10] [1:10] [1:10] [1:10]...%c508 s17 change to run block by block here to check 
    [1:5] [1:10] [1:5] [1:10] [1:10] [1:11] [1:10] ...
    [1:10] [1:10] [1:10] [1:10] [1:10] [1:11] [1:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
    [1:4,6:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
    [1:10] [1:10]}; 

    %monash
    %[1:10] [1:10] [1:10] [1:10] [1:10] [1:5] [1:10] [1:10] [1:5] [1:5] [1:10] ...
    %[1:10] [1:10] [1:10] [1:10]  [1:10] [1:5] [1:10] [1:5] [1:10] [1:10]}; 
    
    %uq
    %[1:10] [1:10] ...
    %[1:10] [1:10] [1:10] [1:10] [1:10] [1:11] [1:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
    %[1:4,6:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
    %[1:10] [1:10]};
%---------------------------------------------------------------------------------------------------
exp_conditions = {'C'}; c = 1; 
file_start = 1;
for s=file_start:length(sessionID)
    matfile{s} = [datafolder subject_folder{s} '/' sessionID{s} '_' exp_conditions{c} '_chanvars.mat'];
end

%% Run
%monash to check
madhd = [1,3,7,8,9,10,11,12];
mcontrols = [2,3,4,5,6,7,9,10,11,12,14,15,16,18,20];

for s = m   controls %file_start:length(sessionID) %replace file_start where needed
    if ismember(sessionID{s},monashSessionID)
        chanlocs = load('ADHD_chanlocs.mat');
        chanlocs = chanlocs.chanlocs;
    else
        chanlocs = readlocs('cap64.loc');
    end
    disp(sessionID{s})
    load(matfile{s})
    chanVar = double(chanVar);
    avVar = mean(chanVar,2);
    
    % average variance for each channel across all 16 conditions
    % on a second sweep for a given subject, might want to plot topo again
    % after getting rid of a really bad one (to make it easier to see other
    % bad channels) - so do something like:
    % avVar(61) = avVar(56);  % quick hack - make a reall bad chan equal its neighbor

    figure;
    topoplot(avVar,chanlocs,'plotchans',[1:64],'electrodes','numbers');
    title(sessionID{s})
    %save topoplot, change to: c = control, a = adhd
    saveas(gcf, sprintf('c_s%d_channel_topoplot.png', s));
    
    figure; hold on
    plot(chanVar(1:64,:))
    title(sessionID{s})
    %save line plot
    saveas(gcf, sprintf('c_s%d_channel_plot.png', s));
end