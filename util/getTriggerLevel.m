function triggerlevel = getTriggerLevel(windowPtr)

triggerlevel = 0.03;

% Predefine key name:
upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
spaceKey = KbName('SPACE');
responseKeySet = [upKey, downKey, spaceKey];

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
%
% This returns a handle to the audio device:
freq = 44100;
pahandle = PsychPortAudio('Open', [], 2, 2, freq, 2, [], 0.02);

showCenteredMessage(windowPtr, 'Microphone Calibration! Press any key to continue.', WhiteIndex(windowPtr));
KbWait([], 2);

showCenteredMessage(windowPtr, 'Press read the word on the screen. Press any key to continue.', WhiteIndex(windowPtr));
KbWait([], 2);

str = {'One', 'Two', 'Three', 'Four', 'Five', 'Six', 'Seven', 'Eight', 'Nine', 'Ten'};

while true
  for i = 1:length(str)
      % Preallocate an internal audio recording  buffer with a generous capacity
      % of 10 seconds:
      PsychPortAudio('GetAudioData', pahandle, 10);

      % Start audio capture immediately and wait for the capture to start.
      % We set the number of 'repetitions' to zero, i.e. record until recording
      % is manually stopped.
      PsychPortAudio('Start', pahandle, 0, 0, 1);

      % Tell user to shout:
      showCenteredMessage(windowPtr, str{i}, WhiteIndex(windowPtr));
      tStim = GetSecs;
    
      % Wait in a polling loop until some sound event of sufficient loudness
      % is captured:
      level = 0;
    
      % Repeat as long as below trigger-threshold:
      while level < triggerlevel
          % Fetch current audiodata:
          [audiodata, offset, overflow, tCaptureStart] = PsychPortAudio('GetAudioData', pahandle);

          % Compute maximum signal amplitude in this chunk of data:
          if ~isempty(audiodata)
              level = max(abs(audiodata(1, :)));
          else
              level = 0;
          end
        
          % Below trigger-threshold?
          if level < triggerlevel
              % Wait for five milliseconds before next scan:
              WaitSecs(0.005);
          end
      end

      % Ok, last fetched chunk was above threshold!
      % Find exact location of first above threshold sample.
      idx = find(abs(audiodata(1, :)) >= triggerlevel, 1);
        
      % Compute absolute event time:
      tOnset = tCaptureStart + ((offset + idx - 1) / freq);
    
      % Stop sound capture:
      PsychPortAudio('Stop', pahandle);
    
      % Fetch all remaining audio data out of the buffer - Needs to be empty
      % before next trial:
      PsychPortAudio('GetAudioData', pahandle);
    
      % Print RT:
      rt = (tOnset - tStim) * 1000;
      feedbackStr = ['Cost ' num2str(rt) ' msecs'];
      showCenteredMessage(windowPtr, feedbackStr, WhiteIndex(windowPtr));
    
      % Next trial after 2 seconds:
      WaitSecs(1.5);
  end
  
  msg = '[¡ô][¡õ] Adjust trigger level or Press [SPACE] to exit.';
  showCenteredMessage(windowPtr, msg, WhiteIndex(windowPtr));
  response = getResponseRT(responseKeySet);

  if response == upKey
    triggerlevel = triggerlevel - 0.01;
  elseif response == downKey
    triggerlevel = triggerlevel + 0.01;
  else
    break;
  end
end

% Close the audio device:
PsychPortAudio('Close', pahandle);

% Done.
resultStr = ['The trigger level is: ' num2str(triggerlevel)];
showCenteredMessage(windowPtr, resultStr, WhiteIndex(windowPtr));
KbWait([], 2);

return;