function [blockMsg, stimuli, nTones, nCycles, nTrials] = initBlock(block, parms)

switch block
  case 'Practice'
    nCycles = parms.pracCycles;
    nTrials = parms.pracTrials;
    blockMsg = parms.pracMsg;
    nTones = parms.pracTones;
  case 'Experiment'
    nCycles = parms.expCycles;
    nTrials = parms.expTrials;
    blockMsg = parms.expMsg;
    nTones = parms.expTones;
end

pitchNo = floor(nTones / length(parms.stimuli));
remainNo = mod(nTones, length(parms.stimuli));

remainStimuli = randSequence(parms.stimuli, 1, remainNo);

totalStimuli = cell(1, nTones);
count = 1;
for i = 1:pitchNo
  for j = 1:length(parms.stimuli)
    totalStimuli{count} = parms.stimuli{j};
    count = count + 1;
  end
end
for i = 1:length(remainStimuli)
  totalStimuli{end-i+1} = remainStimuli{i};
end

stimuli = randSequence(totalStimuli, nCycles, nTrials * nTones);