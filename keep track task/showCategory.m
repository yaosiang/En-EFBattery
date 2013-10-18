function [flipStart, stimulusOnset] = showCategory(windowPtr, parms, categories)

rect = Screen('Rect', windowPtr);
centerWidth = rect(3) / 2;

initOffset = ((78 * length(categories)) + (19 * (length(categories) - 1))) / 2;

xOffset = 0;
for i = 1:length(categories)
  category = categories{i};
  if i == 1
    [x, y, box] = DrawFormattedText(windowPtr, category, (centerWidth - initOffset), (rect(4) - 300), parms.foreColor);
  else
    [x, y, box] = DrawFormattedText(windowPtr, category, (xOffset + 19), (rect(4) - 300), parms.foreColor);
  end
  xOffset = x;
end

[flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);