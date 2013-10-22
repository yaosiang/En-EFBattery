function [isBuild, blockMsg, stimuli, nCycles, nTrials] = ...
    initBlock(block, parms)

isBuild = false;

switch block
  case 'Build Practice'
    nCycles = parms.buildPracCycles;
    nTrials = parms.buildPracTrials;
    blockMsg = parms.buildPracMsg;
    isBuild = true;
  case 'Build'
    nCycles = parms.buildCycles;
    nTrials = parms.buildTrials;
    blockMsg = parms.buildMsg;
    isBuild = true;
  case 'Stop Practice'
    nCycles = parms.stopPracCycles;
    nTrials = parms.stopPracTrials;
    blockMsg = parms.stopPracMsg;
    nSignal = parms.nPracSignal;
  case 'Stop'
    nCycles = parms.stopCycles;
    nTrials = parms.stopTrials;
    blockMsg = parms.stopMsg;
    nSignal = parms.nSignal;
end

totalStopSequence = randperm(nTrials);

stimuli = randSequence([parms.animalStimuli, parms.nonAnimalStimuli], nCycles, nTrials);
for i = 1:length(stimuli)
  stimuli{i}(length(stimuli{i}) + 1) = 'N';
end

if ~isBuild
  stopSequence = totalStopSequence(1:nSignal);
  for i = 1:length(stopSequence)
    stimuli{stopSequence(i)}(length(stimuli{stopSequence(i)})) = 'Y';
  end
end