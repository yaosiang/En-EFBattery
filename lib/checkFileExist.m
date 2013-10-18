function isFileValid = checkFileExist(filename)

pattern = strcat('subject_');
remain = regexprep(filename, pattern, '');
pattern = '.txt';
regexprep(remain, pattern, '');
id = str2double(regexprep(remain, pattern, ''));

isFileValid = true;

% Check for existing result file to prevent accidentally overwriting
% file from a previous subject/session (except for subject id = 999):
if id ~= 999 && exist(strcat('data', filesep, filename), 'file')
  response = questdlg({['The file ' filename ' already exists.']; ...
    'Do you want to overwrite it?'}, 'Duplicate Warning', ...
    'Cancel', 'OK', 'Cancel');

  % Abort experiment if overwriting was not confirmed:
  if strcmp(response, 'Cancel')
    isFileValid = false;
  end
end