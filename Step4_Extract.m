clear all; close all; clc

%% Settings
%% NOTE : Channel orders are still different between datasets.
% --------------------------------------------------------------------------------------------------
% Path to code and data
% --------------------------------------------------------------------------------------------------
% cd('/Users/manab/GoogleDrive_Gmail/DecisionMaking/')
% addpath(genpath('/Users/manab/Desktop/Functions/eeglab2019_1/'));
% eeglab;
% % 
% % pathOut = '/Volumes/shared/R-MNHS-SPP/Bellgrove-data/Julia Paterson/Analyzed/';
% % path_ADHD = '/Volumes/shared/R-MNHS-SPP/Bellgrove-data/Julia Paterson/Analyzed/ADHD/';
% % path_Control =  '/Volumes/shared/R-MNHS-SPP/Bellgrove-data/Julia Paterson/Analyzed/Controls/';
% 
% pathOut = '/Users/manab/Desktop/ADHDKids/Julia/';
% path_ADHD = '/Users/manab/Desktop/ADHDKids/Julia/ADHD/';
% path_Control =  '/Users/manab/Desktop/ADHDKids/Julia/Controls/';

cd('/Users/juliapaterson/Documents/github/honours-2021/matlab/'); % path to your scripts folder
addpath(genpath('/Users/juliapaterson/Desktop/eeglab2021.0/'));
eeglab;

pathOut = '/Users/juliapaterson/Desktop/data/Analyzed/';
path_ADHD = '/Users/juliapaterson/Desktop/data/Analyzed/ADHD/';
path_Control =  '/Users/juliapaterson/Desktop/data/Analyzed/Controls/';

% All data folders including ADHD/control and Monash/UQ
subject_folder = {'AD33C'	'AD35C'	'AD82C'	'AD83C'	'AD85C'	'AD84C'	'AD86C'	'AD40C'	'AD11C'	'AD43C'...
    'AD18C'	'AD24C'	'AD52C'	'AD5C'	'AD54C'	'AD75C'	'AD15C'	'AD49C'	'AD69C'	'AD32C'	'AD16C'...
    'AD72C'	'AD59C'	'AD27C'	'AD46C'	'AD22C'	'AD26C'	'AD99C'	'AD48C'	'AD57C'	'AD51C'	'AD19C'...
    'AD98C'	'AD25C'	'AD23C'	'C134'	'C135'	'C136'	'C137'	'C138'	'C139'	'C500'	'C501'...
    'C502'	'C503'	'C505'	'C506'	'C507'	'C509'	'C511'	'001_KK'	'C12'	'C21'	'002_LK'...
    'C50'	'C131'	'C20'	'C132'	'C213'	'C204'	'C171'	'C13'	'C119'	'C121'	'C194'...
    'C168'	'C14'	'C49'	'C400'	'C100'	'C117'	'C115'	'C110'	'C183'	'C144'	'C252'...
    'C140'	'C259'	'C143'	'C89'	'C62'	'C88'	'C84'	'C87'};

% All subject IDs including ADHD/control and Monash/UQ
allsubj=   {'1_33'	'1_35'	'1_82'	'1_83'	'1_85'	'1_84'	'1_86'	'1_40'	'1_11'	'1_43'...
    '1_18'	'1_24'	'1_52'	'1_5'	'1_54'	'1_75'	'1_15'	'1_49'	'1_69'	'1_32'	'1_16'...
    '1_72'	'1_59'	'1_27'	'1_46'	'1_22'	'1_26'	'1_99'	'1_48'	'1_57'	'1_51'	'1_19'...
    '1_98'	'1_25'	'1_23'	'134'	'135'	'136'	'137'	'138'	'139'	'500'	'501'...
    '502'	'503'	'505'	'506'	'507'	'509'	'511'	'001'	'12'	'21'	'002'...
    '50'	'131'	'20'	'132'	'213'	'204'	'171'	'13'	'119'	'121'	'194'...
    '168'	'14'	'49'	'400'	'100'	'117'	'115'	'110'	'183'	'144'	'252'...
    '140'	'259'	'143'	'89'	'62'	'88'	'84'	'87'};

