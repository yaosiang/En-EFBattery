function [response, rt, acc] = doTrials(parms, windowPtr, stimuli, isPlus, isMinus, nCycles, nTrials)

% Predefine key name:
oneKey   = KbName('1!');
twoKey   = KbName('2@');
threeKey = KbName('3#');
fourKey  = KbName('4$');
fiveKey  = KbName('5%');
sixKey   = KbName('6^');
sevenKey = KbName('7&');
eightKey = KbName('8*');
nineKey  = KbName('9(');
zeroKey  = KbName('0)');
spaceKey = KbName('SPACE');
responseKeySet = [oneKey, twoKey, threeKey, fourKey, fiveKey, sixKey sevenKey, ...
    eightKey, nineKey, zeroKey];

response = cell(1, nCycles * nTrials);
rt = 1:nCycles * nTrials;
acc = cell(1, nCycles * nTrials);

% Display ready:
showCenteredMessage(windowPtr, parms.readyMsg, parms.foreColor);
getResponseRT(spaceKey);

count = 1;
for iCycle = 1:nCycles
    for jTrial = 1:nTrials
        
        [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, num2str(stimuli(count)), parms.foreColor);
        Screen('Flip', windowPtr, stimulusOnset + 0.5);
        
        % Get subject response and rt:
        [response{count}, rt(count)] = getEchoDigitStringRT(windowPtr, responseKeySet, parms, parms.timeOut);
        if strcmp(response{count}, '')
            response{count} = '-1';
        end
        
        if isPlus
            answer = stimuli(count) + 3;
        end
        
        if isMinus
            answer = stimuli(count) - 3;
        end
        
        if ~isPlus && ~isMinus
            if rem(count, 2) == 1
                answer = stimuli(count) + 3;
            else
                answer = stimuli(count) - 3;
            end
        end
        
        % Get correct answer:
        if str2double(response{count}) == answer
            acc{count} = 'Y';
        else
            acc{count} = 'N';
        end
        
        Screen('Flip', windowPtr, 0);
        
        count = count + 1;
    end
    
    if iCycle < nCycles
        % Display break message:
        showCenteredMessage(windowPtr, parms.breakMsg, parms.foreColor);
        KbWait([], 2);
        WaitSecs(0.5);
    end
end