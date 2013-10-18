function rt = doTrials(parms, windowPtr, pahandle, stimuli, nCycles, nTrials)

rt = 1:nCycles * nTrials;

spaceKey = KbName('SPACE');

% Display ready:
showCenteredMessage(windowPtr, parms.readyMsg, parms.foreColor);
getResponseRT(spaceKey);

count = 1;
for iCycle = 1:nCycles
  for jTrial = 1:nTrials
    
    % Preallocate an internal audio recording buffer with a generous capacity
    % of 5 seconds:
    PsychPortAudio('GetAudioData', pahandle, 5);

    [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, parms.fixationMsg, parms.foreColor);
    Screen('Flip', windowPtr, stimulusOnset + parms.fixationDuration);

    word = stimuli{1, count};
    color = stimuli{2, count};
    
    % Start audio capture immediately and wait for the capture to start.
    % We set the number of 'repetitions' to zero, i.e. record until recording
    % is manually stopped.
    PsychPortAudio('Start', pahandle, 0, 0, 1);

    [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, word, color);
    
    % Wait in a polling loop until some sound event of sufficient loudness
    % is captured:
    level = 0;

    % Repeat as long as below trigger-threshold:
    while level < parms.triggerLevel
      % Fetch current audiodata:
      [audiodata, absrecposition, overflow, cstarttime] = PsychPortAudio('GetAudioData', pahandle);
      
      % Compute maximum signal amplitude in this chunk of data:
      if ~isempty(audiodata)
        level = max(abs(audiodata(1, :)));
      else
        level = 0;
      end
        
      % Below trigger-threshold?
      if level < parms.triggerLevel
        % Wait for five milliseconds before next scan:
        WaitSecs(0.005);
      end
    end

    % OK, last fetched chunk was above threshold!
    % Find exact location of first above threshold sample.
    idx = find(abs(audiodata(1, :)) >= parms.triggerLevel, 1);

    % Compute absolute event time:
    voiceOnset = cstarttime + ((absrecposition + idx - 1) / parms.frequency);
    
    % Stop sound capture:
    PsychPortAudio('Stop', pahandle);
    
    % Fetch all remaining audio data out of the buffer - Needs to be empty
    % before next trial:
    PsychPortAudio('GetAudioData', pahandle); 

    rt(count) = (voiceOnset - stimulusOnset) * 1000;

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