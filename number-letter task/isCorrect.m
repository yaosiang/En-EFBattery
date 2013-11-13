function acc = isCorrect(parms, keySet, stimuli, response)

evenKey = keySet(1);
oddKey = keySet(2);
vowelKey = keySet(3);
consonantKey = keySet(4);
acc = 'N';

switch stimuli(3)
    case '1'
        if ismember(cellstr(stimuli(1)), parms.evenDigits)
            if KbName(response) == evenKey; acc = 'Y'; end
        else
            if KbName(response) == oddKey; acc = 'Y'; end
        end
    case '2'
        if ismember(cellstr(stimuli(1)), parms.evenDigits)
            if KbName(response) == evenKey; acc = 'Y'; end
        else
            if KbName(response) == oddKey; acc = 'Y'; end
        end
    case '3'
        if ismember(cellstr(stimuli(2)), parms.consonants)
            if KbName(response) == consonantKey; acc = 'Y'; end
        else
            if KbName(response) == vowelKey; acc = 'Y'; end
        end
    case '4'
        if ismember(cellstr(stimuli(2)), parms.consonants)
            if KbName(response) == consonantKey; acc = 'Y'; end
        else
            if KbName(response) == vowelKey; acc = 'Y'; end
        end
end