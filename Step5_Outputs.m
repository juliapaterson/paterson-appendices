%diary step5log

clear all; close all; clc

%% NOTE : Channel orders are still different between datasets.
% --------------------------------------------------------------------------------------------------
% Path to code and data
% --------------------------------------------------------------------------------------------------
cd('/Users/juliapaterson/Documents/github/honours-2021/matlab/'); % path to your scripts folder
addpath(genpath('/Users/juliapaterson/Desktop/eeglab2021.0/'));
%addpath(genpath('/Users/juliapaterson/Desktop/eeglab2019_1/'));
eeglab;

pathOut = '/Users/juliapaterson/Desktop/data/Analyzed/';

load([pathOut,'DM_beh.mat']);
%% find the best ALPHA LH and RH ROI electrodes for each participant
for s=file_start:length(allsubj)
    if ismember(subject_folder{s},subject_folder_ADHD)
        group=1;
    elseif ismember(subject_folder{s},subject_folder_Control)
        group=2;
    end
    for elec=1:numch  %Alpha_cond (Subject, channel, samples, patch, i, group)
        left_minus_right_per_subject(s,elec) = squeeze(mean(mean(Alpha_cond_post(s,elec,find(Alpha_smooth_time==300):find(Alpha_smooth_time==1000),1,:,group),5),3))-...
            squeeze(mean(mean(Alpha_cond_post(s,elec,find(Alpha_smooth_time==300):find(Alpha_smooth_time==1000),2,:,group),5),3));
    end
    
    %# MB Added
    LH_elec_name = {'P1';'P3';'P5';'P7';'PO7';'PO3';'O1'};
    RH_elec_name = {'P2';'P4';'P6';'P8';'PO8';'PO4';'O2'};
    
    for el = 1:length(LH_elec_name)
        LH_elec(el) = find(strcmp({chanlocs.labels},LH_elec_name{el}));
    end
    
    for el = 1:length(RH_elec_name)
        RH_elec(el) = find(strcmp({chanlocs.labels},RH_elec_name{el}));
    end
    
    %# MB Commented
    %     LH_elec=[20:23 25:27];
    %     RH_elec=[57:60 62:64];
    
    %For each participant this specify the 4 occipito-pariatal electrodes for each hemisphere that show the greatest desyncronisation difference between cont/ipsilateral targets
    LH_desync(s,:)= left_minus_right_per_subject(s,LH_elec);
    [temp1,temp2] = sort(LH_desync(s,:));
    LH_ROI(s,:)= LH_elec(temp2(5:7)); %DN: pick the 3 Left Hemisphere parieto-occipito that show the highest left_minus_right values (5:7)
    LH_ROI_s =  LH_ROI(s,:);
    
    RH_desync(s,:)= left_minus_right_per_subject(s,RH_elec);
    [temp1,temp2] = sort(RH_desync(s,:));
    RH_ROI(s,:)= RH_elec(temp2(1:3)); %DN: pick the 3 Right Hemisphere parieto-occipito that show the lowest left_minus_right values (1:3)
    RH_ROI_s =  RH_ROI(s,:);
    
    group_path={'ADHD','Controls'};
    save([pathOut, group_path{group}, filesep, subject_folder{s} filesep 'ROIs.mat'],'LH_ROI_s','RH_ROI_s')
end
 
%% DN: combine LH_ROI = and RH_ROI electrodes together in ROIs_LH_RH, and ROIs_RH_LH for an ipsicon type thing
ROIs_LH_RH=zeros(length(allsubj),length(LH_ROI(1,:)),2);
ROIs_LH_RH(:,:,1)=LH_ROI;
ROIs_LH_RH(:,:,2)=RH_ROI;
ROIs_RH_LH=zeros(length(allsubj),length(LH_ROI(1,:)),2);
ROIs_RH_LH(:,:,2)=LH_ROI;
ROIs_RH_LH(:,:,1)=RH_ROI;
%%

IDs=subject_folder';% open IDs

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

