function [blockMsg, randStimuli, nCycles, nTrials] = initBlock(block, parms)

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

asteriskColorMapping = fullfact([1, length(parms.colorStimuli)]);
asteriskColorMapping = num2cell(asteriskColorMapping', [2, max(size(asteriskColorMapping))]);
nameColorMapping = fullfact([length(parms.nameStimuli), length(parms.colorStimuli)]);
nameColorMapping = num2cell(nameColorMapping', [2, max(size(nameColorMapping))]);

asteriskColorIndex = randSequence(1:length(asteriskColorMapping{1}), nCycles, (nTrials / 2));
nameColorIndex = randSequence(1:length(nameColorMapping{1}), nCycles, (nTrials / 2));

asteriskColor = cell(2, nCycles * (nTrials / 2));
nameColor = cell(2, nCycles * (nTrials / 2));
randStimuli = cell(2, nCycles * nTrials);

count = 1;
for i = 1:nCycles
  for j = 1:(nTrials / 2)
    color = parms.colorStimuli{asteriskColorMapping{2}(asteriskColorIndex(j))};
    asteriskColor{1, count} = parms.asteriskStimuli;
    asteriskColor{2, count} = color;
    count = count + 1;
  end
end

count = 1;
for i = 1:nCycles
  for j = 1:(nTrials / 2)
    name = parms.nameStimuli{nameColorMapping{1}(nameColorIndex(j))};
    color = parms.colorStimuli{nameColorMapping{2}(nameColorIndex(j))};
    nameColor{1, count} = name;
    nameColor{2, count} = color;
    count = count + 1;
  end
end

stimuli = horzcat(asteriskColor, nameColor);

stimuliIndex = randSequence(1:length(stimuli), 1, nCycles * nTrials);

count = 1;
for i = 1:nCycles
  for j = 1:nTrials
    randStimuli{1, count} = stimuli{1, stimuliIndex(count)};
    randStimuli{2, count} = stimuli{2, stimuliIndex(count)};
    count = count + 1;
  end
end