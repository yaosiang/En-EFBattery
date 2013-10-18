function changePtbVersion(ptbVersion)

%
% Very important!!!
%
% You have to setup correct path of each PTB version.
pathOfPTB2 = 'C:\Documents and Settings\xxx\My Documents\MATLAB\toolbox\Psychtoolbox2';
pathOfPTB3 = 'C:\Documents and Settings\xxx\My Documents\MATLAB\toolbox\Psychtoolbox';

% Make sure version input is numeric.
if ~isnumeric(ptbVersion)
  disp('Invalid input!');
  disp('Aborted');
  return;
end

% Check version of MATLAB.
isPostR2007a = false;
if  ~isempty(strfind(version, '2007')) || ...
    ~isempty(strfind(version, '2008')) || ...
    ~isempty(strfind(version, '2009'))
  isPostR2007a = true;
end

% Get current path and path separator.
currentPath = path;
currentPathSeparator = pathsep;

% Remove all PTB path.
remain = currentPath;
while true
  [str, remain] = strtok(remain, currentPathSeparator);
  if isempty(str)
    break;
  else
    if strcmp(str, strcat(pathOfPTB2, strcat(filesep, 'PsychBasic')))
      rmpath(genpath(pathOfPTB2));
      break;
    end
    if strcmp(str, strcat(pathOfPTB3, strcat(filesep, 'PsychBasic')))
      rmpath(RemoveSVNPaths(genpath(pathOfPTB3)));
      break;
    end
  end
end

ptb2 = false;
ptb3 = false;
switch ptbVersion
  case 2
    ptb2 = true;
  case 3
    ptb3 = true;
  otherwise
	fprintf('\n');
    disp('Wrong version! Set PTB version to 3.');
    ptb3 = true;
end

if ptb2
  fprintf('\n');
  disp('If you change PTB-3 to PTB-2.');
  disp('You might see warning message like some folder not found in the path');
  disp('It is OK!');
  fprintf('\n');
  addpath(genpath(pathOfPTB2));
  disp('Change to PTB-2!');
  fprintf('\n');
end

if ptb3
  addpath(genpath(pathOfPTB3));
  rmpath(strcat(pathOfPTB3, strcat(filesep, 'PsychBasic\MatlabWindowsFilesR2007a\')));
  rmpath(strcat(pathOfPTB3, strcat(filesep, 'PsychBasic\MatlabWindowsFilesR11\')));

  % According to PsychtoolboxPostInstallRoutine, it seems that we have to
  % detect MATLAB version on Windows platform. Because MatlabWindowsFilesR2007a 
  % and MatlabWindowsFilesR11 have different 'mex' implementation. We
  % can not have both folders in the path.
  if isPostR2007a
    addpath(strcat(pathOfPTB3, strcat(filesep, 'PsychBasic\MatlabWindowsFilesR2007a\')));
  else
    addpath(strcat(pathOfPTB3, strcat(filesep, 'PsychBasic\MatlabWindowsFilesR11\')));
  end

  path(RemoveSVNPaths);
  fprintf('\n');
  disp('Change to PTB-3!');
  fprintf('\n');
end

rehash pathreset;
rehash toolboxreset;
savepath;

% Mex testing.
clear WaitSecs;
WaitSecs(0.1);