%% N2 scalp plot 
close all;
figure
counter=0;
scalp_plot_times=[220, 340]; %in ms
for group=1:2
    for targetside=1:2
        counter=counter+1; %N2_cond(Subject, channel, samples, patch, i,group)
        temp=squeeze(mean(mean(mean(N2_cond(N2_cond(:,1,1,1,1,group)~=0,:,:,targetside,:,group),5),1),6));
        subplot(2,2,counter)
%         topoplot(mean(temp(:,find(t_crop==scalp_plot_times(1)):find(t_crop==scalp_plot_times(2))),2),chanlocs,'maplimits', ...
%              [-1  2],'electrodes','numbers','plotchans',1:length(chanlocs)); %colorbar
        topoplot(mean(temp(:,find(t_crop==scalp_plot_times(1)):find(t_crop==scalp_plot_times(2))),2),chanlocs, ...
           'maplimits', [-1  1], 'electrodes','on','plotchans',1:length(chanlocs)); %colorbar
         set(gca,'FontSize',16);
        title([ADHD_Control{group} Patchside{targetside} num2str(scalp_plot_times(1)) '-' num2str(scalp_plot_times(2)) 'ms']);
        colorbar;
    end
end

%% Plot N2c and N2i by TargetSide:
% clear ch_for_ipsicon
% ch_for_ipsicon(1,1,:)=[60,59,62]; %Left Target Contra
% ch_for_ipsicon(1,2,:)=[23,22,25]; %Left Target Ipsi
% ch_for_ipsicon(2,1,:)=ch_for_ipsicon(1,2,:);
% ch_for_ipsicon(2,2,:)=ch_for_ipsicon(1,1,:);
% ch_for_ipsicon(1,:) = [60;23];
% ch_for_ipsicon(2,:) = [23;60];

patch_ipsi_contra = {'N2c Left target','N2i Left Target','N2c Right Target','N2i Right Target'};
close all;
figure('color','w')
% xy_axes = axes('Parent',figure,'FontName','Arial','FontSize',20);
ss= 0;
for group=1:2
	counter = 1;
	for side=1:2

        subplot(1,2,group)

	for channels = 1:2 %N2_cond(Subject, channel, samples, patch, i,group)
	avERP_temp = squeeze(mean(mean(mean(N2_cond(N2_cond(:,1,1,1,1,group)~=0,:,find(t==-100):find(t==400),side,:,group),5),1),6));%(channel, samples)
	avERP_plot = squeeze(mean(avERP_temp(ch_for_ipsicon(side,channels,:),:),1));
	h(counter) = plot(t(find(t==-100):find(t==400)),avERP_plot,'Color',colors3{counter},'LineStyle',line_styles3{counter}, ...
	'Linewidth',4); hold on;
	set(gca, 'XLim', [-100 400],'YLim', [-2 2])
	line(xlim,[0,0],'Color','k');
	line([0,0],ylim,'Color','k');
	counter = counter+1;
    end
    end
	set(gca,'FontSize',20,'xlim',[-100,400],'xtick',[-100,0:100:400],'ylim',[-2,2],'ytick',[-2:1:2]);
	ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',20)
	xlabel('Time (ms)','FontName','Arial','FontSize',20)
	legend(h,patch_ipsi_contra,'Location','NorthWest');
	clear h;
	title([ADHD_Control{group}])
end

%% Extract N2c and N2i amplitude and latency, using amplitude latency window based on each INDIVIDNAL PARTICIPANT'S N2c/i:

