function cleanData

oldDir = pwd;
cd('..');
addpath(strcat(pwd, filesep, 'lib'));

[nTasks taskNames] = getTaskNames('task');

for i = 1:nTasks
  cd(taskNames{i});
  delete('./data/*.mat');
  delete('./data/*.txt');
  cd('..');
end

cd(oldDir);

disp('Clean up!');