% duds = [12,16,17,24,26,... %ADHD: %'AD69C', 'AD59C', 'AD27C', 'AD51C', 'AD98C' % These are kicked out due to clinical cuttoff filter_CPRS_N_B
%     43,45,56];  %Controls: %C194 not enough trials %('C14' and 'C259' filter_CPRS_N_B);
duds = [];
single_participants = [];
file_start = 1;

% --------------------------------------------------------------------------------------------------
% All ADHD data folders for both Monash and UQ
subject_folder_ADHD = {'AD33C'	'AD35C'	'AD82C'	'AD83C'	'AD85C'	'AD84C'	'AD86C'	'AD40C'...
    'AD11C'	'AD43C'	'AD18C'	'AD24C'	'AD52C'	'AD5C'	'AD54C'	'AD75C'	'AD15C'	'AD49C'	'AD69C'...
    'AD32C'	'AD16C'	'AD72C'	'AD59C'	'AD27C'	'AD46C'	'AD22C'	'AD26C'	'AD99C'	'AD48C'	'AD57C'...
    'AD51C'	'AD19C'	'AD98C'	'AD25C'	'AD23C'};

% All ADHD subject Ids for both Monash and UQ
allsubj_ADHD = {'1_33'	'1_35'	'1_82'	'1_83'	'1_85'	'1_84'	'1_86'	'1_40'	'1_11'	'1_43'...
    '1_18'	'1_24'	'1_52'	'1_5'	'1_54'	'1_75'	'1_15'	'1_49'	'1_69'	'1_32'	'1_16'...
    '1_72'	'1_59'	'1_27'	'1_46'	'1_22'	'1_26'	'1_99'	'1_48'	'1_57'	'1_51'	'1_19'...
    '1_98'	'1_25'	'1_23'};

% --------------------------------------------------------------------------------------------------
% All Control data folders for both Monash and UQ
subject_folder_Control = {'C134'	'C135'	'C136'	'C137'	'C138'	'C139'	'C500'	'C501'...
    'C502'	'C503'	'C505'	'C506'	'C507'	'C509'	'C511'	'001_KK'	'C12'	'C21'	'002_LK'...
    'C50'	'C131'	'C20'	'C132'	'C213'	'C204'	'C171'	'C13'	'C119'	'C121'	'C194'...
    'C168'	'C14'	'C49'	'C400'	'C100'	'C117'	'C115'	'C110'	'C183'	'C144'	'C252'...
    'C140'	'C259'	'C143'	'C89'	'C62'	'C88'	'C84'	'C87'};

% All Control subject Ids for both Monash and UQ
allsubj_Control = {'134'	'135'	'136'	'137'	'138'	'139'	'500'	'501'	'502'	'503'...
    '505'	'506'	'507'	'509'	'511'	'001'	'12'	'21'	'002'	'50'	'131'	'20'...
    '132'	'213'	'204'	'171'	'13'	'119'	'121'	'194'	'168'	'14'	'49'	'400'...
    '100'	'117'	'115'	'110'	'183'	'144'	'252'	'140'	'259'	'143'	'89'	'62'...
    '88'	'84'	'87'};

% --------------------------------------------------------------------------------------------------
% All Monash IDs  (Control and ADHD)
monashIds = {'AD40C'	'AD11C'	'AD43C'	'AD18C'	'AD24C'	'AD35C'	'AD33C'	'AD34C'	'AD35C'...
    'AD82C'	'AD83C'	'AD84C'	'AD85C'	'AD86C'	'C133'	'C135'	'C136'	'C137'	'C138'	'C139'...
    'C500'	'C501'	'C502'	'C505'	'C503'	'C506'	'C507'	'C509'	'C511'};
%%

% duds = [12,16,17,24,26,... %ADHD: %'AD69C', 'AD59C', 'AD27C', 'AD51C', 'AD98C' % These are kicked out due to clinical cuttoff filter_CPRS_N_B
%     43,45,56];  %Controls: %C194 not enough trials %('C14' and 'C259' filter_CPRS_N_B);
duds = [];
single_participants = [];
file_start = 1;