window=25; %this is the time (in samples) each side of the peak latency (so it's 50ms each side of peak latency - so a 100ms window) 
group_path={'ADHD','Controls'};

%N2 amplitude for Stats
%N2_cond(Subject, channel, samples, patch, i, group)

for s = 1:size(allsubj,2)
    if ismember(subject_folder{s},subject_folder_ADHD)
        group=1;
    elseif ismember(subject_folder{s},subject_folder_Control)
        group=2;
    end
    for TargetSide=1:2 
%         to use each participant's average N2c/i to get their peak latency index around which we measure peak amplitude:
        avN2c=squeeze(mean(mean(mean(mean(mean(N2_cond(s, ch_N2c(TargetSide,:),:,TargetSide,:,group),5),4),2),1),6)); %(sample)
        avN2i=squeeze(mean(mean(mean(mean(mean(N2_cond(s, ch_LR(TargetSide,:),:,TargetSide,:,group),5),4),2),1),6)); 
        avN2c_peak_amp=min(avN2c(find(t==150):find(t==400)));
        avN2i_peak_amp=min(avN2i(find(t==150):find(t==400)));
        avN2c_peak_amp_index(s,TargetSide)=find(avN2c==avN2c_peak_amp);%Find Left target max peak latency for N2c
        avN2i_peak_amp_index(s,TargetSide)=find(avN2i==avN2i_peak_amp);%Find Left target max peak latency for N2i
        avN2c_peak_amp_index_t(s,TargetSide)=t_crop(avN2c_peak_amp_index(s,TargetSide));
        avN2i_peak_amp_index_t(s,TargetSide)=t_crop(avN2i_peak_amp_index(s,TargetSide));
        max_peak_N2c(s,TargetSide)=squeeze(mean(mean(mean(N2_cond(s,ch_N2c(TargetSide,:),avN2c_peak_amp_index(s)-window:avN2c_peak_amp_index(s)+window, TargetSide,:,group),2),3),5));
        max_peak_N2i(s,TargetSide)=squeeze(mean(mean(mean(N2_cond(s,ch_LR(TargetSide,:),avN2i_peak_amp_index(s)-window:avN2i_peak_amp_index(s)+window, TargetSide,:,group),2),3),5));
    end    
        avN2c_ParticipantLevel_peak_amp_index_s=avN2c_peak_amp_index(s,:);
        save([pathOut, group_path{group},filesep,subject_folder{s}, filesep, 'avN2c_ParticipantLevel_peak_amp_index.mat'],'avN2c_ParticipantLevel_peak_amp_index_s');        
        avN2i_ParticipantLevel_peak_amp_index_s=avN2i_peak_amp_index(s,:);
        save([pathOut, group_path{group}, filesep,subject_folder{s} , filesep,'avN2i_ParticipantLevel_peak_amp_index.mat'],'avN2i_ParticipantLevel_peak_amp_index_s');
end
N2cN2i_amp_ByTargetSide_ParticipantLevel = [max_peak_N2c,max_peak_N2i]; %(LeftTargetN2c, RightTargetN2c, LeftTargetN2i, RightTargetN2i)

%%N2c Latency:
N2cN2i_latency_ByTargetSide = [avN2c_peak_amp_index_t,avN2i_peak_amp_index_t]; %(LeftTargetN2c_latency, RightTargetN2c_latency, LeftTargetN2i_latency, RightTargetN2i_latency)

%% Plot stim-locked CPP by TargetSide:
labels = {'ADHD Left target','ADHD Right Target','Control Left Target','Control Right Target'};
colors4 = {'b' 'r' 'b' 'r'};
figure
counter=0;
for group=1:2
    for targetside=1:2
        counter=counter+1;
        avERP_temp = squeeze(nanmean(nanmean(nanmean(ERP_cond(N2_cond(:,1,1,1,1,group)~=0,:,find(t==-100):find(t==1000),targetside,:,group),5),1),6));%(channel, samples)
        avERP_plot = squeeze(mean(avERP_temp(ch_CPP,:),1));
        h(counter) = plot(t(find(t==-100):find(t==1000)),avERP_plot,'Color',colors4{counter},'LineStyle',line_styles2{counter},'Linewidth',2); hold on;
        set(gca, 'XLim', [-100 1000],'YLim', [-1 10])
        line(xlim,[0,0],'Color','k');
        line([0,0],ylim,'Color','k');
    end
end
set(gca,'FontSize',20,'xlim',[-100,1000],'xtick',[-100,0:100:1000],'ylim',[-1,10],'ytick',[-3:1:2]);
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',20)
xlabel('Time (ms)','FontName','Arial','FontSize',20)
legend(h,labels,'Location','NorthWest');
clear h;
title('CPP by TargetSide')


%% Plot Resp-locked CPP by TargetSide:
close all;
labels = {'ADHD Left target','ADHD Right Target','Control Left Target','Control Right Target'};
colors4 = {'b' 'r' 'b' 'r'};
figure
counter=0;
for group=1:2
    for targetside=1:2
        counter=counter+1;
            avERPr_temp = squeeze(nanmean(nanmean(nanmean(ERPr_cond(ERPr_cond(:,1,1,1,1,group)~=0,:,:,targetside,:,group),5),1),6));%(channel, samples)
        avERPr_plot = squeeze(mean(avERPr_temp(ch_CPP,:),1));
        h(counter) = plot(tr(find(tr==-800):find(tr==100)),avERPr_plot,'Color',colors4{counter},'LineStyle',line_styles2{counter},'Linewidth',2); hold on;
        set(gca, 'XLim', [-800 100],'YLim', [-1 13])
        line(xlim,[0,0],'Color','k');
        line([0,0],ylim,'Color','k');
    end
end
ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',20)
xlabel('Time (ms)','FontName','Arial','FontSize',20)
legend(h,labels,'Location','NorthWest');
clear h;
title('Response Locked CPP by TargetSide')

%% Extract Response Locked CPP slope" 
    %CPP build-up defined as the slope of a straight line fitted to the response-locked waveform at -400 to -50ms
slope_timeframe = [-400,-50];
for s=file_start:length(allsubj)
    if ismember(subject_folder{s},subject_folder_ADHD)
        group=1;
    elseif ismember(subject_folder{s},subject_folder_Control)
        group=2;
    end
    for targetside=1:2
        avERPr_temp = squeeze(nanmean(nanmean(ERPr_cond(s,:,:,targetside,:,group),5),6));%(channel, samples)
        avERPr_plot = squeeze(mean(avERPr_temp(ch_CPP,:),1));
        coef = polyfit(tr(tr>slope_timeframe(1) & tr<slope_timeframe(2)),(avERPr_plot(tr>slope_timeframe(1) & tr<slope_timeframe(2))),1);% coef gives 2 coefficients fitting r = slope * x + intercept
        CPP_slope(s,targetside)=coef(1);
    end
end

%% Plot post target Alpha by Hemisphere and TargetSide:
    %# MB Added
   left_hemi_ROI_name = {'PO7';'PO3';'O1'};
   right_hemi_ROI_name = {'PO8';'PO4';'O2'};

    for el = 1:length(left_hemi_ROI_name)
    left_hemi_ROI(el) = find(strcmp({chanlocs.labels},left_hemi_ROI_name{el}));
    end
    
     for el = 1:length(right_hemi_ROI_name)
    right_hemi_ROI(el) = find(strcmp({chanlocs.labels},right_hemi_ROI_name{el}));
     end
% 
% left_hemi_ROI = [25,26,27];
% right_hemi_ROI = [62,63,64];

alpha_ch=[left_hemi_ROI;right_hemi_ROI];

patch_ipsi_contra = {'Post-Target Alpha Left target Ipsi','Post-Target Alpha Left Target Contra','Post-Target Alpha Right Target Contra','Post-Target Alpha Right Target Ipsi'};
line_styles4={ '--' '-'  '-'    '--'};
figure
% xy_axes = axes('Parent',figure,'FontName','Arial','FontSize',20);
for group=1:2
    subplot(1,2,group)
    counter = 1;
    for TargetSide=1:2
        for Hemi = 1:2 
            avAlpha_temp = squeeze(nanmean(nanmean(nanmean(Alpha_cond_post(Alpha_cond_post(:,1,1,1,1,group)~=0,:,find(Alpha_smooth_time==-500):find(Alpha_smooth_time==1500),TargetSide,:,group),5),1),6));%(channel, samples)
            avAlpha_plot = squeeze(nanmean(avAlpha_temp(alpha_ch(Hemi,:),:),1)); %DN: smooth
            
            BLamp=nanmean(avAlpha_plot(1:10));%grabs nanmean alpha from -500 to 0
            avAlpha_plot=avAlpha_plot-repmat(BLamp,1,length(avAlpha_plot));
            
            h(counter) = plot(Alpha_smooth_time(find(Alpha_smooth_time==-500):find(Alpha_smooth_time==1500)),avAlpha_plot,'Color',colors3{counter},'LineStyle',line_styles4{counter}, ...
                'Linewidth',4); hold on;
            set(gca, 'XLim', [-500 1500],'YLim', [-1 1])
            line(xlim,[0,0],'Color','k');
            line([0,0],ylim,'Color','k');
            counter = counter+1;
        end
    end
    set(gca,'FontSize',16,'xlim',[-500,1500],'xtick',[-500,0:200:1500],'ylim',[-1,1],'ytick',[-1:1:2]);
    ylabel('Amplitude (\muVolts)','FontName','Arial','FontSize',16)
    xlabel('Time (ms)','FontName','Arial','FontSize',16)
    legend(h,patch_ipsi_contra,'Location','NorthWest');
    clear h;
    title([ADHD_Control{group}])
end

%% Extract mean Contra and Ipsi Post-target Alpha Dysnc from 300-1000ms (baselined from -500-0ms):

for s=1:length(allsubj)
    if ismember(subject_folder{s},subject_folder_ADHD)
        group=1;
    elseif ismember(subject_folder{s},subject_folder_Control)
        group=2;
    end
    for TargetSide=1:2
        for Hemi = 1:2   %Alpha_cond (Subject, channel, samples, patch, i, group)
            clear avAlpha
            BLamp(s,TargetSide,Hemi) = squeeze(mean(mean(mean(mean(mean(Alpha_cond_post(s,ROIs_LH_RH(s,:,Hemi),find(Alpha_smooth_time==-500):find(Alpha_smooth_time==0),TargetSide,:,group),1),2),3),5),6));% %grabs mean alpha from -500 to 0 from individulised ROIs
            avAlpha_post(s,TargetSide,Hemi) = squeeze(mean(mean(mean(mean(mean(Alpha_cond_post(s,ROIs_LH_RH(s,:,Hemi),find(Alpha_smooth_time==300):find(Alpha_smooth_time==1000),TargetSide,:,group),1),2),3),5),6));%(samples) %DN: use individulised ROIs
            avAlpha_post_desync(s,TargetSide,Hemi) = avAlpha_post(s,TargetSide,Hemi)- BLamp(s,TargetSide,Hemi); 
        end
    end
end


%% Plot Alpha asymmetry by Group and TargetSide:
%# MB Added
left_hemi_ROI_name = {'PO7';'PO3';'O1'};
right_hemi_ROI_name = {'PO8';'PO4';'O2'};

for el = 1:length(left_hemi_ROI_name)
    left_hemi_ROI(el) = find(strcmp({chanlocs.labels},left_hemi_ROI_name{el}));
end

for el = 1:length(right_hemi_ROI_name)
    right_hemi_ROI(el) = find(strcmp({chanlocs.labels},right_hemi_ROI_name{el}));
end

alpha_ch=[left_hemi_ROI;right_hemi_ROI];

patch_ipsi_contra = {'ADHD Left target','ADHD Right Target','Control Left Target','Control Right Target'};
line_styles4={ '--' '-'  '--' '-'};

% xy_axes = axes('Parent',figure,'FontName','Arial','FontSize',20);
figure
counter = 1;
for group=1:2
    for TargetSide=1:2
        
        avAlpha_temp = squeeze(nanmean(nanmean(nanmean(Alpha_cond_post(N2_cond(:,1,1,1,1,group)~=0,:,find(Alpha_smooth_time==-500):find(Alpha_smooth_time==1500),TargetSide,:,group),5),1),6));%(channel, samples)
        avAlpha_plot = squeeze(nanmean(avAlpha_temp(alpha_ch(2,:),:),1)) -squeeze(nanmean(avAlpha_temp(alpha_ch(1,:),:),1)); %DN: Right Hemi - Left Hemi
        
        h(counter) = plot(Alpha_smooth_time(find(Alpha_smooth_time==-500):find(Alpha_smooth_time==1500)),avAlpha_plot,'Color',colors3{counter},'LineStyle',line_styles4{counter}, ...
            'Linewidth',4); hold on;
        set(gca, 'XLim', [-500 1500],'YLim', [-1 1])
        line(xlim,[0,0],'Color','k');
        line([0,0],ylim,'Color','k');
        counter = counter+1;
    end
end
set(gca,'FontSize',14,'xlim',[-500,1500],'xtick',[-500:100:1500],'ylim',[-1,1],'ytick',[-1:.2:1]);
ylabel('Hemispheric Alpha Asymmetry ( \muVolts)','FontName','Arial','FontSize',14)
xlabel('Time (ms)','FontName','Arial','FontSize',14)
legend(h,patch_ipsi_contra,'Location','NorthWest');
clear h;
title(['Hemispheric Alpha Asymmetry'])

%% Overall Post target alpha scalp plot 
close all;
figure;
counter=0;
scalp_plot_times=[400, 850]; %in ms
for group=1:2
    for targetside=1:2
        counter=counter+1; %Alpha_cond (Subject, channel, samples, patch, i)
            temp=squeeze(nanmean(nanmean(nanmean(Alpha_cond_post(Alpha_cond_post(:,1,1,1,1,group)~=0,:,:,TargetSide,:,group),5),1),6));%(channel, samples)
            for i=1:numch
                BLamp=nanmean(temp(i,find(Alpha_smooth_time==-350):find(Alpha_smooth_time==0)));%grabs nanmean alpha from -100 to 0 for each channel 
                temp(i,:)=temp(i,:)-repmat(BLamp,1,length(temp(i,:)));
            end
        subplot(2,2,counter)
        topoplot(nanmean(temp(:,find(Alpha_smooth_time==scalp_plot_times(1)):find(Alpha_smooth_time==scalp_plot_times(2))),2),chanlocs,'maplimits', ...
            [-0.5  0.5],'electrodes','on','plotchans',1:numch); %colorbar

        title(['Alpha Desync. ' ADHD_Control{group} Patchside{targetside} num2str(scalp_plot_times(1)) '-' num2str(scalp_plot_times(2)) 'ms']);
        colorbar;
    end
end

%% Left minus Right Target alpha Desync scalp plot 
close all;
figure
counter=0;
scalp_plot_times=[300, 1500]; %in ms
for group=1:2
        counter=counter+1; %Alpha_cond (Subject, channel, samples, patch, i, group)
            temp=squeeze(nanmean(nanmean(nanmean(nanmean(Alpha_cond_post(Alpha_cond_post(:,1,1,1,1,group)~=0,:,:,2,:,group),5),1),6),4))...
                - squeeze(nanmean(nanmean(nanmean(nanmean(Alpha_cond_post(Alpha_cond_post(:,1,1,1,1,group)~=0,:,:,1,:,group),5),1),6),4));

        subplot(2,1,counter)
        topoplot(nanmean(temp(:,find(Alpha_smooth_time==scalp_plot_times(1)):find(Alpha_smooth_time==scalp_plot_times(2))),2),chanlocs,'maplimits', ...
            [-0.5  0.5],'electrodes','on','plotchans',1:numch); %colorbar
        title(['Alpha Left minus Right Target ' ADHD_Control{group} num2str(scalp_plot_times(1)) '-' num2str(scalp_plot_times(2)) 'ms']);
        colorbar;
end


%% Try alpha Left minus Right Target alpha Topoplot
%Alpha_cond (Subject, channel, samples, patch, i, group)
Group_tag = {'ADHD','Controls'};
for group=1:2
  Alpha_Group(:,:,group)=squeeze(mean(mean(mean(mean(Alpha_cond_post(Alpha_cond_post(:,1,1,1,1,group)~=0,:,:,[1],:,group),6),5),4),1))-...
  squeeze(mean(mean(mean(mean(Alpha_cond_post(Alpha_cond_post(:,1,1,1,1,group)~=0,:,:,[2],:,group),6),5),4),1)); %Alpha_Group(channel, samples, group)
end
figure
plottopo(Alpha_Group(:,:,:),'chanlocs',chanlocs,'limits',[Alpha_smooth_time(1) Alpha_smooth_time(end) min(min(min(Alpha_Group(:,:,:))))  max(max(max(Alpha_Group(:,:,:))))], ...
    'title',['Alpha LEFT MINUS RIGHT TARGET by Group'],'legend',Group_tag,'showleg','on','ydir',1,'chans',1:64);

%% Extract Pre-target Alpha per participant 
 %Alpha_cond_pre (Subject, channel, samples, patch, i, group)
 for s=1:length(allsubj)
     if ismember(subject_folder{s},subject_folder_ADHD)
         group=1;
     elseif ismember(subject_folder{s},subject_folder_Control)
         group=2;
     end
     for hemi=1:2
         PreAlpha_mean(s,hemi)=squeeze(mean(mean(mean(mean(Alpha_cond_pre(s,ROIs_LH_RH(s,:,hemi),find(Alpha_smooth_time==-500):find(Alpha_smooth_time==0),:,:,group),3),5),4),2));
     end
 end
% open PreAlpha_mean

%% Plot Resp-locked Frontal Negativity by TargetSide:
labels = {'ADHD Left target','ADHD Right Target','Control Left Target','Control Right Target'};
colors4 = {'b' 'r' 'b' 'r'};
figure
counter=0;
for group=1:2
    for targetside=1:2
        counter=counter+1;
            avERPr_temp = squeeze(nanmean(nanmean(nanmean(ERPr_cond(ERPr_cond(:,1,1,1,1,group)~=0,:,:,targetside,:,group),5),1),6));%(channel, samples)
        avERPr_plot = squeeze(nanmean(avERPr_temp(ch_front,:),1));
        h(counter) = plot(tr(find(tr==-800):find(tr==100)),avERPr_plot,'Color',colors4{counter},'LineStyle',line_styles2{counter},'Linewidth',2); hold on;
        set(gca, 'XLim', [-800 100],'YLim', [-11 1])
        line(xlim,[0,0],'Color','k');
        line([0,0],ylim,'Color','k');
    end
end
legend(h,labels,'Location','SouthWest');
clear h;
title('Response Locked Frontal Negativity by TargetSide')

%% Extract Response Locked Frontal Negitivity slope" 
    %CPP build-up defined as the slope of a straight line fitted to the response-locked waveform at -400 to -50ms
slope_timeframe = [-200,0];
for s= file_start:length(allsubj)
    if ismember(subject_folder{s},subject_folder_ADHD)
        group=1;
    elseif ismember(subject_folder{s},subject_folder_Control)
        group=2;
    end
    for targetside=1:2
        avERPr_temp = squeeze(nanmean(nanmean(ERPr_cond(s,:,:,targetside,:,group),5),6));%(channel, samples)
        avERPr_plot = squeeze(nanmean(avERPr_temp(ch_front,:),1));
        coef = polyfit(tr(tr>slope_timeframe(1) & tr<slope_timeframe(2)),(avERPr_plot(tr>slope_timeframe(1) & tr<slope_timeframe(2))),1);% coef gives 2 coefficients fitting r = slope * x + intercept
        FrontalNeg_slope(s,targetside)=coef(1);
    end
end

%% Make participant level matrix for export into SPSS or R

%(1)Left_RT; (2)Right_RT; (3)RT_index; (4)NumRTtrials;
%(5)NumPreAlphaTrials; (6)NumN2trials; (7)NumCPPTrials
participant_level(:,1)= RT_Left;
participant_level(:,2)= RT_Right;
participant_level(:,3)= RT_index;
participant_level(:,4)= Valid_RT_Trials;
participant_level(:,5)= ValidPreAlphaTrials;
participant_level(:,6)= ValidN2Trials;
participant_level(:,7)= ValidCPPTrials; %this is also numttrials for frontal_negitivity and post-target alpha
participant_level(:,8:9)=PreAlpha_mean; %Left Hemi, Right Hemi  (from individualised ROI)
participant_level(:,10:13)=N2cN2i_amp_ByTargetSide_GrandAverage; %N2 amplitude using window based on GRAND AVERAGE N2c/i - Contra LeftTarget; Contra RightTarget; Ipsi LeftTarget; Ipsi RightTarget;
participant_level(:,14:17)=reshape(avAlpha_post_desync,length(subject_folder),4); %AlphaDesync - LeftHemi/Left-target, LeftHemi/Right-target, RightHemi/Left-target, RightHemi/Right-target 
participant_level(:,18:19)=CPP_patch_onsets; %Stim. locked CPP onset
participant_level(:,20:23)=N2cN2i_latency_ByTargetSide; %N2 Latency - %(LeftTargetN2c, RightTargetN2c, LeftTargetN2i, RightTargetN2i)  N2c_latency_LeftTarget
participant_level(:,24:25)=CPP_slope; %LeftTarget, RightTarget
participant_level(:,26:27)=FrontalNeg_slope;% FrontalNeg_slope
participant_level(:,28)=group_vector;
participant_level(:,29:32)=N2cN2i_amp_ByTargetSide_ParticipantLevel; %N2 amplitude using window based on PARTICIPANT's AVERAGE N2c/i - Contra LeftTarget; Contra RightTarget; Ipsi LeftTarget; Ipsi RightTarget;
participant_level(:,33) = RT_Assymetry;

T = table(subject_folder',participant_level(:,28),participant_level(:,1), participant_level(:,2), participant_level(:,3), participant_level(:,4),participant_level(:,5), participant_level(:,6),...
    participant_level(:,7), participant_level(:,8), participant_level(:,9), participant_level(:,10),participant_level(:,11), participant_level(:,12),...
    participant_level(:,13), participant_level(:,14), participant_level(:,15), participant_level(:,16),participant_level(:,17), participant_level(:,18),...
    participant_level(:,19), participant_level(:,20), participant_level(:,21), participant_level(:,22),participant_level(:,23), participant_level(:,24),...
     participant_level(:,25), participant_level(:,26), participant_level(:,27), participant_level(:,29), participant_level(:,30),...
     participant_level(:,31), participant_level(:,32), participant_level(:,33),'VariableNames',...
     {'IDs','Group','RT_Left','RT_Right','RT_index','Valid_RT_Trials','ValidPreAlphaTrials','ValidN2Trials','ValidCPPTrials','PreAlpha_mean_LH',...
    'PreAlpha_mean_RH', 'N2ciAmp_GA_ContraLeftTarget','N2ciAmp_GA_ContraRightTarget','N2ciAmp_GA_IpsiLeftTarget','N2ciAmp_GA_IpsiRightTarget',...
    'AlphaDesync_LeftHemi/Left-target', 'AlphaDesync_LeftHemi/Right-target',  'AlphaDesync_RightHemi/Left-target',  'AlphaDesync_RightHemi/Right-target',...
    'StimlockedCPPOnset_LeftTarget','StimlockedCPPOnset_RightTarget','N2CLatency_LeftTarget','N2CLatency_RightTarget','N2iLatency_LeftTarget','N2iLatency_RightTarget',...
    'CPP_slope_LeftTarget', 'CPP_slope_RightTarget','FrontalNeg_slope_Left','FrontalNeg_slope_Right',...
    'N2ciAmp_IndA_ContraLeftTarget','N2ciAmp_IndA_ContraRightTarget','N2ciAmp_IndA_IpsiLeftTarget','N2ciAmp_IndA_IpsiRightTarget','RT_Assymetry'});

save([pathOut 'participant_level_matrix.mat'],'T')

%diary off