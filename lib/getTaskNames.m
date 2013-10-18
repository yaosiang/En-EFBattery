function [nTasks, taskNames] = getTaskNames(taskFolderPostfix)

% Get all folders in current folder:
folders = FolderFromFolder('.');

% Calculate task numbers:
taskFolderList = 1:length(folders);
for i = 1:length(folders)
  if regexpi(folders(i).name, [' ' taskFolderPostfix])
    taskFolderList(i) = 1;
  else
    taskFolderList(i) = 0;
  end
end
nTasks = length(find(taskFolderList));

% Get task names:
taskNames = cell(1, nTasks);
count = 1;
for i = 1:length(taskFolderList)
  if taskFolderList(i) == 1
    taskNames{count} = folders(i).name;
    count = count + 1;
  end
end