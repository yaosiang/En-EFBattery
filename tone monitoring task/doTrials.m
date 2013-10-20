function correct = doTrials(parms, windowPtr, stimuli, nTones, nCycles, nTrials)

% Predefine key name:
highKey = KbName('3#');
mediumKey = KbName('2@');
lowKey = KbName('1!');
spaceKey = KbName('SPACE');
responseKeySet = [highKey, mediumKey, lowKey];

correct = cell(1, nCycles * nTrials);

% Perform basic initialization of the sound driver:
InitializePsychSound;

% Perform basic initialization of the sound driver:
pahandle = PsychPortAudio('Open', [], [], 0, 8192, 1);

countOne = 1;
countTwo = 1;
for iCycle = 1:nCycles
  for jTrial = 1:nTrials

    % Display ready:
    showCenteredMessage(windowPtr, parms.readyMsg, parms.foreColor);
    getResponseRT(spaceKey);
    Screen('Flip', windowPtr, 0);

    WaitSecs(parms.responseDuration);

    correctNo = 0;
    
    lowNo = 0;
    mediumNo = 0;
    highNo = 0;
    
    for i = 1:nTones
      stimulus = stimuli{countOne};

      if stimulus == 1
        lowNo = lowNo + 1;
        if rem(lowNo, (parms.recallNo + 1)) == 0
          lowNo = 1;
        end
      end
      if stimulus == 2
        mediumNo = mediumNo + 1;
        if rem(mediumNo, (parms.recallNo + 1)) == 0
          mediumNo = 1;
        end
      end
      if stimulus == 3
        highNo = highNo + 1;
        if rem(highNo, (parms.recallNo + 1)) == 0
          highNo = 1;
        end
      end

      %sound(parms.pitchStimuli{stimulus});
      PsychPortAudio('FillBuffer', pahandle, parms.pitchStimuli{stimulus});
  	  PsychPortAudio('Start', pahandle, 1, 0, 1);

      showCenteredMessage(windowPtr, parms.waitForResponseMsg, parms.foreColor);
      responseKey = getTimeoutResponseRT(responseKeySet, parms.responseDuration);
      Screen('Flip', windowPtr, 0);

      if responseKey == ''
        if lowNo == parms.recallNo;    lowNo    = 0; end
        if mediumNo == parms.recallNo; mediumNo = 0; end
        if highNo == parms.recallNo;   highNo   = 0; end
      else        
        if responseKey == lowKey
          if lowNo == parms.recallNo
            correctNo = correctNo + 1;
          else
     	      PsychPortAudio('FillBuffer', pahandle, parms.beep);
	          PsychPortAudio('Start', pahandle, 1, 0, 1);
          end
          lowNo = 0;
        end
        if responseKey == mediumKey
          if mediumNo == parms.recallNo
            correctNo = correctNo + 1;
          else
     	      PsychPortAudio('FillBuffer', pahandle, parms.beep);
	          PsychPortAudio('Start', pahandle, 1, 0, 1);
          end
          mediumNo = 0;
        end
        if responseKey == highKey
          if highNo == parms.recallNo
            correctNo = correctNo + 1;            
          else
       	    PsychPortAudio('FillBuffer', pahandle, parms.beep);
	          PsychPortAudio('Start', pahandle, 1, 0, 1);
          end
          highNo = 0;
        end
      end
      
      WaitSecs(parms.ITI);
      countOne = countOne + 1;
    end

    correct{countTwo} = correctNo;
    countTwo = countTwo + 1;
  end
  

  if iCycle < nCycles
    % Display break message:
    showCenteredMessage(windowPtr, parms.breakMsg, parms.foreColor);
    KbWait([], 2);
    WaitSecs(0.5);
  end
end

PsychPortAudio('Stop', pahandle);
PsychPortAudio('Close', pahandle);