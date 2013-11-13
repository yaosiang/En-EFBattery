function exp = getRawData

% Input Data Section:
%
files = FileFromFolder('data');

% Read data file:
count = 1;
for i = 1:length(files)
    [pathstr, name, ext] = fileparts(files(i).name);
    
    if strcmp(ext, '.txt')
        filename = strcat('data', filesep, files(i).name);
        fid = fopen(filename, 'rt');
        
        isInfoSection = true;
        isDataSection = false;
        
        while true
            line = fgetl(fid);
            
            if ~ischar(line)
                break;
            else
                if isempty(line)
                    isInfoSection = false;
                elseif regexpi(line, 'Block	Cycle	Trial	Target	Response	RT	Accuracy');
                    isInfoSection = false;
                else
                    if ~isInfoSection
                        isDataSection = true;
                    end
                end
                
                % Extract information of each subject:
                if isInfoSection
                    if regexpi(line, 'SubjectID')
                        exp.subject(count).Id = strtrim(regexprep(line, 'SubjectID: ', ''));
                    end
                    if regexpi(line, 'ExpComputer')
                        exp.subject(count).computerName = strtrim(regexprep(line, 'ExpComputer: ', ''));
                    end
                    if regexpi(line, 'ExpStartTime')
                        exp.subject(count).startTime = strtrim(regexprep(line, 'ExpStartTime: ', ''));
                    end
                    if regexpi(line, 'ExpEndTime')
                        exp.subject(count).endTime = strtrim(regexprep(line, 'ExpEndTime: ', ''));
                    end
                    if regexpi(line, 'ExpElapsedTime')
                        exp.subject(count).timeCost = strtrim(regexprep(line, 'ExpElapsedTime: ', ''));
                    end
                end
                
                % Extract raw data of each subject:
                if isDataSection
                    [blockName, cycleNo, trialNo, target, response, rt, accuracy] = strread(line, '%s %d %d %s %s %f %f');
                    
                    if strcmp(blockName, 'ExpB')
                        blockNo = 1;
                        exp.subject(count).block(blockNo).name = blockName;
                        exp.subject(count).block(blockNo).cycle(cycleNo).trial(trialNo).target = target;
                        exp.subject(count).block(blockNo).cycle(cycleNo).trial(trialNo).response = response;
                        exp.subject(count).block(blockNo).cycle(cycleNo).trial(trialNo).rt = rt;
                        exp.subject(count).block(blockNo).cycle(cycleNo).trial(trialNo).accuracy = accuracy;
                    end
                    
                end
            end
        end
        fclose(fid);
        count = count + 1;
    end
end