if ~isempty(duds) && isempty(single_participants)
    subject_folder([duds]) = [];
    allsubj([duds]) = [];
end

if ~isempty(single_participants)
    subject_folder = subject_folder(single_participants);
    allsubj = allsubj(single_participants);
end

%% Data settings
% side,instance
targcodes = zeros(2,3);
targcodes(1,:) = [101 103 105]; % left patch,
targcodes(2,:) = [102 104 106]; % right patch


fs=500;
numch=64;
rtlim=[0.2 1.88]; %200ms too fast to be a real RT. 1880ms is longer than dot motion

[B,A]=butter(4,8*2/fs);

% ch_LR = [23;60];
% ch_N2c = [60;23]; % right hemi channels for left target, vice versa.
% ch_for_ipsicon(1,:) = [60;23];
% ch_for_ipsicon(2,:) = [23;60];
% ch_l = [23];
% ch_r = [60];
% % ch_front = 47; %47=FCz
% ch_front = 38; %38=Fz
% ch_CPP = [31];


ch_LR_name = {'P7','P8'};
ch_N2c_name = {'P8','P7'}; % right hemi channels for left target, vice versa.
ch_for_ipsicon_name(1,:) = {'P8','P7'};
ch_for_ipsicon_name(2,:) = {'P7','P8'};
ch_l_name = 'P7';
ch_r_name = 'P8';
% ch_front_name = 'FCz'; %47=FCz
ch_front_name = 'Fz'; %38=Fz
ch_CPP_name = 'Pz';


ts = -0.8*fs:1.880*fs;   % in sample points, the ERP epoch
t = ts*1000/fs;

ts_crop = -0.8*fs:1.880*fs;
t_crop = ts_crop*1000/fs;

trs = [-.800*fs:fs*.100];
tr = trs*1000/fs;

BLint = [-100 0];   % baseline interval in ms

HPF=0; %Use high-pass filtered erp? 1=yes, 0=no

mat_file=['_8_to_13Hz_neg800_to_1880_',num2str(numch),'ARchans_35HzLPF_point0HzHPF_ET.mat'];

%% Plotting colours lables etc
Patchside = {'Left Target ','Right Target '};
ADHD_Control = {'ADHD ','Control '};
colors = {'b' 'r' 'g' 'm' 'c'};
line_styles = {'-' '--'};
line_styles2 = {'--' '--' '-' '-'};
colors_coh = {'r' 'b'};
line_styles3 = {'-' '--' '-' '--'};
linewidths = [1.5 1.5 1.5 1.5 1.3 1.3 1.3 1.3];
linewidths2 = [1.5 1.5 1.3 1.3];
colors3 = {'b' 'b' 'r' 'r'};
[B,A]=butter(4,8*2/fs);
%% Run
% >>[ 3, 9, 40] Doublecheck: 5, 55
for s = 1:length(allsubj)
    
    erp=[];erp_HPF=[]; Alpha=[]; FixationBreak_PretargetToTarget_n=[]; FixationBreak_BLintTo100msPostResponse_n=[]; FixationBreak_BLintTo450ms_n=[]; Pupil_baselined=[];
    allRT=[]; allrespLR=[]; GAZE_X=[]; GAZE_Y=[];
    
    if ismember(subject_folder{s},subject_folder_ADHD)
        sGr = find(strcmp(subject_folder{s},subject_folder_ADHD));
        group=1;
        group_vector(s)=1;
        load([path_ADHD subject_folder{s} '/' subject_folder{s} mat_file])
    elseif ismember(subject_folder{s},subject_folder_Control)
        sGr = find(strcmp(subject_folder{s},subject_folder_Control));
        group=2;
        group_vector(s)=2;
        load([path_Control subject_folder{s} '/' subject_folder{s} mat_file])
    else
        keyboard
    end
    
    if ismember(subject_folder{s},monashIds)
        load('ADHD_chanlocs.mat')
    else
        load('UQ_ADHD_chanlocs.mat')
    end
    
    
    ch_LR(1,1) = find(strcmp(lower(ch_LR_name{1}), lower({chanlocs.labels})));
    ch_LR(2,1) = find(strcmp(lower(ch_LR_name{2}), lower({chanlocs.labels})));
    
    ch_N2c(1,1) = find(strcmp(lower(ch_N2c_name{1}), lower({chanlocs.labels})));
    ch_N2c(2,1) = find(strcmp(lower(ch_N2c_name{2}), lower({chanlocs.labels})));
    
    ch_for_ipsicon(1,1) = find(strcmp(lower(ch_for_ipsicon_name{1,1}), lower({chanlocs.labels})));
    ch_for_ipsicon(1,2) = find(strcmp(lower(ch_for_ipsicon_name{1,2}), lower({chanlocs.labels})));
    
    ch_for_ipsicon(2,1) = find(strcmp(lower(ch_for_ipsicon_name{2,1}), lower({chanlocs.labels})));
    ch_for_ipsicon(2,2) = find(strcmp(lower(ch_for_ipsicon_name{2,2}), lower({chanlocs.labels})));
    
    ch_l = find(strcmp(lower(ch_l_name), lower({chanlocs.labels})));
    ch_r = find(strcmp(lower(ch_r_name), lower({chanlocs.labels})));
    
    ch_front = find(strcmp(lower(ch_front_name), lower({chanlocs.labels})));
    
    ch_CPP = find(strcmp(lower(ch_CPP_name), lower({chanlocs.labels})));
    
    if length(allRT)<length(allrespLR)
        allRT(length(allRT)+1:length(allrespLR))=0; %DN: in case they missed the last RT add a zero on
    end
    
    erpr = zeros(size(erp,1),length(tr),size(erp,3));
    
