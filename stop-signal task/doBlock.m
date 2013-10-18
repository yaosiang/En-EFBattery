function [parms, blockResult] = doBlock(block, windowPtr, parms)

[isBuild, blockMsg, stimuli, nCycles, nTrials] = initBlock(block, parms);

% Display block message:
showCenteredMessage(windowPtr, blockMsg, parms.foreColor);
getResponseRT(KbName('SPACE'));

[parms, response, rt, acc] = ...
    doTrials(parms, windowPtr, isBuild, stimuli, nCycles, nTrials);

% Insert data into block result
str = textscan(parms.header, '%s', 'delimiter', ' ');
blockResult = cell(1, length(str{:}));

blockName = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  switch block
    case 'Build Practice'
      blockName{i} = 'BuildPracB';
    case 'Build'
      blockName{i} = 'BuildB';
    case 'Stop Practice'
      blockName{i} = 'StopPracB';
    case 'Stop'
      blockName{i} = 'StopB';
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
isStop = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  target{i} = stimuli{i}(1:length(stimuli{i})-1);
  isStop{i} = stimuli{i}(length(stimuli{i}));
end
blockResult{4} = target;
blockResult{5} = isStop;

blockResult{6} = response;
blockResult{7} = num2cell(rt);
blockResult{8} = acc;