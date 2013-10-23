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

if strcmp(block, 'Practice')
    stimuliLength = randSequence(parms.pracListLength, nCycles, nTrials);
end

if strcmp (block, 'Experiment')
    stimuliLength = randSequence(parms.listLength, nCycles, nTrials);
end

stimuli = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
    stimuli{i} = randSequence(parms.consonants, 1, str2double(stimuliLength{i}));
end