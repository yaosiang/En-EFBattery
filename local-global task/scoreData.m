function [id, dv] = scoreData

exp = getRawData;

% Only RT of correct trials longer than 200 ms were analyzed.
% If RT of any correct trial longer than 200 ms, set RT to 0:
validRT = cell(length(exp.subject), 1);
block1Count = 1;
for i = 1:length(exp.subject)
  block1RT = zeros(1, length(exp.subject(i).block(1).cycle) * length(exp.subject(i).block(1).cycle(1).trial));

  for j = 1:length(exp.subject(i).block(1).cycle)
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(1).cycle(j).trial(k).rt < 200
          exp.subject(i).block(1).cycle(j).trial(k).rt = 0;
        else
          block1RT(block1Count) = exp.subject(i).block(1).cycle(j).trial(k).rt;
        end
      end
      block1Count = block1Count + 1;
    end
  end
  block1RT = block1RT(block1RT > 0);

  validRT{i, 1} = block1RT;
end

totalValidRT = [];
for i = 1:length(exp.subject)
  totalValidRT = [totalValidRT, validRT{i, 1}];
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
end


% Stage 2:
% Get the upper and lower criteria of within-subject RT distribution:
block1Count = 1;
subjectRT = cell(1, length(exp.subject));
upperCriteria = zeros(1, length(exp.subject));
lowerCriteria = zeros(1, length(exp.subject));
for i = 1:length(exp.subject)
  block1RT = zeros(1, length(exp.subject(i).block(1).cycle) * length(exp.subject(i).block(1).cycle(1).trial));

  for j = 1:length(exp.subject(i).block(1).cycle)
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
        if exp.subject(i).block(1).cycle(j).trial(k).rt ~= 0
          block1RT(block1Count) = exp.subject(i).block(1).cycle(j).trial(k).rt;
        end
      end
      block1Count = block1Count + 1;
    end
  end
  block1RT = block1RT(block1RT > 0);

  subjectRT{i} = block1RT;

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
end


id = zeros(1, length(exp.subject));
dv = zeros(1, length(exp.subject));

for i = 1:length(exp.subject)
  id(i) = str2double(exp.subject(i).Id);

  nonShiftCorrectCount = 0;
  shiftCorrectCount = 0;
  nonShiftRT = 0;
  shiftRT = 0;
  
  cycleDv = zeros(1, length(exp.subject(i).block(1).cycle));
  for j = 1:length(exp.subject(i).block(1).cycle)
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      if exp.subject(i).block(1).cycle(j).trial(k).rt ~= 0
        if strcmp(exp.subject(i).block(1).cycle(j).trial(k).accuracy, 'Y')
          remain = regexprep(exp.subject(i).block(1).cycle(j).trial(k).targetFilename, '.jpg', '');
          target = textscan(char(remain), '%s', 'delimiter', '-');
          globalTarget = regexprep(target{1}{1}, 'G_', '');
          localTarget = regexprep(target{1}{2}, 'L_', '');
          if strcmp(globalTarget, localTarget)
            nonShiftCorrectCount = nonShiftCorrectCount + 1;
            nonShiftRT = nonShiftRT + exp.subject(i).block(1).cycle(j).trial(k).rt;
          else
            shiftCorrectCount = shiftCorrectCount + 1;
            shiftRT = shiftRT + exp.subject(i).block(1).cycle(j).trial(k).rt;
          end
        end
      end
    end
    cycleDv(j) = (shiftRT / shiftCorrectCount) - (nonShiftRT / nonShiftCorrectCount);
  end

  dv(i) = sum(cycleDv) / length(exp.subject(i).block(1).cycle);
end