%---------------------------------------------------------------------------------------------------
    % Find and index pre and post-target blinks and fixation breaks
%---------------------------------------------------------------------------------------------------
   
    % Screen parameters and viewing distance from Monitor at QBI
    dist = 57;  % viewing distance in cm is closer than using LCD (57)
    scres = [1024 768]; %screen resolution
    cm2px = scres(1)/39;% for Monitor at QBI
    deg2px = dist*cm2px*pi/180;
    %   par.patchloc = [-10 -4; 10 -4;]; % patch location coordinates [x y] in degrees relative to center of screen
    
    if length(GAZE_X(1,:))~=length(allRT)
        keyboard
    end
    
    %%% if fixation breaks 3deg or blink, mark trial
    for trial=1:length(GAZE_X(1,:))
        
        %         figure
        %         plot(GAZE_X(find(t_crop==-500):find(t_crop==0),trial),GAZE_Y(find(t_crop==-500):find(t_crop==0),trial))
        %         circle(512,384,(3*deg2px));
        %         set(gca,'xlim',[312,712],'ylim',[184,584])
        
        %               if any(sqrt(((GAZE_X(:,trial)-(scres(1)/2)).^2)+((GAZE_Y(:,trial)-(scres(2)/2)).^2))>(3*deg2px)) || any(GAZE_X(:,trial)==0)
        %Pre-target:
        if any(sqrt(((GAZE_X(find(t_crop==-500):find(t_crop==0),trial)-(scres(1)/2)).^2))>(3*deg2px))|| any(GAZE_X(find(t_crop==-500):find(t_crop==0),trial)==0) %DN: here we only care about blinks and fixation breaks along the x axis (line above does both x and y axis)
            FixationBreak_PretargetToTarget_n(trial) = 1;
        else
            FixationBreak_PretargetToTarget_n(trial) = 0;
        end
        %BLint to 100ms after RT:
        if allRT(trial)>0 && allRT(trial)*1000/fs <1900 %if there was an RT, search for fixation freak from BLint to 100ms after RT:
            if any(sqrt(((GAZE_X(find(t_crop==BLint(1)):find(t_crop==allRT(trial)*1000/fs + 100),trial)-(scres(1)/2)).^2))>(3*deg2px))|| any(GAZE_X(find(t_crop==BLint(1)):find(t_crop==allRT(trial)*1000/fs+ 100),trial)==0) %DN: here we only care about blinks and fixation breaks along the x axis (line above does both x and y axis)
                FixationBreak_BLintTo100msPostResponse_n(trial) = 1;
            else
                FixationBreak_BLintTo100msPostResponse_n(trial) = 0;
            end
            %else there was no RT so search from BLint until end of epoch:
        elseif any(sqrt(((GAZE_X(find(t_crop==BLint(1)):end,trial)-(scres(1)/2)).^2))>(3*deg2px))|| any(GAZE_X(find(t_crop==BLint(1)):end,trial)==0)
            FixationBreak_BLintTo100msPostResponse_n(trial) = 1;
        else
            FixationBreak_BLintTo100msPostResponse_n(trial) = 0;
        end
        %BLint to 450ms:
        if any(sqrt(((GAZE_X(find(t_crop==BLint(1)):find(t_crop==450),trial)-(scres(1)/2)).^2))>(3*deg2px))|| any(GAZE_X(find(t_crop==BLint(1)):find(t_crop==450),trial)==0) %DN: here we only care about blinks and fixation breaks along the x axis (line above does both x and y axis)
            FixationBreak_BLintTo450ms_n(trial) = 1;
        else
            FixationBreak_BLintTo450ms_n(trial) = 0;
        end
    end
    
