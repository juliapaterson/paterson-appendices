% Run the script for each group seperately (ADHD, Control)
clear all; close all; clc
dataToExamin = 'Control';%'ADHD';%Control'

% Define your paths
cd('/Users/juliapaterson/Documents/github/honours-2021/matlab/'); % path to your scripts folder
addpath(genpath('/Users/juliapaterson/Desktop/eeglab2021.0/'));
addpath(genpath('/Users/juliapaterson/Documents/github/honours-2021/matlab/eye-eeg-master/'));
eeglab;
%% -------------------------------------------------------------------------------------------------
% -------------------------------------------ADHD---------------------------------------------------
if strcmp(dataToExamin, 'ADHD')
datafolder = '/Users/juliapaterson/Desktop/data/Raw/ADHD/'; 
matfolder =  '/Users/juliapaterson/Desktop/data/Raw/ADHD/';
pathOut = '/Users/juliapaterson/Desktop/data/Analyzed/ADHD/';

%exclude ad36 - missing eyetracking .edf, 137 eyetracking, 188 in step 2

% Name of subject folders (Both UQ and Monash)
subject_folder = {'AD33C' 'AD34C' 'AD35C' 'AD81C' 'AD82C' 'AD83C' 'AD85C' 'AD84C' 'AD86C' ...
'AD40C' 'AD11C' 'AD43C' 'AD18C' 'AD24C' 'AD52C' 'AD5C'...
    'AD54C' 'AD75C' 'AD15C' 'AD49C' 'AD69C' 'AD32C' 'AD16C' 'AD72C'...
    'AD59C' 'AD27C' 'AD46C' 'AD22C' 'AD26C' 'AD99C' 'AD48C' 'AD57C'...
    'AD51C' 'AD19C' 'AD98C' 'AD25C' 'AD23C'};

%monash
%'AD33' 'AD34' 'AD35' 'AD36' 'AD37' 'AD81' 'AD82' 'AD83' 'AD85' 'AD84C' 'AD86C' 'AD88C'

%uq
%'AD40' 'AD11' 'AD43' 'AD18' 'AD24' 'AD52' 'AD5'...
    %'AD54' 'AD75' 'AD15' 'AD49' 'AD69' 'AD32' 'AD16' 'AD72'...
    %'AD59' 'AD27' 'AD46' 'AD22' 'AD26' 'AD99' 'AD48' 'AD57'...
    %'AD51' 'AD19' 'AD98' 'AD25' 'AD23' 

% Prefix of subjects files (Both UQ and Monash)
sessionID = {'1_33' '1_34' '1_35' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86' ...
    '1_40' '1_11' '1_43' '1_18' '1_24' '1_52' '1_5'...
    '1_54' '1_75' '1_15' '1_49' '1_69' '1_32' '1_16'...
    '1_72' '1_59' '1_27' '1_46' '1_22' '1_26' '1_99' '1_48' '1_57'...
    '1_51' '1_19' '1_98' '1_25' '1_23'};

%monash
%'1_33' '1_34' '1_35' '1_36' '1_37' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86' '1_88'

%uq
%  '1_40' '1_11' '1_43' '1_18' '1_24' '1_52' '1_5'...
    %'1_54' '1_75' '1_15' '1_49' '1_69' '1_32' '1_16'...
    %'1_72' '1_59' '1_27' '1_46' '1_22' '1_26' '1_99' '1_48' '1_57'...
    %'1_51' '1_19' '1_98' '1_25' '1_23'

