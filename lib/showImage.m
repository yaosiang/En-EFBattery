function [flipStart, stimulusOnset] = showImage(windowPtr, filename)

imagedata = imread(filename);
texture = Screen('MakeTexture', windowPtr, imagedata);

Screen('DrawTexture', windowPtr, texture);
[flipStart, stimulusOnset] = Screen('Flip', windowPtr, 0);
