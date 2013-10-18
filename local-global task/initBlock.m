function [blockMsg, stimuli, nCycles, nTrials] = initBlock(block, parms)

switch block
  case 'Practice'
    nCycles = parms.pracCycles;
    nTrials = parms.pracTrials;
    blockMsg = parms.pracMsg;
  case 'Experiment'
    nCycles = parms.expCycles;
    nTrials = parms.expTrials;
    blockMsg = parms.expMsg;
end

perm = fullfact([length(parms.colorFeatures) ...
                 length(parms.globalFeatures) length(parms.localFeatures)]);
totalStimuliTable = cell(1, length(perm));
sameStimuliTable = cell(1, (length(perm) / 4));

for i = 1:length(perm)
  colorFeature = parms.colorFeatures{perm(i, 1)};
  globalFeature = parms.globalFeatures{perm(i, 2)};
  localFeature = parms.localFeatures{perm(i, 3)};
  stimulusImageFile = ['G_' globalFeature '-L_' localFeature '-' ...
    colorFeature '.jpg'];
  totalStimuliTable{i} = stimulusImageFile;
end

count = 1;
for i = 1:length(totalStimuliTable)
  remain = regexprep(totalStimuliTable{i}, '.jpg', '');
  target = textscan(char(remain), '%s', 'delimiter', '-');
  globalTarget = regexprep(target{1}{1}, 'G_', '');
  localTarget = regexprep(target{1}{2}, 'L_', '');
  if strcmp(globalTarget, localTarget)
    sameStimuliTable{count} = totalStimuliTable{i};
    totalStimuliTable{i} = '';
    count = count + 1;
  end
end
totalStimuliTable = totalStimuliTable(~strcmp(totalStimuliTable, ''));

alternativeStimuli = randSequence(totalStimuliTable, nCycles, (nTrials / 2));
sameStimuli = randSequence(sameStimuliTable, nCycles, (nTrials / 2));
stimuli = horzcat(sameStimuli, alternativeStimuli);
stimuli = randSequence(stimuli, nCycles, nTrials);