function [response, rt, acc] = doTrials(parms, windowPtr, stimuli, nCycles, nTrials)

% Predefine key name:
bKey = KbName('b');
cKey = KbName('c');
dKey = KbName('d');
fKey = KbName('f');
gKey = KbName('g');
hKey = KbName('h');
jKey = KbName('j');
kKey = KbName('k');
lKey = KbName('l');
mKey = KbName('m');
nKey = KbName('n');
pKey = KbName('p');
qKey = KbName('q');
rKey = KbName('r');
sKey = KbName('s');
tKey = KbName('t');
vKey = KbName('v');
xKey = KbName('x');
zKey = KbName('z');
spaceKey = KbName('SPACE');
responseKeySet = [bKey, cKey, dKey, fKey, gKey, hKey jKey, kKey, lKey, ...
                  mKey, nKey, pKey, qKey, rKey, sKey, tKey, vKey, xKey, zKey, spaceKey];

response = cell(1, nCycles * nTrials);
rt = 1:nCycles * nTrials;
acc = 1:nCycles * nTrials;

% Display ready:
showCenteredMessage(windowPtr, parms.readyMsg, parms.foreColor);
getResponseRT(spaceKey);

count = 1;
for iCycle = 1:nCycles
  for jTrial = 1:nTrials
    
    for i = 1:length(stimuli{count})
      [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, stimuli{count}{i}(1), parms.foreColor);
      Screen('Flip', windowPtr, stimulusOnset + parms.letterDuration);
    end

    % Get subject response and rt:
    [response{count}, rt(count)] = getEchoStringRT(windowPtr, responseKeySet, parms);
    if strcmp(response{count}, '')
      response{count} = '_';
    end
    
    % Get correct answer:
    acc(count) = accuracy(stimuli{count}(end-3:end), response{count});
 
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


function acc = accuracy(answer, response)

correctNo = 0;
for i = 1:length(response)
  if ~strcmp(response(i), '_')
    if upper(response(i)) == answer{i};
      correctNo = correctNo + 1;
    end
  end
end

acc = correctNo / length(response);