%---------------------------------------------------------------------------------------------------
   
    if HPF
        erp=erp_HPF;
    end

      
    %Calculate mean pre-target pupil diameter for each trial. Just used to
    %kick out trials where pre-target pupil diameter is 0
    PrePupilDiameter=zeros(1,size(Pupil,2));
    for trial=1:size(Pupil,2)
        PrePupilDiameter(trial)=mean(Pupil(find(t_crop==-500):find(t_crop==0),trial));
    end
    
    
    erpr = zeros(size(erp,1),length(tr),size(erp,3));
    
    validrlock = zeros(1,length(allRT)); % length of RTs.
    for n=1:length(allRT);
        [blah,RTsamp] = min(abs(t*fs/1000-allRT(n))); % get the sample point of the RT.
        if RTsamp+trs(1) >0 & RTsamp+trs(end)<=length(t) & allRT(n)>0 % is the RT larger than 1st stim RT point, smaller than last RT point.
            erpr(:,:,n) = erp(:,RTsamp+trs,n);
            validrlock(n)=1;
        end
    end
    
    
    % patch,ITI
    clear conds1
    for patch = 1:2
        for i = 1:3
            % calcs the indices of the triggers for each
            % appropriate trial type.
            conds1{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & ...
                allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & validrlock & ~rejected_trial_n);
        end
    end
    
    conds_all = [conds1{:,:}];
    allRT_zscores = zeros(size(allRT));
    allRT_zscores(conds_all) = zscore(log(allRT(conds_all)*1000/fs));
    PrePupilDiameter_zscores = zeros(size(allRT));
    PrePupilDiameter_zscores(conds_all) = zscore(PrePupilDiameter(conds_all));
    
    %Baseling correct each single trial Pupil diameter
    for trial=1:size(Pupil,2)
        bl_diameter = mean(Pupil(find(t_crop==-500):find(t_crop==0),trial)); % baseline from -500ms before onset.
        Pupil_baselined(:,trial) = Pupil(:,trial) - repmat(bl_diameter,[size(Pupil,1),1]);
    end
    
    
    clear conds_erp conds_N2 conds_RT conds_Alpha_pre conds_Alpha_post conds_pupil_pre conds_pupil_post CPPs
    for patch = 1:2
        for i = 1:3
            conds_erp{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ...
                allRT_zscores>-3 & allRT_zscores<3 & ~artifact_BLintTo100msPostResponse_n &...
                ~FixationBreak_BLintTo100msPostResponse_n & ~rejected_trial_n);
            ERP_temp = squeeze(erp(1:numch,:,[conds_erp{patch,i}]));
            ERP_cond(s,:,:,patch,i,group) = squeeze(mean(ERP_temp,3));  %ERP_cond(Subject, channel, samples, patch, i, group)
            clear ERP_temp
            if isnan(ERP_cond(s,:,:,patch,i,group))
               keyboard
            end
            
            ERPr_temp = squeeze(erpr(1:numch,:,[conds_erp{patch,i}]));
            ERPr_cond(s,:,:,patch,i,group) = squeeze(mean(ERPr_temp,3));  %ERPr_cond(Subject, channel, samples, patch, i, group)
            clear ERPr_temp
            if isnan(ERPr_cond(s,:,:,patch,i,group))
                keyboard
            end
            
            conds_N2{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ...
                allRT_zscores>-3 & allRT_zscores<3 & ~artifact_BLintTo450ms_n & ~FixationBreak_BLintTo450ms_n & ~rejected_trial_n);
            N2_temp = squeeze(erp(1:numch,:,[conds_N2{patch,i}]));
            N2_cond(s,:,:,patch,i,group) = squeeze(mean(N2_temp,3));  %N2_cond(Subject, channel, samples, patch, i, group)
            clear N2_temp
            if isnan(N2_cond(s,:,:,patch,i,group))
                keyboard
            end
            
            conds_RT{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ...
                allRT_zscores>-3 & allRT_zscores<3);
            avRT{s,patch,i,group} = allRT(conds_RT{patch,i})*1000/fs;
            RT_Zs{s,patch,i,group} = allRT_zscores(conds_RT{patch,i});
            
            %## MB
            side_RT{patch,i} = find(allTrig==targcodes(patch,i));
            %##
            
            %Pre Alpha
            conds_Alpha_pre{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ... %make a different conds for Pupil kicking out pre-target pupil outliers
                ~artifact_PretargetToTarget_n & ~ FixationBreak_PretargetToTarget_n & ~rejected_trial_n);
            Alpha_temp = squeeze(Alpha(1:numch,:,[conds_Alpha_pre{patch,i}]));
            Alpha_cond_pre(s,:,:,patch,i,group) = squeeze(mean(Alpha_temp,3)); %Alpha_cond_pre (Subject, channel, samples, patch, i, group)
            clear Alpha_temp
            if isnan(Alpha_cond_pre(s,:,:,patch,i,group))
                keyboard
            end
            
            %Post Alpha  - kick out pre-target artifacts too because I need to baseline to the pre-target interval for post target alpha desync
            conds_Alpha_post{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ... %make a different conds
                ~artifact_BLintTo100msPostResponse_n & ~ FixationBreak_BLintTo100msPostResponse_n & ~ FixationBreak_PretargetToTarget_n & ~rejected_trial_n & allRT_zscores>-3 & allRT_zscores<3);
            Alpha_temp = squeeze(Alpha(1:numch,:,[conds_Alpha_post{patch,i}]));
            Alpha_cond_post(s,:,:,patch,i,group) = squeeze(mean(Alpha_temp,3)); %Alpha_cond (Subject, channel, samples, patch, i, group)
            clear Alpha_temp
            if isnan(Alpha_cond_post(s,:,:,patch,i,group))
                keyboard
            end
            
            %Pre target pupil
            conds_pupil_pre{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ... %make a different conds for Pupil kicking out pre-target pupil outliers
                PrePupilDiameter~=0 & ~FixationBreak_PretargetToTarget_n & ~rejected_trial_n);
            PUPIL_temp=squeeze(Pupil(:,[conds_pupil_pre{patch,i}]));
            Pupil_cond_pre(s,:,patch,i,group)=squeeze(mean(PUPIL_temp,2));
            clear PUPIL_temp
            if isnan(Pupil_cond_pre(s,:,patch,i,group))
                keyboard
            end
            
            %Post target pupil
            conds_pupil_post{patch,i} = find(allTrig==targcodes(patch,i) & allrespLR==1 & allRT>rtlim(1)*fs & allRT<rtlim(2)*fs & ... %make a different conds for Pupil kicking out pre-target pupil outliers
                allRT_zscores>-3 & allRT_zscores<3 & PrePupilDiameter~=0 & ~FixationBreak_BLintTo100msPostResponse_n...
                & abs(PrePupilDiameter_zscores)<3 & ~rejected_trial_n & allRT_zscores>-3 & allRT_zscores<3);
            PUPIL_temp=squeeze(Pupil_baselined(:,[conds_pupil_post{patch,i}]));
            Pupil_cond_post(s,:,patch,i,group)=squeeze(mean(PUPIL_temp,2));
            clear PUPIL_temp
            if isnan(Pupil_cond_post(s,:,patch,i,group))
                keyboard
            end
            
        end
        
