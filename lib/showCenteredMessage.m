function [flipStart, stimulusOnset] = showCenteredMessage(windowPtr, message, color)

% Write message for subject, nicely centered in the
% middle of the display, in white color. As usual, the special
% character '\n' introduces a line-break:
DrawFormattedText(windowPtr, message, 'center', 'center', color);

% Update the display to show the message text:
[flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);