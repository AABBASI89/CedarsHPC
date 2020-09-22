function ffcEL_hpc(session,threads)
% This function performs Field-Field Coherence (FFC) analysis using newcrossf 
% function of EEGLAB. 
% @AamirAbbasi
% Input:
%      - session: Path to sessions which you want to analyize
%      - threads: Maximum number of threads you want to utilize per CPU core. 
%% Start!

if ~isempty(threads)
  maxNumCompThreads(threads);
end

load([session,'Collated_LFP.mat'],'trial_data1','trial_data2','Fs');

% Z-scoring M1 LFP data
trial_data1_n = zeros(size(trial_data1));
for j=1:size(trial_data1,1)
  tmp = reshape(squeeze(trial_data1(j,:,:)),1,[]);
  trial_data1_n(j,:,:) = (trial_data1(j,:,:)-mean(tmp))./std(tmp);
end

% Z-scoring Cb LFP data
trial_data2_n = zeros(size(trial_data2));
for j=1:size(trial_data2,1)
  tmp = reshape(squeeze(trial_data2(j,:,:)),1,[]);
  trial_data2_n(j,:,:) = (trial_data2(j,:,:)-mean(tmp))./std(tmp);
end

% Median subtraction CMR M1
med = squeeze(median(trial_data1_n,1));
for j=1:size(trial_data1_n,1)
  trial_data1_cmr(j,:,:) = bsxfun(@minus,squeeze(trial_data1_n(j,:,:)),med);
end

% Median subtraction CMR Cb
med = squeeze(median(trial_data2_n,1));
for j=1:size(trial_data2_n,1)
  trial_data2_cmr(j,:,:) = bsxfun(@minus,squeeze(trial_data2_n(j,:,:)),med);
end

% Split trials in to early and late
e_trial_data1_cmr = trial_data1_cmr(:,:,1:floor(size(trial_data1_cmr,3)/3));
l_trial_data1_cmr = trial_data1_cmr(:,:,end-floor(size(trial_data1_cmr,3)/3)+1:end);

% Split trials in early and late
e_trial_data2_cmr = trial_data2_cmr(:,:,1:floor(size(trial_data2_cmr,3)/3));
l_trial_data2_cmr = trial_data2_cmr(:,:,end-floor(size(trial_data2_cmr,3)/3)+1:end);

% Get Cross-Field Spectrum for early trials
for j=1:size(e_trial_data1_cmr,1)
  data1 = squeeze(e_trial_data1_cmr(j,1:8000,:));
  for k=1:size(e_trial_data2_cmr,1)
    data2 = squeeze(e_trial_data2_cmr(k,1:8000,:));
    [e_coher_cmr(j,:,:,k),~,~,~,~,e_cohangle_cmr(j,:,:,k),~]...
      = newcrossf(data1(:)',data2(:)',8000,[-4000 4000],Fs,[0.01 0.1],'type','coher','freqs', [0 60]);
  end
end

% Get Cross-Field Spectrum for late trials
for j=1:size(l_trial_data1_cmr,1)
  data1 = squeeze(l_trial_data1_cmr(j,1:8000,:));
  for k=1:size(l_trial_data2_cmr,1)
    data2 = squeeze(l_trial_data2_cmr(k,1:8000,:));
    [l_coher_cmr(j,:,:,k),~,times,freqs,~,l_cohangle_cmr(j,:,:,k),~]...
      = newcrossf(data1(:)',data2(:)',8000,[-4000 4000],Fs,[0.01 0.1],'type','coher','freqs', [0 60]);
  end
end

save([session,'FFC_EL_CMR.mat'],...
  'e_coher_cmr','e_cohangle_cmr',...
  'l_coher_cmr','l_cohangle_cmr',...
  'times','freqs','-v7.3');

%--------------------------- After ERP substraction --------------------------- %
% ERP subtraction (Channel by Channel) for M1
for ch=1:size(trial_data1_cmr,1)
  single_channel_data = squeeze(trial_data1_cmr(ch,:,:));
  mean_erp = mean(single_channel_data,2);
  trial_data1_erp(ch,:,:) = bsxfun(@minus,single_channel_data,mean_erp);
end

% ERP subtraction (Channel by Channel) for Cb
for ch=1:size(trial_data2_cmr,1)
  single_channel_data = squeeze(trial_data2_cmr(ch,:,:));
  mean_erp = mean(single_channel_data,2);
  trial_data2_erp(ch,:,:) = bsxfun(@minus,single_channel_data,mean_erp);
end

% Split trials in to early and late
e_trial_data1_erp = trial_data1_erp(:,:,1:floor(size(trial_data1_erp,3)/3));
l_trial_data1_erp = trial_data1_erp(:,:,end-floor(size(trial_data1_erp,3)/3)+1:end);

% Split trials in to early and late
e_trial_data2_erp = trial_data2_erp(:,:,1:floor(size(trial_data2_erp,3)/3));
l_trial_data2_erp = trial_data2_erp(:,:,end-floor(size(trial_data2_erp,3)/3)+1:end);

% Get Cross-Field Spectrum for early trials
for j=1:size(e_trial_data1_erp,1)
  data1 = squeeze(e_trial_data1_erp(j,1:8000,:));
  for k=1:size(e_trial_data2_erp,1)
    data2 = squeeze(e_trial_data2_erp(k,1:8000,:));
    [e_coher_erp(j,:,:,k),~,~,~,~,e_cohangle_erp(j,:,:,k),~]...
      = newcrossf(data1(:)',data2(:)',8000,[-4000 4000],Fs,[0.01 0.1],'type','coher','freqs', [0 60]);
  end
end

% Get Cross-Field Spectrum for late trials
for j=1:size(l_trial_data1_erp,1)
  data1 = squeeze(l_trial_data1_erp(j,1:8000,:));
  for k=1:size(l_trial_data2_erp,1)
    data2 = squeeze(l_trial_data2_erp(k,1:8000,:));
    [l_coher_erp(j,:,:,k),~,times,freqs,~,l_cohangle_erp(j,:,:,k),~]...
      = newcrossf(data1(:)',data2(:)',8000,[-4000 4000],Fs,[0.01 0.1],'type','coher','freqs', [0 60]);
  end
end

save([session,'FFC_EL_ERP.mat'],...
  'e_coher_erp','e_cohangle_erp',...
  'l_coher_erp','l_cohangle_erp',...
  'times','freqs','-v7.3');
end

