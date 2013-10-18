function [isResponseMapping, blockMsg, fixation, stimuli, nCycles, nTrials] = ...
    initBlock(block, parms)

isResponseMapping = false;

switch block
  case 'Response Mapping Practice'
    nCycles = parms.responseMappingPracCycles;
    nTrials = parms.responseMappingPracTrials;
    blockMsg = parms.responseMappingPracMsg;
    isResponseMapping = true;
  case 'Response Mapping'
    nCycles = parms.responseMappingCycles;
    nTrials = parms.responseMappingTrials;
    blockMsg = parms.responseMappingMsg;
    isResponseMapping = true;
  case 'Antisaccade Practice'
    nCycles = parms.antisaccadePracCycles;
    nTrials = parms.antisaccadePracTrials;
    blockMsg = parms.antisaccadePracMsg;
  case 'Antisaccade'
    nCycles = parms.antisaccadeCycles;
    nTrials = parms.antisaccadeTrials;
    blockMsg = parms.antisaccadeMsg;
end

fixation = randSequence(parms.fixationDuration, nCycles, nTrials);
stimuli = randSequence(parms.stimuli, nCycles, nTrials);