%---------------------------------------------------------------------------------------------------
 % Code adapted from Ger's Current Biology cpp code to pull out CPP onset latency:
%---------------------------------------------------------------------------------------------------       
       
        % These 8 lines go at the top of the script.
        % Define CPP onset search window, from 0 to 1000ms
        CPP_search_t  = [0,1000];
        % Same window in samples
        CPP_search_ts  = [find(t==CPP_search_t(1)),find(t==CPP_search_t(2))];
        % Size of sliding window. This is in fact 1/4 of the search window in ms.
        % So 25 is 100ms. (25 samples x 2ms either side of a particular sample).
        max_search_window = 25;
        
        %DN: in Ger's N2/CPP paper this is set to 10, but our dots
        %coherence is lower, so setting it to 25 to ensure cpp onset
        %actually started and it's not just noise
        consecutive_windows=25;%Number of consecutive windows that p must be less than .05 for in order to call it a CPP onset
        
        
        CPP_temp = squeeze(mean(erp(ch_CPP,:,[conds_erp{patch,:}]),1)); % time x trial
        CPPs(:,patch) = squeeze(mean(CPP_temp(:,:),2)); % average across trial for plot later on, not used to find onsets.
        % constrain the search window according to parameters above.
        CPP_temp = squeeze(CPP_temp(find(t>=CPP_search_t(1) & t<=CPP_search_t(2)),:));
        prestim_temp = find(t<CPP_search_t(1)); % so we can add it on after getting max peak.
        
        % we want sliding windows for each trial, create smoothed waveform.
        clear win_mean win_mean_inds tstats ps
        for trial = 1:size(CPP_temp,2)
            counter = 1;
            for j = max_search_window:2:size(CPP_temp,1)-max_search_window
                win_mean(counter,trial) = mean(CPP_temp([j-max_search_window+1:j+max_search_window-1],trial));
                win_mean_inds(counter) = j;
                counter = counter+1;
            end
        end
        
        % do t-test to zero across the smoothed trials.
        for tt = 1:size(win_mean,1)
            
            if strcmp( subject_folder(s),'AD48C') %This participant has strainge CPP baseline, so do CPP onset t-test against -1.5 instead of against 0
                [~,P,~,STATS] = ttest(win_mean(tt,:),-1.5);
            else
                [~,P,~,STATS] = ttest(win_mean(tt,:));
            end
            tstats(tt) = STATS.tstat;
            ps(tt) = P;
        end
        
        % when does the ttest cross 0.05? If at all?
        %         onsetp05 = find(ps<0.05 & tstats>0,1,'first');
        
        %DN: added this in to explicitly make sure the "consecutive_windows" number of following p-values from onset are also lower than 0.05.
        clear allp05
        allp05= find(ps<0.05 & tstats>0);
        onsetp05=[];
        for i = 1:length(allp05)
            if  (i+consecutive_windows-1)<=length(allp05)
                if allp05(i+consecutive_windows-1)-allp05(i)==consecutive_windows-1 %if there is at least 10 consecutive windows where p<.05
                    onsetp05=allp05(i);
                    break
                end
            else
                onsetp05=allp05(i);
                break
            end
        end
        
        
        % get timepoint of min index.
        if ~isempty(onsetp05)
            onset_ind = win_mean_inds(onsetp05);
            CPP_onset_ind = onset_ind + length(prestim_temp); % see above, this needs to be added to get the overall time with respect to t.
            CPP_patch_onsets(s,patch) = t(CPP_onset_ind);
        else % onsetp05 is empty, no significant CPP.
            disp([allsubj{s},': bugger']) %AD48C has no CPP onset
            CPP_patch_onsets(s,patch) = 0;
        end
        
        % % %     plot the smoothed waveforms, the corresponding t-tests and p-values.
        % % %     Make sure the 10 (DN:30) following p-values from onset are also lower than
        % % %     0.05.
        %
        %         if patch==1
        %             figure
        %             subplot(3,2,1)
        %             plot(win_mean_inds,mean(win_mean,2))
        %             title(subject_folder{s})
        %             subplot(3,2,3)
        %             plot(win_mean_inds,tstats)
        %             subplot(3,2,5)
        %             plot(win_mean_inds,ps), hold on
        %             line(xlim,[0.05,0.05],'Color','k','LineWidth',1);
        %             if ~isempty(onsetp05)
        %                 line([onset_ind,onset_ind],ylim,'Color','g','LineWidth',1);
        %             else
        %                 line([0,0],ylim,'Color','r','LineWidth',1);
        %             end
        %         else
        %             subplot(3,2,2)
        %             plot(win_mean_inds,mean(win_mean,2))
        %             title(subject_folder{s})
        %             subplot(3,2,4)
        %             plot(win_mean_inds,tstats)
        %             subplot(3,2,6)
        %             plot(win_mean_inds,ps), hold on
        %             line(xlim,[0.05,0.05],'Color','k','LineWidth',1);
        %             if ~isempty(onsetp05)
        %                 line([onset_ind,onset_ind],ylim,'Color','g','LineWidth',1);
        %             else
        %                 line([0,0],ylim,'Color','r','LineWidth',1);
        %             end
        %         end
        
    end
    
