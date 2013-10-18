function blockResult = doBlock(block, windowPtr, parms)

[blockMsg, stimuli, nCategories, nCycles, nTrials] = initBlock(block, parms);

% Display block message:
showCenteredMessage(windowPtr, blockMsg, parms.foreColor);
getResponseRT(KbName('SPACE'));

categories = doTrials(parms, windowPtr, stimuli, nCategories, nCycles, nTrials);

% Insert data into block result
str = textscan(parms.header, '%s', 'delimiter', ' ');
blockResult = cell(1, length(str{:}));

blockName = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  switch block
    case 'Practice'
      blockName{i} = 'PracB';
    case 'Four Categories'
      blockName{i} = 'FourB';
    case 'Five Categories'
      blockName{i} = 'FiveB';
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

category = cell(1, nCycles * nTrials);
count = 1;
for i = 1:nCycles
  for j = 1:nTrials
    categoryList = '';
    for k = 1:length(categories{count})
      categoryList = strcat(categoryList, categories{count}{k});
      if k ~= length(categories{count})
        categoryList = strcat(categoryList, ',');
      end
    end
    category{count} = categoryList;
    count = count + 1;
  end
end
blockResult{4} = category;

target = cell(1, nCycles * nTrials);
count = 1;
for i = 1:nCycles * nTrials
  stimulusList = '';
  for j = 1:length(parms.words)
    stimulusList = strcat(stimulusList, stimuli{count});
    count = count + 1;
    if j ~= length(parms.words)
      stimulusList = strcat(stimulusList, ',');
    end
  end
  target{i} = stimulusList;
end
blockResult{5} = target;