% Prefix of only Monash subjects files 
monashSessionID = {'1_33' '1_34' '1_35' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86'};
%   '1_33' '1_34' '1_35' '1_36' '1_37' '1_81' '1_82' '1_83' '1_85' '1_84' '1_86' '1_88'


% Each subject's blocks. The value comming after C in the files name. e.g., they can be from _C1 to _C10 > [1:10] or maybe you don't have C1 and it starts from _C2 to _C7 [2:7]
allBlocks = {[1:10] [1:10] [1:10] [1:5] [1:10] [1:5] [1:10] [1:10] [1:10]  ...
    [1:10] [1:10] [1:7] [1:10] [1:10] [1:10] [1:10] [1:10] [1:11],...
    [1:10] [1:10] [1:10] [1:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:9] [1:10],...
    [1:10] [1:10] [1:11] [1:10] [1:10] [1:10]};

%monash
% [1:10] [1:10] [1:10] [1:10] [1:10] [1:5] [1:10] [1:5] [1:10] [1:10] [1:10] [1:10]

%uq
% [1:10] [1:10] [1:7] [1:10] [1:10] [1:10] [1:10] [1:10] [1:11],...
    %[1:10] [1:10] [1:10] [1:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:9] [1:10],...
    %[1:10] [1:10] [1:11] [1:10] [1:10] [1:10] 
    
duds = [];

% The channels that you have excluded for each subject
    %exclude for lack of eyetracking[] %'AD36C'

allbadchans = {
    [2,64] %'AD33C'
    [10,44,48,19] %'AD34C'
    [34,35,40] %'AD35C'
    [14,48,20,58,63,10,9,19,62,53,25,61] %'AD81C'
    [48] %'AD82C'
    [8,38,64,59] %'AD83C'
    [30,18,24,63,16] %'AD85C'
    [6] %'AD84C'
    [13,42,38,10] %'AD86C'
    [7,34,33,36,42,52,60,62]%'AD40C'
    [2,5,42,34,35,7,50,15,52] %AD11C
    [7,9,14,15,24,42,61]%AD43C
    [51,52,62] %'AD18C'
    [2,3,7,16,18,24,35,41,44,52,60,61]%AD24C
    [2,19,28,35]%AD52C
    [7,58]%AD5C
    [50,52,55,58,62]%AD54C
    [2,8,24,34,35,64]%AD75C
    [31,15,34,53]%AD15C
    [2,15,16,34,35,41,42,52] %AD49C
    [2,7,16,28,42] %AD69C
    [15,6] %AD32C
    [7,28,52]%AD16C
    [61] %AD72C
    [] %AD59C
    [51] %AD27C
    [7,21,40] %AD46C
    [24,52] %AD22C
    [1,2,31,33,34,35] %AD26C
    [1,2,15,33,52,57] %AD99C
    [2,6,34] %AD48C
    [2,24,35,57,61] %AD57C
    [2,15,24,52] %AD51C
    [] %AD19C
    [7,35,57] %AD98C
    [5,16] %AD25C
    [2,52]}; %AD23C

%% -------------------------------------------------------------------------------------------------
% -------------------------------Control------------------------------------------------------------
elseif strcmp(dataToExamin, 'Control')
datafolder = '/Users/juliapaterson/Desktop/data/Raw/Controls/'; 
matfolder =  '/Users/juliapaterson/Desktop/data/Raw/Controls/';
pathOut = '/Users/juliapaterson/Desktop/data/Analyzed/Controls/';

% Name of subject folders (Both UQ and Monash)
%exclude c133 due to lack of eyetracking (.edf)
subject_folder = {'C134' 'C135' 'C136' 'C137' 'C138' 'C139' 'C141' 'C500' 'C501' 'C502' ...
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
    
% Prefix of subjects files (Both UQ and Monash)
sessionID = {'134' '135' '136' '137' '138' '139' '141' '500' '501' '502' ...
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
    
% Prefix of only Monash subjects files 
monashSessionID = {'134' '135' '136' '137' '138' '139' '141' '500' '501' ...
    '502' '503' '504' '505' '506' '507' '508' '509' '510' '511' '512'}; 

    %monash
    %'133' '134' '135' '136' '137' '138' '139' '141' 'C500' 'C501' '502' '503' '504' '505' ...
    %'506' '507' '508' '509' '510' '511' '512'};

% Each subject's blocks. The value comming after C in the files name. e.g., they can be from _C1 to _C10 > [1:10] or maybe you don't have C1 and it starts from _C2 to _C7 [2:7]

%500 - exclude block 3 - this is all due to the monash eyetracker issue
%503 - exclude block 5
%504 - exclude block 4
%506 - exclude block 6
%511 - exclude block 4

allBlocks = {[1:10] [1:10] [1:10] [1:10] [1:4] [1:10] [1:10] [1:2] [1:5] [1:4, 6:9] ...
     [1:4,6:10] [1,3,5:10] [1:3,5:10] [1:5,7:10] [1:10] [1:3,5] [1:10] [1:2,4:5] [1:3,5:10] [1:10] [1:11] [1:10] ...
     [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
     [1:10] [1:10] [1:10] [1:10] [1:4,6:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
     [1:10] [1:10] [1:10] [1:10] [1:10] [1:10]};

    %monash
    %[1:10] [1:10] [1:10] [1:10] [1:10] [1:4] [1:10] [1:10] [1:5] [1:5] [1:10] ...
    %[1:10] [1:10] [1:10] [1:10]  [1:10] [1:5] [1:10] [1:5] [1:10] [1:10]}; 
    
    %uq
    %[1:10] [1:10] ...
    %[1:10] [1:10] [1:10] [1:10] [1:10] [1:11] [1:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
    %[1:4,6:11] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] [1:10] ...
    %[1:10] [1:10]};

duds = [];

% The channels that you have excluded for each subject
%[29,31] %'C133'
allbadchans = {
    [3,16] %'C134'
    [1,22,64] %'C135'
    [1,2] %'C136'
    [12,36,1,2] %'C137'
    [60,61,62,63,12] %'C138'
    [39,53] %'C139'
    [] %'C141'
    [12,16]%'C500'
    [38,41,42,17] %'C501'
    [48,52,53,57,58,63,64,54,50,55] %'C502'
    [43,47,48,62,59,64] %'C503'
    [] %'C504'
    [60,61,62,63,64] %'C505'
    [26,63] %'C506'
    [60,61,63,64] %'C507'
    [48, 60, 39, 45, 53, 46, 37, 38, 43, 57, 54] %'C508'
    [62,63,64] %'C509'
    [56,60,53,28] %'C510'
    [64] %'C511'
    [] %'C512'
    [11,15,40,52,57] %001_KK
    [52,2] %C12
    [20,31]%C21
    [2,5,35] %002_LK
    [15,52]% C50
    [15,57]% C131
    [2,43]% C20
    [5,11,48]% C132
    [52]% C213
    [8,16,52]% C204
    []% C171
    [15,16,24,51]% C13
    [1,29]% C119
    [1,16,25,34,52,62]% C121
    [15,47,52,57,62]% C194
    [15,57,60,62]% C168
    [27,35,41,64]%C14
    [2,24]%C49
    [15,42,44,62]%C400
    [30,52,62]%C100
    [15,24,27,28,52,62,64]%C117
    [15,16,24,41,52]%C115
    [15,28,33,43,52,61]%C110
    [1,29,31,57] %C183
    [15,30,52,60] %C144
    [15,52,60] %C252
    [7,59,57,61]%C140
    [15,30,57,63]%C259
    [43] %'C143'
    [15] % 'C89'
    [34,52,62]%'C62'
    [15,16,34,52] %'C88'
    [15,27,45,52,64,57]%'C84'
    [8,15,61,62]}; %'C87'
end
%---------------------------------------------------------------------------------------------------
%% Add all Monash IDs here (Control and ADHD)
%excluding adhd 37 and 88 due to step 1 issue, c133 due to no eyetracking
original_paradigm = {'AD40C' 'AD11C' 'AD43C' 'AD18C' 'AD24C' 'AD35C' 'AD33C' 'AD34C' 'AD35C'...
                    'AD36C' 'AD81C' 'AD82C' 'AD83C' 'AD84C' 'AD85C' 'AD86C' ...
                    'C134' 'C135' 'C136' 'C137' 'C138' 'C139' 'C141' 'C500' 'C501' 'C502' ...
                    'C503' 'C504' 'C505' 'C506' 'C507' 'C508' 'C509' 'C510' 'C511' 'C512'};
% These guys did the paradigm that measured RT as the point at which both buttons became clicked
% regerdless of whether there may have been a few ms
% difference between when the first and second button made contact -in this case the new paradigm
% takes the mean time between when each botton made contact.

%---------------------------------------------------------------------------------------------------

single_participants = [];
exp_conditions = 'C'; c = 1;
file_start = 1;

if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    sessionID([duds]) = [];
    allBlocks([duds]) = [];
    allbadchans([duds]) = [];
end

if ~isempty(single_participants)
    subject_folder = subject_folder([single_participants]);
    sessionID = sessionID([single_participants]);
    allBlocks = allBlocks([single_participants]);
    allbadchans = allbadchans([single_participants]);
end

%edit to run certain participants without issues
for s = file_start:length(sessionID)
    
    if ~exist([pathOut, subject_folder{s}])
        mkdir([pathOut, subject_folder{s}])
    end
    disp(subject_folder{s})
    subjID = [datafolder,subject_folder{s}, '/', sessionID{s}, '_', exp_conditions ];
    blocks = allBlocks{s};
    badchans = allbadchans{s};
    if c==1
        Step3b_CPP_ET
    elseif c==2
        Dots_Discrete;
    end
end
