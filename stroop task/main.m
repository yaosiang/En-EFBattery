function main(windowPtr)

beginTime = datestr(now);

isStandalone = true;
if exist('windowPtr', 'var')
    isStandalone = false;
end

if isStandalone
    oldDir = pwd;
    cd('..');
    addpath(strcat(pwd, filesep, 'lib'));
    addpath(strcat(pwd, filesep, 'util'));
    cd(oldDir);
end

% Get experimental parameters:
parms = getParameters;

if isStandalone
    parms.subjectId = getSubjectId;
else
    parms.subjectId = getExistId;
    parms.triggerLevel = getExistTriggerLevel;
end

if (parms.subjectId == -1) || (parms.triggerLevel == -1)
    disp('Experiment aborted.');
    return;
end

% Check for OpenGL compatibility, abort otherwise:
AssertOpenGL;

% Reseed the random-number generator for each experiment:
rng('shuffle', 'twister');

% Make sure keyboard mapping is the same on all supported operating systems
% Apple MacOS/X, MS-Windows, and GNU/Linux:
KbName('UnifyKeyNames');

% Predefine key name:
spaceKey = KbName('SPACE');

% Define and validate the filename of result file:
resultFilename = strcat('subject_', num2str(parms.subjectId), '.txt');
isFileValid = checkFileExist(resultFilename);
assert(isFileValid, 'Subject was duplicated!');


try
    % Beginning of experiment
    
    % Get screenNumber of stimulation display. We choose the display with
    % the maximum index, which is usually the right one:
    screens = Screen('Screens');
    screenNumber = max(screens);
    
    % Change the sreen resolution to 1024 * 768 px:
    if isStandalone
        resolution = NearestResolution(screenNumber, ...
            parms.screenWidth, ...
            parms.screenHeight);
        oldResolution = SetResolution(screenNumber, resolution);
    end
    
    % Hide the mouse cursor:
    HideCursor;
    
    % Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
    % they are loaded and ready when we need them - without delays
    % in the wrong moment:
    KbCheck;
    WaitSecs(0.1);
    GetSecs;
    
    % Open a double buffered fullscreen window on the stimulation screen
    % 'screenNumber' and choose/draw a gray background. 'windowPtr' is the
    % handle used to direct all drawing commands to that window - the "Name"
    % of the window. 'rect' is a rectangle defining the size of the window:
    if isStandalone
        [windowPtr, ~] = Screen('OpenWindow', screenNumber, parms.backColor);
    end
    
    % Set priority for script execution to realtime priority:
    if isStandalone
        priorityLevel = MaxPriority(windowPtr);
        Priority(priorityLevel);
    end
    
    if isStandalone
        parms.triggerLevel = getTriggerLevel(windowPtr);
    end
    
    % Perform basic initialization of the sound driver, initialize for
    % low-latency, high timing precision mode:
    InitializePsychSound(1);
    
    % Open the default audio device [], with mode 2 (== Only audio capture),
    % and a required latencyclass of two 2 == low-latency mode, as well as
    % a frequency of 44100 Hz and 2 sound channels for stereo capture. We also
    % set the required latency to a pretty high 20 msecs. Why? Because we don't
    % actually need low-latency here, we only need low-latency mode of
    % operation so we get maximum timing precision -- Therefore we request
    % low-latency mode, but loosen our requirement to 20 msecs.
    pahandle = PsychPortAudio('Open', [], 2, 2, parms.frequency, 2, [], 0.02);
    
    % Set text size:
    Screen('TextSize', windowPtr, parms.textSize);
    
    % Show check equipment message:
    showCenteredMessage(windowPtr, parms.checkEquipmentMsg, parms.foreColor);
    getResponseRT(spaceKey);
    
    % Show question message:
    showCenteredMessage(windowPtr, parms.questionMsg, parms.foreColor);
    getResponseRT(spaceKey);
    
    result = cell(1, 2);
    
    tic
    % Show instruction message:
    showInstruction(windowPtr, 1, 1, parms.foreColor);
    % Do the experiment:
    result{1} = doBlock('Practice', windowPtr, pahandle, parms);
    % Show question message again:
    showCenteredMessage(windowPtr, parms.question2Msg, parms.foreColor);
    getResponseRT(spaceKey);
    result{2} = doBlock('Experiment', windowPtr, pahandle, parms);
    rt = toc;
    
    if isStandalone
        % Show thank you message:
        showCenteredMessage(windowPtr, parms.thanksMsg, parms.foreColor);
        KbWait([], 2);
        
        % Show escape message:
        showCenteredMessage(windowPtr, parms.escapeMsg, parms.foreColor);
        KbWait([], 2);
    end
    
    endTime = datestr(now);
    
    % Generate result file:
    fid = fopen(strcat('data', filesep, resultFilename), 'wt');
    
    % Insert subject information to result file:
    fprintf(fid, 'SubjectID: %d\n', parms.subjectId);
    fprintf(fid, 'ExpComputer: %s', getComputerName);
    fprintf(fid, 'ExpStartTime: %s\n', beginTime);
    fprintf(fid, 'ExpEndTime: %s\n', endTime);
    fprintf(fid, 'ExpElapsedTime: %f Secs\n\n', rt);
    
    % Generate result file header:
    str = textscan(parms.header, '%s', 'delimiter', ' ');
    for i = 1:length(str{1})
        fprintf(fid, '%s\t', str{1}{i});
    end
    fprintf(fid, '%s\t', 'Accuracy');
    fprintf(fid, '\n');
    
    % Insert result to result file:
    for i = 1:length(result)
        for j = 1:length(result{i}{1})
            fprintf(fid, '%s\t', result{i}{1}{j});
            fprintf(fid, '%d\t', result{i}{2}{j});
            fprintf(fid, '%d\t', result{i}{3}{j});
            fprintf(fid, '%s\t', result{i}{4}{j});
            fprintf(fid, '%s\t', result{i}{5}{j});
            fprintf(fid, '%f\n', result{i}{6}{j});
        end
    end
    fclose(fid);
    
    % Save result as a MAT file:
    filename = strcat('data', filesep, 'result_', num2str(parms.subjectId), '.mat');
    save(filename);
    
    % Close the audio device:
    PsychPortAudio('Close', pahandle);
    
    % Cleanup at end of experiment - Close window, show mouse cursor, close
    % result file, switch Matlab/Octave back to priority 0 -- normal
    % priority:
    if isStandalone
        Screen('CloseAll');
        SetResolution(screenNumber, oldResolution);
        ShowCursor;
        Priority(0);
    end
    
    % End of experiment:
    return;
catch
    % Do same cleanup as at the end of a regular session...
    PsychPortAudio('Close', pahandle);
    Screen('CloseAll');
    SetResolution(screenNumber, oldResolution);
    ShowCursor;
    Priority(0);
    fclose('all');
    
    % Output the error message that describes the error:
    ple(psychlasterror);
end