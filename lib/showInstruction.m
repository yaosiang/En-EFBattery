function showInstruction(windowPtr, order, pages, color)

rect = Screen('Rect', windowPtr);

upKey = KbName('UpArrow');
downKey = KbName('DownArrow');
spaceKey = KbName('SPACE');

msg1 = '[SPACE] Exit';
msg2 = '[v] Next';
msg3 = '[^] Previous [v] Next';
msg4 = '[^] Previos [SPACE] Exit';

currentPage = 1;
while currentPage <= pages
    
    filename = strcat('instructions', filesep, num2str(order), '-', num2str(currentPage), '.jpg');
    imagedata = imread(filename);
    texture = Screen('MakeTexture', windowPtr, imagedata);
    Screen('DrawTexture', windowPtr, texture);
    
    if pages == 1
        DrawFormattedText(windowPtr, msg1, 'center', (rect(4) - 50), color);
        Screen('Flip', windowPtr, 0);
        response = getResponseRT(spaceKey);
    else
        if currentPage == 1
            DrawFormattedText(windowPtr, msg2, 'center', (rect(4) - 50), color);
            Screen('Flip', windowPtr, 0);
            response = getResponseRT(downKey);
        end
        if (currentPage ~= 1) && (currentPage ~= pages)
            DrawFormattedText(windowPtr, msg3, 'center', (rect(4) - 50), color);
            Screen('Flip', windowPtr, 0);
            response = getResponseRT([upKey, downKey]);
        end
        if (currentPage ~= 1) && (currentPage == pages)
            DrawFormattedText(windowPtr, msg4, 'center', (rect(4) - 50), color);
            Screen('Flip', windowPtr, 0);
            response = getResponseRT([upKey, spaceKey]);
        end
    end
    
    if response == upKey;     currentPage = currentPage - 1; end
    if response == downKey;   currentPage = currentPage + 1; end
    if response == spaceKey;  break;                         end
end