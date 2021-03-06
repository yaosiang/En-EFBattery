function categories = doTrials(parms, windowPtr, stimuli, nCategories, nCycles, nTrials)

rect = Screen('Rect', windowPtr);

% Predefine key name:
spaceKey = KbName('SPACE');

% Display ready:
showCenteredMessage(windowPtr, parms.readyMsg, parms.foreColor);
getResponseRT(spaceKey);

categories = cell(1, nCycles * nTrials);

count = 1;
k = 1;
for iCycle = 1:nCycles
    for jTrial = 1:nTrials
        
        category = randSequence(parms.categories, 1, nCategories);
        categories{k} = category;
        k = k + 1;
        
        str = joinCellString(category, '  ');
        DrawFormattedText(windowPtr, str, 'center',  (rect(4) - 100), parms.foreColor);
        [flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
        [flipStart, stimulusOnset] = Screen('Flip', windowPtr, stimulusOnset + 3);
        
        for i = 1:length(parms.words)
            words = stimuli{count};
            Screen('TextSize', windowPtr, (parms.textSize + 10));
            DrawFormattedText(windowPtr, words, 'center', 'center', parms.foreColor);
            Screen('TextSize', windowPtr, parms.textSize);
            DrawFormattedText(windowPtr, str, 'center',  (rect(4) - 100), parms.foreColor);
            [flipStart, stimulusOnset] = Screen('Flip', windowPtr, stimulusOnset + parms.targetDuration);
            count = count + 1;
        end
        
        Screen('Flip', windowPtr, 0);
        showCenteredMessage(windowPtr, parms.answerMsg, parms.foreColor);
        getResponseRT(spaceKey);
    end
    
    if iCycle < nCycles
        % Display break message:
        showCenteredMessage(windowPtr, parms.breakMsg, parms.foreColor);
        KbWait([], 2);
        WaitSecs(0.5);
    end
end