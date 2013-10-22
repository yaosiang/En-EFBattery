function [parms, response, rt, acc] = ...
    doTrials(parms, windowPtr, isBuild, stimuli, nCycles, nTrials)

% Predefine key name:
animalKey = KbName('LeftArrow');
nonAnimalKey = KbName('RightArrow');
spaceKey = KbName('SPACE');
responseKeySet = [animalKey, nonAnimalKey];

response = cell(1, nCycles * nTrials);
rt = 1:nCycles * nTrials;
acc = cell(1, nCycles * nTrials);

buildBlockRT = zeros(1, nCycles * nTrials);
if ~isBuild
    parms.stopSignalOnsetTime = parms.buildBlockMeanRT - parms.stopSignalLatency;    
%     disp('------');
%     disp(strcat('Build Block Mean RT: ', num2str(parms.buildBlockMeanRT)));
%     disp(strcat('Stop Signal Onset Time: ', num2str(parms.stopSignalOnsetTime)));    
%     disp('------');
end

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

    [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, parms.fixationMsg, parms.foreColor);
    Screen('Flip', windowPtr, stimulusOnset + parms.fixationDuration);

    words = stimuli{count}(1:length(stimuli{count})-1);
    isStop = stimuli{count}(length(stimuli{count}));

    if isBuild
      [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, words, parms.foreColor);
      [response{count}, rt(count)] = getTimeoutResponseRT(responseKeySet, parms.targetDuration, stimulusOnset);
      response{count} = KbName(response{count});
      if isempty(response{count})
       response{count} = 'TimeOut';
      end
    else
      if char(isStop) == 'N'
        [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, words, parms.foreColor);
        [response{count}, rt(count)] = getTimeoutResponseRT(responseKeySet, parms.targetDuration, stimulusOnset);
        response{count} = KbName(response{count});
        if isempty(response{count})
          response{count} = 'TimeOut';
        end
      else
        isSoundPlayed = false;
        responseTime = 0;

        [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, words, parms.foreColor);

        while KbCheck; end
        while GetSecs < (stimulusOnset + (parms.targetDuration - parms.fixationDuration))
          [keyIsDown, secs, keyCode] = KbCheck;
          if GetSecs <= ((stimulusOnset + parms.stopSignalOnsetTime) + 0.005) && ...
             GetSecs >= ((stimulusOnset + parms.stopSignalOnsetTime) - 0.005)

            % Play sound
            if ~isSoundPlayed
              PsychPortAudio('FillBuffer', pahandle, parms.beep);
  	          PsychPortAudio('Start', pahandle, 1, 0, 1);
		      PsychPortAudio('Stop', pahandle);
              isSoundPlayed = true;
            end

          end

          if keyIsDown
            c = find(keyCode);
            if length(c) == 1
              if ismember(c, KbName('ESCAPE'))
                PsychPortAudio('Close', pahandle);
                ShowCursor;
                sca;
                return;
              end
              if ismember(c, responseKeySet)
                responseTime = secs;
              end
            end
            while KbCheck; end
          end
        end

        if responseTime ~= 0
          rt(count) = responseTime - stimulusOnset;
          response{count} = KbName(c);
        else
          rt(count) = parms.targetDuration;
          response{count} = 'Null';
        end
      end
    end

    % Calculate accuracy:
    acc{count} = isCorrect(parms, responseKeySet, stimuli{count}, response{count});

    if isBuild
      if strcmp(acc{count}, 'Y')
        buildBlockRT(count) = rt(count);        
        parms.buildBlockMeanRT = sum(buildBlockRT(buildBlockRT > 0)) / length(find(buildBlockRT > 0));
      end
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