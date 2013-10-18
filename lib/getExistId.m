function id = getExistId

currentDir = pwd;
cd('..')
if exist('subjectId.mat', 'file')
  subject = load('subjectId.mat');
  id = subject.id;
else
  id = -1;
end
cd(currentDir);