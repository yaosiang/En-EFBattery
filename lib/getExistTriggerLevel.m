function triggerLevel = getExistTriggerLevel

currentDir = pwd;
cd('..')
if exist('triggerLevel.mat', 'file')
  subject = load('triggerLevel.mat');
  triggerLevel = subject.triggerLevel;
else
  triggerLevel = -1;
end
cd(currentDir);