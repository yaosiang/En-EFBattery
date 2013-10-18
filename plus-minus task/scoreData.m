function [id, dv] = scoreData

exp = getRawData;

% Only RT of correct trials longer than 200 ms were analyzed.
% If RT of any correct trial longer than 200 ms, set RT to 0:
validRT = cell(length(exp.subject), 3);
for i = 1:length(exp.subject)
  block1RT = zeros(1, length(exp.subject(i).block(1).cycle) * length(exp.subject(i).block(1).cycle(1).trial));
  block2RT = zeros(1, length(exp.subject(i).block(2).cycle) * length(exp.subject(i).block(2).cycle(1).trial));
  block3RT = zeros(1, length(exp.subject(i).block(3).cycle) * length(exp.subject(i).block(3).cycle(1).trial));

  for j = 1:length(exp.subject(i).block(1).cycle)
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(1).cycle(j).trial(k).rt < 200
          exp.subject(i).block(1).cycle(j).trial(k).rt = 0;
        else
          block1RT(k) = exp.subject(i).block(1).cycle(j).trial(k).rt;
        end
      else
        exp.subject(i).block(1).cycle(j).trial(k).rt = 0;
      end
    end
  end
  block1RT = block1RT(block1RT > 0);

  for j = 1:length(exp.subject(i).block(2).cycle)
    for k = 1:length(exp.subject(i).block(2).cycle(j).trial)
      if strcmp(exp.subject(i).block(2).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(2).cycle(j).trial(k).rt < 200
          exp.subject(i).block(2).cycle(j).trial(k).rt = 0;
        else
          block2RT(k) = exp.subject(i).block(2).cycle(j).trial(k).rt;
        end
      else
        exp.subject(i).block(2).cycle(j).trial(k).rt = 0;
      end
    end
  end
  block2RT = block2RT(block2RT > 0);

  for j = 1:length(exp.subject(i).block(3).cycle)
    for k = 1:length(exp.subject(i).block(3).cycle(j).trial)
      if strcmp(exp.subject(i).block(3).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(3).cycle(j).trial(k).rt < 200
          exp.subject(i).block(3).cycle(j).trial(k).rt = 0;
        else
          block3RT(k) = exp.subject(i).block(3).cycle(j).trial(k).rt;
        end
      else
        exp.subject(i).block(3).cycle(j).trial(k).rt = 0;
      end
    end
  end
  block3RT = block3RT(block3RT > 0);

  validRT{i, 1} = block1RT;
  validRT{i, 2} = block2RT;
  validRT{i, 3} = block3RT;
end

totalValidRT = [];
for i = 1:length(exp.subject)
  totalValidRT = [totalValidRT, validRT{i, 1}, validRT{i, 2}, validRT{i, 3}];
end

% Get the upper and lower criteria of between-subject RT distribution:
upperCriteria = mean(totalValidRT) + (std(totalValidRT) * 3);
lowerCriteria = mean(totalValidRT) - (std(totalValidRT) * 3);


% Stage 1:
% Replace the extreme RT to upper or lower criteria:
for i = 1:length(exp.subject)
  for j = 1:length(exp.subject(i).block(1).cycle)
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(1).cycle(j).trial(k).rt ~= 0
          if exp.subject(i).block(1).cycle(j).trial(k).rt > upperCriteria
            exp.subject(i).block(1).cycle(j).trial(k).rt = upperCriteria;
          end
          if exp.subject(i).block(1).cycle(j).trial(k).rt < lowerCriteria
            exp.subject(i).block(1).cycle(j).trial(k).rt = lowerCriteria;
          end
        end
      end
    end
  end
  for j = 1:length(exp.subject(i).block(2).cycle)
    for k = 1:length(exp.subject(i).block(2).cycle(j).trial)
      if strcmp(exp.subject(i).block(2).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(2).cycle(j).trial(k).rt ~= 0
          if exp.subject(i).block(2).cycle(j).trial(k).rt > upperCriteria
            exp.subject(i).block(2).cycle(j).trial(k).rt = upperCriteria;
          end
          if exp.subject(i).block(2).cycle(j).trial(k).rt < lowerCriteria
            exp.subject(i).block(2).cycle(j).trial(k).rt = lowerCriteria;
          end
        end
      end
    end
  end
  for j = 1:length(exp.subject(i).block(3).cycle)
    for k = 1:length(exp.subject(i).block(3).cycle(j).trial)
      if strcmp(exp.subject(i).block(3).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(3).cycle(j).trial(k).rt ~= 0
          if exp.subject(i).block(3).cycle(j).trial(k).rt > upperCriteria
            exp.subject(i).block(3).cycle(j).trial(k).rt = upperCriteria;
          end
          if exp.subject(i).block(3).cycle(j).trial(k).rt < lowerCriteria
            exp.subject(i).block(3).cycle(j).trial(k).rt = lowerCriteria;
          end
        end
      end
    end
  end
end


% Stage 2:
% Get the upper and lower criteria of within-subject RT distribution:
subjectRT = cell(1, length(exp.subject));
upperCriteria = zeros(1, length(exp.subject));
lowerCriteria = zeros(1, length(exp.subject));
for i = 1:length(exp.subject)
  block1RT = zeros(1, length(exp.subject(i).block(1).cycle) * length(exp.subject(i).block(1).cycle(1).trial));
  block2RT = zeros(1, length(exp.subject(i).block(2).cycle) * length(exp.subject(i).block(2).cycle(1).trial));
  block3RT = zeros(1, length(exp.subject(i).block(3).cycle) * length(exp.subject(i).block(3).cycle(1).trial));

  for j = 1:length(exp.subject(i).block(1).cycle)
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(1).cycle(j).trial(k).rt ~= 0
          block1RT(k) = exp.subject(i).block(1).cycle(j).trial(k).rt;
        end
      end
    end
  end
  block1RT = block1RT(block1RT > 0);

  for j = 1:length(exp.subject(i).block(2).cycle)
    for k = 1:length(exp.subject(i).block(2).cycle(j).trial)
      if strcmp(exp.subject(i).block(2).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(2).cycle(j).trial(k).rt ~= 0
          block2RT(k) = exp.subject(i).block(2).cycle(j).trial(k).rt;
        end
      end
    end
  end
  block2RT = block2RT(block2RT > 0);

  for j = 1:length(exp.subject(i).block(3).cycle)
    for k = 1:length(exp.subject(i).block(3).cycle(j).trial)
      if strcmp(exp.subject(i).block(3).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(3).cycle(j).trial(k).rt ~= 0
          block3RT(k) = exp.subject(i).block(3).cycle(j).trial(k).rt;
        end
      end
    end
  end
  block3RT = block3RT(block3RT > 0);

  subjectRT{i} = [block1RT, block2RT, block3RT];

  upperCriteria(i) = mean(subjectRT{i}) + (std(subjectRT{i}) * 3);
  lowerCriteria(i) = mean(subjectRT{i}) - (std(subjectRT{i}) * 3);
end

% Replace the extreme RT to upper or lower criteria:
for i = 1:length(exp.subject)
  for j = 1:length(exp.subject(i).block(1).cycle)
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(1).cycle(j).trial(k).rt ~= 0
          if exp.subject(i).block(1).cycle(j).trial(k).rt > upperCriteria(i)
            exp.subject(i).block(1).cycle(j).trial(k).rt = upperCriteria(i);
          end
          if exp.subject(i).block(1).cycle(j).trial(k).rt < lowerCriteria(i)
            exp.subject(i).block(1).cycle(j).trial(k).rt = lowerCriteria(i);
          end
        end
      end
    end
  end
  for j = 1:length(exp.subject(i).block(2).cycle)
    for k = 1:length(exp.subject(i).block(2).cycle(j).trial)
      if strcmp(exp.subject(i).block(2).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(2).cycle(j).trial(k).rt ~= 0
          if exp.subject(i).block(2).cycle(j).trial(k).rt > upperCriteria(i)
            exp.subject(i).block(2).cycle(j).trial(k).rt = upperCriteria(i);
          end
          if exp.subject(i).block(2).cycle(j).trial(k).rt < lowerCriteria(i)
            exp.subject(i).block(2).cycle(j).trial(k).rt = lowerCriteria(i);
          end
        end
      end
    end
  end
  for j = 1:length(exp.subject(i).block(3).cycle)
    for k = 1:length(exp.subject(i).block(3).cycle(j).trial)
      if strcmp(exp.subject(i).block(3).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(3).cycle(j).trial(k).rt ~= 0
          if exp.subject(i).block(3).cycle(j).trial(k).rt > upperCriteria(i)
            exp.subject(i).block(3).cycle(j).trial(k).rt = upperCriteria(i);
          end
          if exp.subject(i).block(3).cycle(j).trial(k).rt < lowerCriteria(i)
            exp.subject(i).block(3).cycle(j).trial(k).rt = lowerCriteria(i);
          end
        end
      end
    end
  end
end


id = zeros(1, length(exp.subject));
dv = zeros(1, length(exp.subject));

for i = 1:length(exp.subject)
  id(i) = str2double(exp.subject(i).Id);

  nonShiftRT = 0;
  shiftRT = 0;

  cycleDv = zeros(1, length(exp.subject(i).block(1).cycle));
  for j = 1:length(exp.subject(i).block(1).cycle)
    correctCount = 0;
    totalRT = 0;
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(1).cycle(j).trial(k).rt ~= 0
          correctCount = correctCount + 1;
          totalRT = totalRT + exp.subject(i).block(1).cycle(j).trial(k).rt;
        end
      end
    end
    if correctCount ~= 0
      cycleDv(j) = totalRT / correctCount;
    else
      cycleDv(j) = 0;
    end
  end
  block1NonZeroCycleCount = length(find(cycleDv > 0));
  if block1NonZeroCycleCount ~= 0
    nonShiftRT = nonShiftRT + (sum(cycleDv) / block1NonZeroCycleCount);
  else
    nonShiftRT = 0;
  end

  cycleDv = zeros(1, length(exp.subject(i).block(2).cycle));
  for j = 1:length(exp.subject(i).block(2).cycle)
    correctCount = 0;
    totalRT = 0;
    for k = 1:length(exp.subject(i).block(2).cycle(j).trial)
      if strcmp(exp.subject(i).block(2).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(2).cycle(j).trial(k).rt ~= 0
          correctCount = correctCount + 1; 
          totalRT = totalRT + exp.subject(i).block(2).cycle(j).trial(k).rt;
        end
      end
    end
    if correctCount ~= 0
      cycleDv(j) = totalRT / correctCount;
    else
      cycleDv(j) = 0;
    end
  end
  block2NonZeroCycleCount = length(find(cycleDv > 0));
  if block2NonZeroCycleCount ~= 0
    nonShiftRT = nonShiftRT + (sum(cycleDv) / block2NonZeroCycleCount);
  else
    nonShiftRT = 0;
  end

  if block1NonZeroCycleCount ~= 0 || block2NonZeroCycleCount ~= 0
    nonShiftRT = nonShiftRT / (block1NonZeroCycleCount + block2NonZeroCycleCount);
  else
    nonShiftRT = 0;
  end
  
  cycleDv = zeros(1, length(exp.subject(i).block(3).cycle));
  for j = 1:length(exp.subject(i).block(3).cycle)
    correctCount = 0;
    totalRT = 0;
    for k = 1:length(exp.subject(i).block(3).cycle(j).trial)
      if strcmp(exp.subject(i).block(3).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(3).cycle(j).trial(k).rt ~= 0
          correctCount = correctCount + 1;
          totalRT = totalRT + exp.subject(i).block(3).cycle(j).trial(k).rt;
        end
      end
    end
    if correctCount ~= 0
      cycleDv(j) = totalRT / correctCount;
    else
      cycleDv(j) = 0;
    end
  end
  block3NonZeroCycleCount = length(find(cycleDv > 0));
  if block3NonZeroCycleCount ~= 0
    shiftRT = shiftRT + (sum(cycleDv) / block3NonZeroCycleCount);
  else
    shiftRT = 0;
  end

  dv(i) = shiftRT - nonShiftRT;
end