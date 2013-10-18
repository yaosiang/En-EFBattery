function blockResult = doBlock(block, windowPtr, parms)

[isResponseMapping, blockMsg, fixation, stimuli, nCycles, nTrials] ...
    = initBlock(block, parms);

% Display block message:
showCenteredMessage(windowPtr, blockMsg, parms.foreColor);
getResponseRT(KbName('SPACE'));

[response, rt, acc] = doTrials(parms, windowPtr, ...
    isResponseMapping, fixation, stimuli, nCycles, nTrials);

% Insert data into block result
str = textscan(parms.header, '%s', 'delimiter', ' ');
blockResult = cell(1, length(str{:}));

blockName = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  switch block
    case 'Response Mapping Practice'
      blockName{i} = 'RespMapPracB';
    case 'Response Mapping'
      blockName{i} = 'RespMapB';
    case 'Antisaccade Practice'
      blockName{i} = 'AntiPracB';
    case 'Antisaccade'
      blockName{i} = 'AntiB';
  end
end
blockResult{1} = blockName;

cycle = 1:nCycles * nTrials;
trial = 1:nCycles * nTrials;
count = 1;
for iCycle = 1:nCycles
  for jTrial = 1:nTrials
    cycle(count) = iCycle;
    trial(count) = jTrial;
    count = count + 1;
  end
end
blockResult{2} = num2cell(cycle);
blockResult{3} = num2cell(trial);

blockResult{4} = num2cell(fixation);

position = cell(1, nCycles * nTrials);
if isResponseMapping
  for i = 1:nCycles * nTrials
    position{i} = 'Null';
  end
else
  for i = 1:nCycles * nTrials
    position{i} = stimuli{i}(2);
  end
end
blockResult{5} = position;

target = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  target{i} = stimuli{i}(1);
end
blockResult{6} = target;

blockResult{7} = response;
blockResult{8} = num2cell(rt);
blockResult{9} = acc;