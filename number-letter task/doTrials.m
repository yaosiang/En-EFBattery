function [response, rt, acc] = doTrials(parms, windowPtr, ...
    stimuli, isClockwise, isTopQuadrant, nCycles, nTrials)

rect = Screen('Rect', windowPtr);
centerWidth = rect(3) / 2;
centerHeight = rect(4) / 2;
boxes = [centerWidth,        centerWidth  - 210, centerWidth  - 210,  centerWidth;
         centerHeight - 210, centerHeight - 210, centerHeight,        centerHeight;
         centerWidth  + 210, centerWidth,        centerWidth,         centerWidth + 210;
         centerHeight,       centerHeight,       centerHeight + 210,  centerHeight + 210];

% Predefine key name:
evenKey = KbName('a');
oddKey = KbName('k');
vowelKey = KbName('s');
consonantKey = KbName('l');
spaceKey = KbName('SPACE');
responseKeySet = [evenKey, oddKey, vowelKey, consonantKey];
topQuadrantKeySet    = [evenKey, oddKey];
bottomQuadrantKeySet = [vowelKey, consonantKey];

Screen('TextFont', windowPtr, 'Courier New Bold');

response = cell(1, nCycles * nTrials);
rt = 1:nCycles * nTrials;
acc = cell(1, nCycles * nTrials);

% Display ready:
showCenteredMessage(windowPtr, parms.readyMsg, parms.foreColor);
getResponseRT(spaceKey);

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

    if count == 1
      Screen('FrameRect', windowPtr, parms.foreColor, boxes);
      [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
      Screen('Flip', windowPtr, stimulusOnset + 2);
    end

    if isTopQuadrant
      if stimuli{count}(3) == '1'
        % Q1
        DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
            (centerWidth + (210 / 2 - 36 / 2)), (centerHeight - 210 + (210 / 2 - 20)), ...
            parms.foreColor);
      else
        % Q2
        DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
            (centerWidth - 210 + (210 / 2 - 36 / 2)), (centerHeight - 210 + (210 / 2 - 20)), ...
            parms.foreColor);
      end
    end

    if ~isTopQuadrant && ~isClockwise
      if stimuli{count}(3) == '3'
        % Q3
        DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
            (centerWidth - 210 + (210 / 2 - 36 / 2)), (centerHeight + (210 / 2 - 20)), ...
            parms.foreColor);
      else
        % Q4
        DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
            (centerWidth + (210 / 2 - 36 / 2)), (centerHeight + (210 / 2 - 20)), ...
            parms.foreColor);
      end
    end

    if isClockwise
      switch stimuli{count}(3)
        case '1'
          DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
              (centerWidth + (210 / 2 - 36 / 2)), (centerHeight - 210 + (210 / 2 - 20)), ...
              parms.foreColor);
        case '2'
          DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
              (centerWidth-210 + (210 / 2 - 36 / 2)), (centerHeight - 210 + (210 / 2 - 20)), ...
              parms.foreColor);
        case '3'
          DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
              (centerWidth-210 + (210/2-36/2)), (centerHeight + (210/2-20)), ...
              parms.foreColor);
        case '4'
          DrawFormattedText(windowPtr, stimuli{count}(1:1 + 1), ...
              (centerWidth + (210 / 2 - 36 / 2)), (centerHeight + (210 / 2 - 20)), ...
              parms.foreColor);
      end
    end

    Screen('FrameRect', windowPtr, parms.foreColor, boxes);
    Screen('DrawingFinished', windowPtr);
    [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);

    % Get subject response and rt:
    if isTopQuadrant
      [response{count}, rt(count)] = getTimeoutResponseRT(topQuadrantKeySet, parms.timeOut, stimulusOnset);
    end
    if ~isTopQuadrant && ~isClockwise
      [response{count}, rt(count)] = getTimeoutResponseRT(bottomQuadrantKeySet, parms.timeOut, stimulusOnset);
    end    
    if isClockwise
      switch stimuli{count}(3)
        case '1'
          [response{count}, rt(count)] = getTimeoutResponseRT(topQuadrantKeySet, parms.timeOut, stimulusOnset);   
        case '2'
          [response{count}, rt(count)] = getTimeoutResponseRT(topQuadrantKeySet, parms.timeOut, stimulusOnset);    
        case '3'
          [response{count}, rt(count)] = getTimeoutResponseRT(bottomQuadrantKeySet, parms.timeOut, stimulusOnset);      
        case '4'
          [response{count}, rt(count)] = getTimeoutResponseRT(bottomQuadrantKeySet, parms.timeOut, stimulusOnset);      
      end
    end

    if isempty(response{count})
      response{count} = 'n';
    else
      response{count} = KbName(response{count});
    end

    % Calculate accuracy:
    acc{count} = isCorrect(parms, responseKeySet, stimuli{count}, response{count});

    Screen('FrameRect', windowPtr, parms.foreColor, boxes);
    [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);

    % Feedback:
    if acc{count} == 'Y';
      Screen('Flip', windowPtr, stimulusOnset + parms.ITI);
    else
      Screen('Flip', windowPtr, stimulusOnset + parms.errorResponseITI);
      %sound(parms.beep);
      PsychPortAudio('FillBuffer', pahandle, parms.beep);
  	  PsychPortAudio('Start', pahandle, 1, 0, 1);
		  PsychPortAudio('Stop', pahandle);
    end

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