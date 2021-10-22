diary step6log
681
%% -------------------------------------------------------------------------------------------------
% RT by side
% --------------------------------------------------------------------------------------------------
Colors=[0,0,0;87,19,39]/256;
close all;
figure('color','w')

h1 = rm_raincloud([{T.RT_Left(T.Group==1), T.RT_Left(T.Group==2)};{T.RT_Right(T.Group==1), T.RT_Right(T.Group==2)}], [Colors(1,:); Colors(2,:)]);hold on
legend('ADHD',' ','Control',' ');set(gca,'XTick',([0:400:1600]),'YTickLabel',{'Left';'Right'}, 'FontSize',16,'FontWeight','bold','linewidth',2)
ylabel('Hemifield');
xlabel('RT (ms)')

% paired-t test within each group
[h pvalueA ci stats]  = ttest(T.RT_Left(T.Group==1), T.RT_Right(T.Group==1));
[h pvalueB ci stats]  = ttest(T.RT_Left(T.Group==2), T.RT_Right(T.Group==2));

%% -------------------------------------------------------------------------------------------------
% RT Assymetry
% --------------------------------------------------------------------------------------------------
close all;
figure('color','w')

CategoricalScatterplot(T.RT_Assymetry,'Group',T.Group,'Label',{'ADHD', 'Control'});
yticks([-0.2:0.1:0.2])
yticklabels([-0.2:0.1:0.2])
ylabel('RT Assymetry (ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.RT_Assymetry(T.Group==1), T.RT_Assymetry(T.Group==2))

%% -------------------------------------------------------------------------------------------------
% Overall Misses 
% --------------------------------------------------------------------------------------------------
close all;
figure('color','w')

CategoricalScatterplot(T.misses,'Group',T.Group,'Label',{'ADHD', 'Control'});
% yticks([500:200:1300])
% yticklabels([500:200:1300])
ylabel('Overal Misses')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
t
%% -------------------------------------------------------------------------------------------------
% Misses by side 
% --------------------------------------------------------------------------------------------------
Colors=[0,0,0;87,19,39]/256;
close all;
figure('color','w')

h1 = rm_raincloud([{T.misses_left(T.Group==1), T.misses_left(T.Group==2)};{T.misses_right(T.Group==1), T.misses_right(T.Group==2)}], [Colors(1,:); Colors(2,:)]);hold on
legend('ADHD',' ','Control',' ');set(gca,'XLim',([-25,75]),'XTick',([-25:25:75]),'YTickLabel',{'Left';'Right'}, 'FontSize',16,'FontWeight','bold','linewidth',2)
ylabel('Hemifield');
xlabel('Misses')

% paired-t test within each group
[h pvalueA ci stats]  = ttest(T.misses_left(T.Group==1), T.misses_right(T.Group==1))
1
%% -------------------------------------------------------------------------------------------------
% Spearman correlation between RT and CPP slope
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
color = [0 0 0; 0.64,0.08,0.18];
markerSize = [36;36];
tl = subtitle(' Left Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Left,T.CPP_slope_LeftTarget,[],'w','filled');hold on
gscatter(T.RT_Left,T.CPP_slope_LeftTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('CPP Slope (\muV/m^2/ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-0.025,0.075]);yticks([-0.025:0.025:0.075]);yticklabels([-0.025:0.025:0.075])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation between RT and CPP slope (left Target)
[corDifAA, pvalDifAA] = corr(T.RT_Left(T.Group==1),T.CPP_slope_LeftTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation between RT and CPP slope (left Target)
[corDifBB, pvalDifBB] = corr(T.RT_Left(T.Group==2),T.CPP_slope_LeftTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation between RT and CPP slope (left Target)
[corDifCC, pvalDifCC] = corr(T.RT_Left,T.CPP_slope_LeftTarget,'type','Spearman')

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
color = [0 0 0; 0.64,0.08,0.18];
markerSize = [36;36];
tl = subtitle(' Right Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Right,T.CPP_slope_RightTarget,[],'w','filled');hold on
gscatter(T.RT_Right,T.CPP_slope_RightTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('CPP Slope (\muV/m^2/ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-0.025,0.075]);yticks([-0.025:0.025:0.075]);yticklabels([-0.025:0.025:0.075])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and CPP slope (Right Target)
[corDifA, pvalDifA] = corr(T.RT_Right(T.Group==1),T.CPP_slope_RightTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and CPP slope (Right Target)
[corDifB, pvalDifB] = corr(T.RT_Right(T.Group==2),T.CPP_slope_RightTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and CPP slope (Right Target)
[corDifC, pvalDifC] = corr(T.RT_Right,T.CPP_slope_RightTarget,'type','Spearman')

%% -------------------------------------------------------------------------------------------------
% Spearman correlation between RT and CPP Amplitude
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
color = [0 0 0; 0.64,0.08,0.18];
markerSize = [36;36];
tl = subtitle('Left Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Left,T.CPP_Amplitude_Left,[],'w','filled');hold on
gscatter(T.RT_Left,T.CPP_Amplitude_Left,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('CPP Amplitude (\muV)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-10,30]);yticks([-10:10:30]);yticklabels([-10:10:30])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and CPP Amplitude (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Left(T.Group==1),T.CPP_Amplitude_Left(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and CPP Amplitude (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Left(T.Group==2),T.CPP_Amplitude_Left(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and CPP Amplitude (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Left,T.CPP_Amplitude_Left,'type','Spearman')

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
color = [0 0 0; 0.64,0.08,0.18];
markerSize = [36;36];
tl = subtitle(' Right Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Right,T.CPP_Amplitude_Right,[],'w','filled');hold on
gscatter(T.RT_Right,T.CPP_Amplitude_Right,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('CPP Amplitude (\muV)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-10,30]);yticks([-10:10:30]);yticklabels([-10:10:30])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and CPP Amplitude (Right Target)
[corDifA, pvalDifA] = corr(T.RT_Right(T.Group==1),T.CPP_Amplitude_Right(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and CPP Amplitude (Right Target)
[corDifB, pvalDifB] = corr(T.RT_Right(T.Group==2),T.CPP_Amplitude_Right(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and CPP Amplitude (Right Target)
[corDifC, pvalDifC] = corr(T.RT_Right,T.CPP_Amplitude_Right,'type','Spearman')

%% -------------------------------------------------------------------------------------------------
% Spearman correlation between RT and Stim locked CPP Onset Latency
% --------------------------------------------------------------------------------------------------
% (NOTE: This part needs some thoughts. Some participants did not have significant stimlocked CPPS
% and are removed. Resposne-locked CPP is not measured)
% Left Target
close all;
figure('color','w')
color = [0 0 0; 0.64,0.08,0.18];
markerSize = [36;36];
tl = subtitle(' Left Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
indx = find(T.StimlockedCPPOnset_LeftTarget);
scatter(T.RT_Left(indx),T.StimlockedCPPOnset_LeftTarget(indx),[],'w','filled');hold on
gscatter(T.RT_Left(indx),T.StimlockedCPPOnset_LeftTarget(indx),T.Group(indx), color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('CPP Onset latency (ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([0,1000]);yticks([0:250:1000]);yticklabels([0:250:1000])
xlim([400,1300]);xticks([400:300:1300]);xticklabels([400:300:1300])

% ADHD : Spearman correlation betwee RT and CPP Onset Latency (Left Target)
nonzeroADHD  = T.StimlockedCPPOnset_LeftTarget(T.Group==1);
nonzeroADHD_index = find(nonzeroADHD);
[corDifA, pvalDifA] = corr(T.RT_Left(nonzeroADHD_index),nonzeroADHD(nonzeroADHD_index),'type','Spearman')
% Control : Spearman correlation betwee RT and CPP Onset Latency (Left Target)
nonzeroConrol  = T.StimlockedCPPOnset_LeftTarget(T.Group==2);
nonzeroConrol_index = find(nonzeroConrol);
nonzeroConrol_index_All  = nonzeroConrol_index+length(T.StimlockedCPPOnset_LeftTarget(T.Group==1));%add adhd subj length
[corDifA, pvalDifA] = corr(T.RT_Left(nonzeroConrol_index_All),nonzeroConrol(nonzeroConrol_index),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and CPP Onset Latency (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Left(indx),T.StimlockedCPPOnset_LeftTarget(indx),'type','Spearman')

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
color = [0 0 0; 0.64,0.08,0.18];
markerSize = [36;36];
tl = subtitle(' Right Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
indx = find(T.StimlockedCPPOnset_RightTarget);
scatter(T.RT_Right(indx),T.StimlockedCPPOnset_RightTarget(indx),[],'w','filled');hold on
gscatter(T.RT_Right(indx),T.StimlockedCPPOnset_RightTarget(indx),T.Group(indx), color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('CPP Onset latency (ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([0,1000]);yticks([0:250:1000]);yticklabels([0:250:1000])
xlim([400,1300]);xticks([400:300:1300]);xticklabels([400:300:1300])

% ADHD : Spearman correlation betwee RT and CPP Onset Latency (Left Target)
nonzeroADHD  = T.StimlockedCPPOnset_RightTarget(T.Group==1);
nonzeroADHD_index = find(nonzeroADHD);
[corDifA, pvalDifA] = corr(T.RT_Right(nonzeroADHD_index),nonzeroADHD(nonzeroADHD_index),'type','Spearman')
% Control : Spearman correlation betwee RT and CPP Onset Latency (Right Target)
nonzeroConrol  = T.StimlockedCPPOnset_RightTarget(T.Group==2);
nonzeroConrol_index = find(nonzeroConrol);
nonzeroConrol_index_All  = nonzeroConrol_index+length(T.StimlockedCPPOnset_RightTarget(T.Group==1));%add adhd subj length
[corDifA, pvalDifA] = corr(T.RT_Right(nonzeroConrol_index_All),nonzeroConrol(nonzeroConrol_index),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and CPP Onset Latency (Right Target)
[corDifC, pvalDifC] = corr(T.RT_Right(indx),T.StimlockedCPPOnset_RightTarget(indx),'type','Spearman')

%% -------------------------------------------------------------------------------------------------
% Spearman correlation between RT and N2c Amplitude
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Left Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Left,T.N2ciAmp_GA_ContraLeftTarget,[],'w','filled');hold on
gscatter(T.RT_Left,T.N2ciAmp_GA_ContraLeftTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2c Amplitude (\muV)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-10,10]);yticks([-10:5:100]);yticklabels([-10:5:10])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2c Amplitude (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Left(T.Group==1),T.N2ciAmp_GA_ContraLeftTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2c Amplitude (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Left(T.Group==2),T.N2ciAmp_GA_ContraLeftTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2c Amplitude (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Left,T.N2ciAmp_GA_ContraLeftTarget,'type','Spearman')

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Right Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Right,T.N2ciAmp_GA_ContraRightTarget,[],'w','filled');hold on
gscatter(T.RT_Right,T.N2ciAmp_GA_ContraRightTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2c Amplitude (\muV)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-10,10]);yticks([-10:5:100]);yticklabels([-10:5:10])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2c Amplitude (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Right(T.Group==1),T.N2ciAmp_GA_ContraRightTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2c Amplitude (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Right(T.Group==2),T.N2ciAmp_GA_ContraRightTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2c Amplitude (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Right,T.N2ciAmp_GA_ContraRightTarget,'type','Spearman')

%% -------------------------------------------------------------------------------------------------
% Spearman correlation between RT and N2i Amplitude
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Left Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Left,T.N2ciAmp_GA_IpsiLeftTarget,[],'w','filled');hold on
gscatter(T.RT_Left,T.N2ciAmp_GA_IpsiLeftTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2i Amplitude (\muV)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-10,10]);yticks([-10:5:100]);yticklabels([-10:5:10])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2i Amplitude (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Left(T.Group==1),T.N2ciAmp_GA_IpsiLeftTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2i Amplitude (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Left(T.Group==2),T.N2ciAmp_GA_IpsiLeftTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2i Amplitude (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Left,T.N2ciAmp_GA_IpsiLeftTarget,'type','Spearman')

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Right Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Right,T.N2ciAmp_GA_IpsiRightTarget,[],'w','filled');hold on
gscatter(T.RT_Right,T.N2ciAmp_GA_IpsiRightTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2c Amplitude (\muV)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([-10,10]);yticks([-10:5:100]);yticklabels([-10:5:10])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2i Amplitude (Right Target)
[corDifA, pvalDifA] = corr(T.RT_Right(T.Group==1),T.N2ciAmp_GA_IpsiRightTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2i Amplitude (Right Target)
[corDifB, pvalDifB] = corr(T.RT_Right(T.Group==2),T.N2ciAmp_GA_IpsiRightTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2i Amplitude (Right Target)
[corDifC, pvalDifC] = corr(T.RT_Right,T.N2ciAmp_GA_IpsiRightTarget,'type','Spearman')

%% -------------------------------------------------------------------------------------------------
% Spearman correlation between RT and N2c Onset latency
% --------------------------------------------------------------------------------------------------

% Left Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Left Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Left,T.N2CLatency_LeftTarget,[],'w','filled');hold on
gscatter(T.RT_Left,T.N2CLatency_LeftTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2c Onset Latency (ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([0, 600]);yticks([0:200:600]);yticklabels([0:200:600])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2c Onset (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Left(T.Group==1),T.N2CLatency_LeftTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2c Onset (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Left(T.Group==2),T.N2CLatency_LeftTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2c Onset (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Left,T.N2CLatency_LeftTarget,'type','Spearman')

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Right Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Right,T.N2CLatency_RightTarget,[],'w','filled');hold on
gscatter(T.RT_Right,T.N2CLatency_RightTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2c Onset Latency (ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([0, 600]);yticks([0:200:600]);yticklabels([0:200:600])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2c Onset (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Right(T.Group==1),T.N2CLatency_RightTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2c Onset (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Right(T.Group==2),T.N2CLatency_RightTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2c Onset (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Right,T.N2CLatency_RightTarget,'type','Spearman')

%% -------------------------------------------------------------------------------------------------
% Spearman correlation between RT and N2i Onset latency
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Left Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Left,T.N2iLatency_LeftTarget,[],'w','filled');hold on
gscatter(T.RT_Left,T.N2iLatency_LeftTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2i Onset Latency (ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([0, 600]);yticks([0:200:600]);yticklabels([0:200:600])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2i Onset (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Left(T.Group==1),T.N2iLatency_LeftTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2i Onset (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Left(T.Group==2),T.N2iLatency_LeftTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2i Onset (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Left,T.N2iLatency_LeftTarget,'type','Spearman')

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
color = [0.89 0.35 0.13; 0.11,0.30,0.24];
markerSize = [36;36];
tl = subtitle(' Right Target ');
tl.FontSize = 14;
tl.FontWeight = 'bold';
scatter(T.RT_Right,T.N2iLatency_RightTarget,[],'w','filled');hold on
gscatter(T.RT_Right,T.N2iLatency_RightTarget,T.Group, color, [], markerSize);
h = lsline; delete(h(2));delete(h(1));
h(3).LineWidth = 2;
legend('', 'ADHD', 'Control');legend('boxoff');
box off
xlabel('RT (ms)');%% hard coded
ylabel('N2i Onset Latency (ms)')
set(gca,'FontSize',14,'FontWeight','bold','linewidth',2)
ylim([0, 600]);yticks([0:200:600]);yticklabels([0:200:600])
xlim([350,1400]);xticks([350:350:1400]);xticklabels([350:350:1400])

% ADHD : Spearman correlation betwee RT and N2i Onset (Left Target)
[corDifA, pvalDifA] = corr(T.RT_Right(T.Group==1),T.N2iLatency_RightTarget(T.Group==1),'type','Spearman')
% Control : Spearman correlation betwee RT and N2i Onset (Left Target)
[corDifB, pvalDifB] = corr(T.RT_Right(T.Group==2),T.N2iLatency_RightTarget(T.Group==2),'type','Spearman')
% Both Groups : Spearman correlation betwee RT and N2i Onset (Left Target)
[corDifC, pvalDifC] = corr(T.RT_Right,T.N2iLatency_RightTarget,'type','Spearman')

%% -------------------------------------------------------------------------------------------------
% Compare CPP Slope between the two groups
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
title ('Left Target')
CategoricalScatterplot(T.CPP_slope_LeftTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-0.08,0.08])
yticks([-0.08:0.04:0.080])
yticklabels([-0.08:0.04:0.080])
ylabel('CPP Slope (\muV/m^2/ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.CPP_slope_LeftTarget(T.Group==1), T.CPP_slope_LeftTarget(T.Group==2))

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
title ('Right Target')
CategoricalScatterplot(T.CPP_slope_RightTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-0.08,0.08])
yticks([-0.08:0.04:0.080])
yticklabels([-0.08:0.04:0.080])
ylabel('CPP Slope (\muV/m^2/ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.CPP_slope_RightTarget(T.Group==1), T.CPP_slope_RightTarget(T.Group==2))

%% -------------------------------------------------------------------------------------------------
%  Compare CPP Amplitude between the two groups
% --------------------------------------------------------------------------------------------------

% Left Target
close all;
figure('color','w')
title ('Left Target')
CategoricalScatterplot(T.CPP_Amplitude_Left,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-20,40])
yticks([-20:20:40])
yticklabels([-20:20:40])
ylabel('CPP Amplitude (\muV)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.CPP_Amplitude_Left(T.Group==1), T.CPP_Amplitude_Left(T.Group==2))

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
title ('Right Target')
CategoricalScatterplot(T.CPP_Amplitude_Right,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-20,40])
yticks([-20:20:40])
yticklabels([-20:20:40])
ylabel('CPP Amplitude (\muV)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.CPP_Amplitude_Right(T.Group==1), T.CPP_Amplitude_Right(T.Group==2))

%% -------------------------------------------------------------------------------------------------
% Compare CPP Onset latency between the two groups
% --------------------------------------------------------------------------------------------------

% (NOTE: This part needs some thoughts. Some participants did not have significant stimlocked CPPS
% and are removed. Resposne-locked CPP is not measured)
% Left Target
nonzeros_index = find(T.StimlockedCPPOnset_LeftTarget);
close all;
figure('color','w')
title ('Left Target')
CategoricalScatterplot(T.StimlockedCPPOnset_LeftTarget(nonzeros_index),'Group',T.Group(nonzeros_index),'Label',{'ADHD', 'Control'});
ylim([0,1000])
yticks([0:250:1000])
yticklabels([0:250:1000])
ylabel('CPP Onset latency (ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
nonzeroADHD  = T.StimlockedCPPOnset_LeftTarget(T.Group==1);
nonzeroADHD_index = find(nonzeroADHD);

nonzeroConrol  = T.StimlockedCPPOnset_LeftTarget(T.Group==2);
nonzeroConrol_index = find(nonzeroConrol);
nonzeroConrol_index_All  = nonzeroConrol_index+length(T.StimlockedCPPOnset_LeftTarget(T.Group==1));%add adhd subj length
[h pvalue ci stats]  = ttest2(T.StimlockedCPPOnset_LeftTarget(nonzeroADHD_index),nonzeroConrol(nonzeroConrol_index))

% --------------------------------------------------------------------------------------------------
% Right Target
nonzeros_index = find(T.StimlockedCPPOnset_LeftTarget);
close all;
figure('color','w')
title ('Right Target')
CategoricalScatterplot(T.StimlockedCPPOnset_RightTarget(nonzeros_index),'Group',T.Group(nonzeros_index),'Label',{'ADHD', 'Control'});
ylim([0,1000])
yticks([0:250:1000])
yticklabels([0:250:1000])
ylabel('CPP Onset latency (ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
nonzeroADHD  = T.StimlockedCPPOnset_RightTarget(T.Group==1);
nonzeroADHD_index = find(nonzeroADHD);

nonzeroConrol  = T.StimlockedCPPOnset_RightTarget(T.Group==2);
nonzeroConrol_index = find(nonzeroConrol);
nonzeroConrol_index_All  = nonzeroConrol_index+length(T.StimlockedCPPOnset_RightTarget(T.Group==1));%add adhd subj length
[h pvalue ci stats]  = ttest2(T.StimlockedCPPOnset_RightTarget(nonzeroADHD_index),nonzeroConrol(nonzeroConrol_index))

%% -------------------------------------------------------------------------------------------------
% Compare N2c Amplitude between the two groups
% --------------------------------------------------------------------------------------------------

% Left Target
close all;
figure('color','w')
title ('Left Target')
CategoricalScatterplot(T.N2ciAmp_GA_ContraLeftTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-10,10])
yticks([-10:5:10])
yticklabels([-10:5:10])
ylabel('N2c Amplitude (\muV)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2ciAmp_GA_ContraLeftTarget(T.Group==1), T.N2ciAmp_GA_ContraLeftTarget(T.Group==2))

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
title ('Right Target')
CategoricalScatterplot(T.N2ciAmp_GA_ContraRightTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-10,10])
yticks([-10:5:10])
yticklabels([-10:5:10])
ylabel('N2c Amplitude (\muV)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2ciAmp_GA_ContraRightTarget(T.Group==1), T.N2ciAmp_GA_ContraRightTarget(T.Group==2))

%% -------------------------------------------------------------------------------------------------
% Compare N2c Onset Latency between the two groups
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
title ('Left Target')
CategoricalScatterplot(T.N2CLatency_LeftTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([150,400])
yticks([150:50:400])
yticklabels([150:50:400])
ylabel('N2c Onset Latency (ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2CLatency_LeftTarget(T.Group==1), T.N2CLatency_LeftTarget(T.Group==2))

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
title ('Right Target')
CategoricalScatterplot(T.N2CLatency_RightTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([150,400])
yticks([150:50:400])
yticklabels([150:50:400])
ylabel('N2c Onset Latency (ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2CLatency_RightTarget(T.Group==1), T.N2CLatency_RightTarget(T.Group==2))

%% -------------------------------------------------------------------------------------------------
% Compare N2i Amplitude between the two groups
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
title ('Left Target')
CategoricalScatterplot(T.N2ciAmp_GA_IpsiLeftTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-10,10])
yticks([-10:5:10])
yticklabels([-10:5:10])
ylabel('N2i Amplitude (\muV)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2ciAmp_GA_IpsiLeftTarget(T.Group==1), T.N2ciAmp_GA_IpsiLeftTarget(T.Group==2))

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
title ('Right Target')
CategoricalScatterplot(T.N2ciAmp_GA_IpsiRightTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([-10,10])
yticks([-10:5:10])
yticklabels([-10:5:10])
ylabel('N2i Amplitude (\muV)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2ciAmp_GA_IpsiRightTarget(T.Group==1), T.N2ciAmp_GA_IpsiRightTarget(T.Group==2))

%% -------------------------------------------------------------------------------------------------
% Compare N2i Onset Latency between the two groups
% --------------------------------------------------------------------------------------------------
% Left Target
close all;
figure('color','w')
title ('Left Target')
CategoricalScatterplot(T.N2iLatency_LeftTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([100,500])
yticks([100:100:500])
yticklabels([100:100:500])
ylabel('N2i Onset Latency (ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2iLatency_LeftTarget(T.Group==1), T.N2iLatency_LeftTarget(T.Group==2))

% --------------------------------------------------------------------------------------------------
% Right Target
close all;
figure('color','w')
title ('Right Target')
CategoricalScatterplot(T.N2iLatency_RightTarget,'Group',T.Group,'Label',{'ADHD', 'Control'});
ylim([100,500])
yticks([100:100:500])
yticklabels([100:100:500])
ylabel('N2i Onset Latency (ms)')
set(gca,'FontSize',16,'FontWeight','bold','linewidth',2)

% Two-sample t-test within each group
[h pvalue ci stats]  = ttest2(T.N2iLatency_RightTarget(T.Group==1), T.N2iLatency_RightTarget(T.Group==2))

%% -------------------------------------------------------------------------------------------------
% Compare Left and Right Target Frontal negativity within each group
% --------------------------------------------------------------------------------------------------

% NOTE : ********* Y-axis is reversed (negativity is up) to show the negativity ********

Colors=[0,0,0;87,19,39]/256;
close all;
figure('color','w')

h1 = rm_raincloud([{T.leftTargetFrontNeg(T.Group ==1),T.leftTargetFrontNeg(T.Group ==2)};{T.rightTargetFrontNeg(T.Group ==1),T.rightTargetFrontNeg(T.Group ==2)}], [Colors(1,:); Colors(2,:)]);hold on
legend('ADHD',' ','Control',' ');set(gca,'XTick',([-40:10:30]),'YTickLabel',{'Right';'Left'}, 'FontSize',16,'FontWeight','bold','linewidth',2)
ylabel('Hemifield');
xlabel('Frontal Negativity (\muV)')
set(gca, 'XDir','reverse')

% Take the pValue for this from Mark's tests showing the effect of group
% in the difference between left vs right target frontal negativity. This
% plot is enough and you dont need to show the plots in the section above

diary off

