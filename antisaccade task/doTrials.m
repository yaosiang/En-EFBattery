function [response, rt, acc] = doTrials(parms, windowPtr, ...
    isResponseMapping, fixation, stimuli, nCycles, nTrials)

rect = Screen('Rect', windowPtr);
centerWidth = rect(3) / 2;
centerHeight = rect(4) / 2;

% Predefine key name:
bKey = KbName('1!');
pKey = KbName('2@');
rKey = KbName('3#');
spaceKey = KbName('SPACE');
responseKeySet = [bKey, pKey, rKey];

response = cell(1, nCycles * nTrials);
rt = 1:nCycles * nTrials;
acc = cell(1, nCycles * nTrials);

% Perform basic initialization of the sound driver:
InitializePsychSound;

% Open the default audio device [], with default mode [] (==Only playback),
% and a required latencyclass of zero 0 == no low-latency mode, as well as
% a frequency of freq and nrchannels sound channels.
% This returns a handle to the audio device:
pahandle = PsychPortAudio('Open', [], [], 0, 8192, 1);

count = 1;
for iCycle = 1:nCycles
    for jTrial = 1:nTrials
        
        % Display ready:
        showCenteredMessage(windowPtr, parms.readyMsg, parms.foreColor);
        getResponseRT(spaceKey);
        
        % 400 ms blank screen:
        [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
        Screen('Flip', windowPtr, stimulusOnset + 0.4);
        
        % Display fixation:
        DrawFormattedText(windowPtr, parms.fixationMsg, 'center', 'center', parms.foreColor);
        [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
        Screen('Flip', windowPtr, stimulusOnset + fixation(count));
        
        if isResponseMapping
            % 100 ms blank screen:
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + 0.1);
            
            % Display target:
            DrawFormattedText(windowPtr, stimuli{count}(1), 'center', 'center', parms.foreColor);
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + parms.targetDuration);
            
            % Display mask:
            DrawFormattedText(windowPtr, parms.maskMsg, 'center', 'center', parms.foreColor);
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + parms.maskDuration);
        end
        
        if ~isResponseMapping
            % 50 ms blank screen:
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + 0.05);
            
            % Display cue:
            if (stimuli{count}(2) == 'R')
                DrawFormattedText(windowPtr, parms.cueMsg, (centerWidth + 225), (centerHeight + 10), parms.foreColor);
            else
                DrawFormattedText(windowPtr, parms.cueMsg, (centerWidth - 225), (centerHeight + 10), parms.foreColor);
            end
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + parms.cueDruation);
            
            % 50 ms blank screen:
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + 0.05);
            
            % Display cue:
            if (stimuli{count}(2) == 'R')
                DrawFormattedText(windowPtr, parms.cueMsg, (centerWidth + 225), (centerHeight + 10), parms.foreColor);
            else
                DrawFormattedText(windowPtr, parms.cueMsg, (centerWidth - 225), (centerHeight + 10), parms.foreColor);
            end
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + parms.cueDruation);
            
            % 50 ms blank screen:
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + 0.05);
            
            % Display target:
            target = stimuli{count}(1);
            if (stimuli{count}(2) == 'R')
                DrawFormattedText(windowPtr, target, (centerWidth - 225), (centerHeight - 40), parms.foreColor);
            else
                DrawFormattedText(windowPtr, target, (centerWidth + 225), (centerHeight - 40), parms.foreColor);
            end
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + parms.targetDuration);
            
            % 50 ms blank screen:
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + 0.05);
            
            % Display mask:
            mask = parms.maskMsg;
            if (stimuli{count}(2) == 'R')
                DrawFormattedText(windowPtr, mask, (centerWidth - 225), (centerHeight - 40), parms.foreColor);
            else
                DrawFormattedText(windowPtr, mask, (centerWidth + 225), (centerHeight - 40), parms.foreColor);
            end
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
            Screen('Flip', windowPtr, stimulusOnset + parms.maskDuration);
        end
        
        % Display wait for response:
        [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, parms.waitForResponseMsg, parms.foreColor);
        
        % Get subject response and rt:
        [response{count}, rt(count)] = getResponseRT(responseKeySet, stimulusOnset);
        response{count} = KbName(response{count});
        
        % Get correct answer:
        switch stimuli{count}(1)
            case 'B'
                answerKey = bKey;
            case 'P'
                answerKey = pKey;
            case 'R'
                answerKey = rKey;
        end
        
        % Feedback:
        if KbName(response{count}) == answerKey
            acc{count} = 'Y';
        else
            acc{count} = 'N';
            PsychPortAudio('FillBuffer', pahandle, parms.beep);
            PsychPortAudio('Start', pahandle, 1, 0, 1);
            PsychPortAudio('Stop', pahandle);
        end
        
        [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
        Screen('Flip', windowPtr, stimulusOnset + parms.ITI);
        
        count = count + 1;
    end
    
    if iCycle < nCycles
        % Display break message:
        showCenteredMessage(windowPtr, parms.breakMsg, parms.foreColor);
        KbWait([], 2);
        WaitSecs(0.5);
    end
end

PsychPortAudio('Close', pahandle);