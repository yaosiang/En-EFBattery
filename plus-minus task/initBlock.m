function [blockMsg, isPlus, isMinus, stimuli, nCycles, nTrials] = initBlock(block, parms)

isPlus = false;
isMinus = false;

switch block
  case 'Practice'
    nCycles = parms.pracCycles;
    nTrials = parms.pracTrials;
    blockMsg = parms.pracMsg;
    isPlus = true;
  case 'Plus'
    nCycles = parms.plusCycles;
    nTrials = parms.plusTrials;
    blockMsg = parms.plusMsg;
    isPlus = true;
  case 'Minus'
    nCycles = parms.minusCycles;
    nTrials = parms.minusTrials;
    blockMsg = parms.minusMsg;
    isMinus = true;
  case 'Plus Minus'
    nCycles = parms.plusMinusCycles;
    nTrials = parms.plusMinusTrials;
    blockMsg = parms.plusMinusMsg;
end

totalStimuli = randperm(parms.stimuli(end));

stimuli = 1:(parms.stimuli(end) - parms.stimuli(1) + 1);
count = 1;
for i = 1:length(totalStimuli)
  if totalStimuli(i) >= parms.stimuli(1)
    stimuli(count) = totalStimuli(i);
    count = count + 1;
  end
end
stimuli = stimuli(1:nTrials);

stimuli = randSequence(stimuli, nCycles, nTrials);