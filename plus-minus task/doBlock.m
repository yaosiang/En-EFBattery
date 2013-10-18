function blockResult = doBlock(block, windowPtr, parms)

[blockMsg, isPlus, isMinus, stimuli, nCycles, nTrials] = initBlock(block, parms);

% Display block message:
showCenteredMessage(windowPtr, blockMsg, parms.foreColor);
getResponseRT(KbName('SPACE'));

[response, rt, acc] = doTrials(parms, windowPtr, stimuli, isPlus, isMinus, nCycles, nTrials);

% Insert data into block result
str = textscan(parms.header, '%s', 'delimiter', ' ');
blockResult = cell(1, length(str{:}));

blockName = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  switch block
    case 'Practice'
      blockName{i} = 'PracB';    
    case 'Plus'
      blockName{i} = 'PlusB';
    case 'Minus'
      blockName{i} = 'MinusB';
    case 'Plus Minus'
      blockName{i} = 'PlusMinB';
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

target = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  target{i} = stimuli(i);
end
blockResult{4} = target;

blockResult{5} = response;
blockResult{6} = num2cell(rt);
blockResult{7} = acc;