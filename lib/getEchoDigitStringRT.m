function [string, rt] = getEchoDigitStringRT(windowPtr, keySet, parms, timeout)

if nargin < 4
  timeout = Inf;
end

rect = Screen('Rect', windowPtr);
xOffset = rect(3) / 2 - 200;
yOffset = rect(4) / 2;
Screen('DrawText', windowPtr, 'Answer: ', xOffset, yOffset, parms.foreColor, parms.backColor);
[flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
startTime = stimulusOnset;
endTime = startTime + timeout;
responseTime = 0;

while KbCheck; end

string = '';
while GetSecs < endTime
  [keyIsDown, secs, keyCode] = KbCheck;

  if keyIsDown
    c = find(keyCode);

    if length(c) == 1
      switch c
        case {13, 3, 10}                      % <return> or <enter>
          if length(string) == parms.lastNo
            responseTime = secs;
            break;
          end
        case 8                                % <delete>
          if ~isempty(string)
            string = string(1:length(string)-1);
          end
          output = ['Answer: ', string];
          Screen('DrawText', windowPtr, output, xOffset, yOffset, parms.foreColor, parms.backColor);
          Screen('Flip', windowPtr, 0);
        otherwise
          if ismember(c, keySet) && (length(string) < parms.lastNo)
            if strcmp(KbName(c), 'space')
              string = [string, '_'];
            else
              d = KbName(c);
              string = [string, upper(d(1))];
            end
          end
          output = ['Answer: ' string];
          Screen('DrawText', windowPtr, output, xOffset, yOffset, parms.foreColor, parms.backColor);
          Screen('Flip', windowPtr, 0);
      end
    end
    while KbCheck; end
  end
  WaitSecs(0.01);
end

if responseTime ~= 0
  rt = responseTime - startTime;
else
  rt = timeout;
  string = '';
end