%     %     plot CPP with onset marked
%         figure
%         for patch = 1:2
%             plot(t,squeeze(CPPs(:,patch)),'Color',colors{patch},'LineWidth',2), hold on
%             line([mean(CPP_patch_onsets(s,patch),1),mean(CPP_patch_onsets(s,patch),1)],ylim,'Color',colors{patch},'LineWidth',1.5);
%             line([0,0],ylim,'Color','k','LineWidth',1);
%             line(xlim,[0,0],'Color','k','LineWidth',1);
%         end
%         title(subject_folder{s})
    
%---------------------------------------------------------------------------------------------------
 % Outputs
%---------------------------------------------------------------------------------------------------     
    
    disp(['Subject ',subject_folder{s},' Total Valid Pre Alpha: ',num2str(length([conds_Alpha_pre{:,:}]))])
    disp(['Subject ',subject_folder{s},' Total Valid N2 Trials: ',num2str(length([conds_N2{:,:}]))])
    disp(['Subject ',subject_folder{s},' Total Valid CPP Trials: ',num2str(length([conds_erp{:,:}]))])
    disp(['Subject ',subject_folder{s},' Total Valid RT Trials: ',num2str(length([conds_RT{:,:}]))])
    
    %## MB
    misses(s) = length(allRT)-length([conds_RT{:,:}]);
    allTrueResponseLeft = length([avRT{s,1,:,group}]);
    allTrueResponseRight = length([avRT{s,2,:,group}]);
    allTrigLeft = length(side_RT{1,1})+length(side_RT{1,2})+length(side_RT{1,3});% {Patch(Left/Right), trigger(1:3 each side)}
    allTrigRight = length(side_RT{2,1})+length(side_RT{2,2})+length(side_RT{2,3});
    misses_Left(s)  = allTrigLeft-allTrueResponseLeft;
    misses_Right(s)  = allTrigRight-allTrueResponseRight;
    %##
    
    RT_index(s)  = (mean([avRT{s,1,:,group}])-mean([avRT{s,2,:,group}]))/ ((mean([avRT{s,1,:,group}])+mean([avRT{s,2,:,group}]))/2)';
    RT(s) = mean([avRT{s,:,:,group}])';
    RT_Left(s) =mean([avRT{s,1,:,group}])';
    RT_Right(s) =mean([avRT{s,2,:,group}])';
    
    RT_Assymetry(s)  = (RT_Left(s) - RT_Right(s) )/(RT_Left(s) + RT_Right(s) );
    
    ValidPreAlphaTrials(s)=length([conds_Alpha_pre{:,:}])';
    ValidN2Trials(s)=length([conds_N2{:,:}])';
    ValidCPPTrials(s)=length([conds_erp{:,:}])';
    Valid_RT_Trials(s)=length([conds_RT{:,:}])';
    
end

save([pathOut,'DM_beh.mat']);