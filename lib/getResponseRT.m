function [response, rt] = getResponseRT(keySet, stimulusOnset)

if nargin < 2
  stimulusOnset = -1;
end

if stimulusOnset ~= -1
  startTime = stimulusOnset;
else
  startTime = GetSecs;
end

while KbCheck; end

while true
  [keyIsDown, secs, keyCode] = KbCheck;
  if keyIsDown
    c = find(keyCode);
    if length(c) == 1
      if ismember(c, keySet)
        break;
      end
    end
    while KbCheck; end
  end
  WaitSecs(0.01);
end

rt = secs - startTime;
response = c;