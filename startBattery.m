% Clear all variables, figures and MATLAB console:
clc; clear all; close all;

addpath(strcat(pwd, filesep, 'lib'));
addpath(strcat(pwd, filesep, 'util'));

% Get number and name of all tasks:
[nTasks, taskNames] = getTaskNames('task');

% Show menu:
fprintf('Please select task:\n\n');
fprintf('\tEnter task number you want to execute. Seperate task number by comma.\n');
fprintf('\tExample: enter 1,2,5 for task 1, task 2, and task 5.\n\n');
fprintf('\t:::::::::: Menu ::::::::::\n');
for i = 1:length(taskNames)
    fprintf('\t%2d. %s\n', i, taskNames{i});
end
fprintf('\t%2d. %s\n', (length(taskNames) + 1), 'non-microphone tasks');
fprintf('\t%2d. %s\n', (length(taskNames) + 2), 'all tasks');
fprintf('\t::::::::::::::::::::::::::\n\n');
responseString = input('>>> ', 's');

% Check input format:
str = textscan(responseString, '%f', 'delimiter', ',');
for i = 1:length(str{1})
    if ~isnan(str{1}(i))
        assert(rem(str{1}(i), 1) == 0, 'Task number must be an integer.');
        assert(str{1}(i) <= (length(taskNames) + 2) , 'Task number is invalid.');
        assert(str{1}(i) > 0 , 'Task number is invalid.');
    end
end
str{1} = unique(str{1});

% Generate task name list:
choosedTasks = '';
if isempty(find(str{1} == (length(taskNames) + 1), 1)) && ...
        isempty(find(str{1} == (length(taskNames) + 2), 1))
    for i = 1:length(str{1})
        if ~isnan(str{1}(i))
            choosedTasks = [choosedTasks ',' taskNames{str{1}(i)}];
        end
    end
    choosedTasks = choosedTasks(2:end);
    choosedTasks = textscan(choosedTasks, '%s', 'delimiter', ',');
    nTasks = length(choosedTasks{1});
end

if find(str{1} == (length(taskNames) + 1), 1)
    for i = 1:length(taskNames)
        if ~strcmp(taskNames{i}, 'local-global task') && ...
                ~strcmp(taskNames{i}, 'stroop task')
            choosedTasks = [choosedTasks ',' taskNames{i}];
        end
    end
    choosedTasks = choosedTasks(2:end);
    choosedTasks = textscan(choosedTasks, '%s', 'delimiter', ',');
    nTasks = length(choosedTasks{1});
end

% Get subject id:
id = getSubjectId;
isIdValid = true;
if id == -1; isIdValid = false; end
assert(isIdValid, 'Subject id is invalid!');

% Create a MAT file that contains subject id:
save('subjectId.mat', 'id');

% Check for OpenGL compatibility, abort otherwise:
AssertOpenGL;

% Reseed the random-number generator for each experiment:
rng('shuffle', 'twister');

% Make sure keyboard mapping is the same on all supported operating systems
% Apple MacOS/X, MS-Windows, and GNU/Linux:
KbName('UnifyKeyNames');


try
    % Beginning of battery
    
    % Get screenNumber of stimulation display. We choose the display with
    % the maximum index, which is usually the right one:
    screens = Screen('Screens');
    screenNumber = max(screens);
    
    % Hide the mouse cursor:
    HideCursor;
    
    % Do dummy calls to GetSecs, WaitSecs, KbCheck to make sure
    % they are loaded and ready when we need them - without delays
    % in the wrong moment:
    KbCheck;
    WaitSecs(0.1);
    GetSecs;
    
    resolution = NearestResolution(screenNumber, 1024, 768);
    oldResolution = SetResolution(screenNumber, resolution);
    
    % Open a double buffered fullscreen window on the stimulation screen
    % 'screenNumber' and choose/draw a gray background. 'windowPtr' is the
    % handle used to direct all drawing commands to that window - the "Name"
    % of the window. 'rect' is a rectangle defining the size of the window:
    [windowPtr, rect] = Screen('OpenWindow', screenNumber, BlackIndex(screenNumber));
    
    % Set priority for script execution to realtime priority:
    priorityLevel = MaxPriority(windowPtr);
    Priority(priorityLevel);
    
    % Set text size:
    Screen('TextSize', windowPtr, 24);
    
    square = genLatinSquare(nTasks);
    [nRows, nColumns] = size(square);
    sequenceIndex = rem(id, nRows);
    if sequenceIndex == 0; sequenceIndex = nRows; end
    sequence = square(sequenceIndex, :);
    
    % Show welcome message:
    msg = 'Welcome! Press any key to continue.';
    showCenteredMessage(windowPtr, msg, WhiteIndex(screenNumber));
    KbWait([], 2);
    
    isMicrophoneRelated = false;
    if ~isempty(choosedTasks)
        if ~isempty(find(strcmp(choosedTasks{1}, 'local-global task'), 1)) || ...
                ~isempty(find(strcmp(choosedTasks{1}, 'stroop task'), 1))
            isMicrophoneRelated = true;
        end
    else
        isMicrophoneRelated = true;
    end
    
    if isMicrophoneRelated
        triggerLevel = getTriggerLevel(windowPtr);
        % Create a MAT file that contains subject's trigger level:
        save('triggerLevel.mat', 'triggerLevel');
    end
    
    msg = ['Begin 1 / ', num2str(nTasks), ' Experiments. Press any key to continue.'];
    showCenteredMessage(windowPtr, msg, WhiteIndex(screenNumber));
    KbWait([], 2);
    
    isSkip = false;
    for i = 1:nTasks
        if isempty(choosedTasks); cd(taskNames{sequence(i)});        end
        if ~isempty(choosedTasks); cd(choosedTasks{1}{sequence(i)}); end
        
        if exist('main.m', 'file')
            if isSkip == false
                main(windowPtr);
            else
                showCenteredMessage(windowPtr, 'Skip Task! Press any key to continue.', WhiteIndex(screenNumber));
                KbWait([], 2);
                isSkip = false;
            end
        end
        cd('..');
        
        if i ~= nTasks
            msg = ['Begin ', num2str(i + 1), ' / ', num2str(nTasks), ' Experiments. Press [SPACE] to continue; [s] to skip!'];
            showCenteredMessage(windowPtr, msg, WhiteIndex(screenNumber));
            response = getResponseRT([KbName('SPACE'), KbName('s')]);
            if response == KbName('s')
                isSkip = true;
            end
        else
            msg = 'Thanks for your participation.\n\nPress any key to continue.';
            showCenteredMessage(windowPtr, msg, WhiteIndex(screenNumber));
            KbWait([], 2);
        end
    end
    
    msg = 'Call Researcher Please!';
    showCenteredMessage(windowPtr, msg, WhiteIndex(screenNumber));
    KbWait([], 2);
    
    delete('subjectId.mat');
    if isMicrophoneRelated
        delete('triggerLevel.mat');
    end
    
    % Cleanup at end of experiment - Close window, show mouse cursor, close
    % result file, switch Matlab/Octave back to priority 0 -- normal
    % priority:
    Screen('CloseAll');
    SetResolution(screenNumber, oldResolution);
    ShowCursor;
    Priority(0);
    
    % End of battery:
    return;
catch
    delete('subjectId.mat');
    if isMicrophoneRelated
        delete('triggerLevel.mat');
    end
    
    % Do same cleanup as at the end of a regular session...
    Screen('CloseAll');
    SetResolution(screenNumber, oldResolution);
    ShowCursor;
    Priority(0);
    
    % Output the error message that describes the error:
    ple(psychlasterror);
end