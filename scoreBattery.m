% Clear all variables, figures and MATLAB console:
clc; clear all; close all;

addpath(strcat(pwd, filesep, 'lib'));
addpath(strcat(pwd, filesep, 'util'));

% Get number and name of all tasks:
[nTasks, taskNames] = getTaskNames('task');

subjectIdData = cell(1, nTasks);
dvData = cell(1, nTasks);
transformedDvData = cell(1, nTasks);

existSubjectId = [];

for i = 1:nTasks
  cd(taskNames{i});
  if exist('scoreData.m', 'file')
    if ~strcmp(taskNames{i}, 'stroop task') && ~strcmp(taskNames{i}, 'local-global task')
      if strcmp(taskNames{i}, 'stroop task') || strcmp(taskNames{i}, 'number-letter task') || ...
        strcmp(taskNames{i}, 'local-global task') || strcmp(taskNames{i}, 'plus-minus task')
        [id, dv] = scoreData;
      else
        [id, dv, tDv] = scoreData;
        transformedDvData{i} = tDv';
      end
      subjectIdData{i} = id';
      dvData{i} = dv';

      existSubjectId = union(existSubjectId, subjectIdData{i});
    end
  end
  cd('..');
end


if exist('etbExpData.txt', 'file')
  response = questdlg('The file etbExpData.txt already exists. Do you want to overwrite it?', ...
    'Duplicate Warning', 'Cancel', 'OK', 'Cancel');
  if strcmp(response, 'Cancel')
    error('Experiment aborted.');
  end
end

fid = fopen('etbExpData.txt', 'wt');
fprintf('ID\t\tPM\t\tNL\t\tKT\t\tTM\t\tLM\t\tAT\t\tSS\n');
fprintf(fid, 'ID\tPM\tNL\tKT\tTM\tLM\tAT\tSS\n');

for i = 1:length(existSubjectId)
  at      = zeros(1, length(existSubjectId));
  tAt     = zeros(1, length(existSubjectId));
  kt      = zeros(1, length(existSubjectId));
  tKt     = zeros(1, length(existSubjectId));
  lm      = zeros(1, length(existSubjectId));
  tLm     = zeros(1, length(existSubjectId));
  nl      = zeros(1, length(existSubjectId));
  pm      = zeros(1, length(existSubjectId));
  ss      = zeros(1, length(existSubjectId));
  tSs     = zeros(1, length(existSubjectId));
  tm      = zeros(1, length(existSubjectId));
  tTm     = zeros(1, length(existSubjectId));

  existValue = false;
  for j = 1:length(subjectIdData{1})
    if existSubjectId(i) == subjectIdData{1}(j)
      at(i) = dvData{1}(j);
      tAt(i) = transformedDvData{1}(j);
      existValue = true;
      break;
    end
  end
  if ~existValue
    at(i) = -9999;
	tAt(i) = -9999;
  end
  
  existValue = false;
  for j = 1:length(subjectIdData{2})
    if existSubjectId(i) == subjectIdData{2}(j)
      kt(i)  = dvData{2}(j);
      tKt(i) = transformedDvData{2}(j);
      existValue = true;
      break;
    end
  end
  if ~existValue
    kt(i) = -9999;
    tKt(i) = -9999;
  end
  
  existValue = false;
  for j = 1:length(subjectIdData{3})
    if existSubjectId(i) == subjectIdData{3}(j)
      lm(i)  = dvData{3}(j);      
      tLm(i) = transformedDvData{3}(j);
      existValue = true;
      break;
    end
  end
  if ~existValue
    lm(i) = -9999;
    tLm(i) = -9999;
  end

  existValue = false;
  for j = 1:length(subjectIdData{5})
    if existSubjectId(i) == subjectIdData{5}(j)
      nl(i) = dvData{5}(j);
      existValue = true;
      break;
    end
  end
  if ~existValue
    nl(i) = -9999;
  end

  existValue = false;
  for j = 1:length(subjectIdData{6})
    if existSubjectId(i) == subjectIdData{6}(j)
      pm(i) = dvData{6}(j);
      existValue = true;
      break;
    end
  end
  if ~existValue
    pm(i) = -9999;
  end

  existValue = false;
  for j = 1:length(subjectIdData{7})
    if existSubjectId(i) == subjectIdData{7}(j)
      ss(i)  = dvData{7}(j);
      tSs(i) = transformedDvData{7}(j);
      existValue = true;
      break;
    end
  end
  if ~existValue
    ss(i) = -9999;
    tSs(i) = -9999;
  end

  existValue = false;
  for j = 1:length(subjectIdData{9})
    if existSubjectId(i) == subjectIdData{9}(j)
      tm(i)  = dvData{9}(j);
      tTm(i) = transformedDvData{9}(j);
      existValue = true;
      break;
    end
  end
  if ~existValue
    tm(i) = -9999;
    tTm(i) = -9999;
  end

  fprintf('%d\t\t%6.4f\t\t%6.4f\t\t%6.4f\t\t%6.4f\t\t%6.4f\t\t%6.4f\t\t%6.4f\n', ...
    existSubjectId(i), pm(i), nl(i), kt(i), tm(i), lm(i), at(i), ss(i));
  fprintf(fid, '%d\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\t%6.4f\n', ...
    existSubjectId(i), pm(i), nl(i), kt(i), tm(i), lm(i), at(i), ss(i));
end
fclose(fid);