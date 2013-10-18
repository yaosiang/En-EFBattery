function blockResult = doBlock(block, windowPtr, parms)

[isClockwise, isTopQuadrant, blockMsg, stimuli, nCycles, nTrials] = ...
    initBlock(block, parms);

% Display block message:
showCenteredMessage(windowPtr, blockMsg, parms.foreColor);
getResponseRT(KbName('SPACE'));

[response, rt, acc] = doTrials(parms, windowPtr, ...
    stimuli, isClockwise, isTopQuadrant, nCycles, nTrials);

% Insert data into block result
str = textscan(parms.header, '%s', 'delimiter', ' ');
blockResult = cell(1, length(str{:}));

blockName = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  switch block
    case 'Number Practice'
      blockName{i} = 'NumPracB';
    case 'Number'
      blockName{i} = 'NumB';
    case 'Letter Practice'
      blockName{i} = 'LettPracB';
    case 'Letter'
      blockName{i} = 'LettB';
    case 'Number-Letter Practice'
      blockName{i} = 'NumLettPracB';
    case 'Number-Letter'
      blockName{i} = 'NumLettB';
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

quadrant= cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  quadrant{i} = stimuli{i}(3);
end
blockResult{4} = quadrant;

target = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  target{i} = strcat(stimuli{i}(1), stimuli{i}(2));
end
blockResult{5} = target;

blockResult{6} = response;
blockResult{7} = num2cell(rt);
blockResult{8} = acc;