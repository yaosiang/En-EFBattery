function [isClockwise, isTopQuadrant, blockMsg, stimuli, nCycles, nTrials] ...
    = initBlock(block, parms)

isClockwise = false;
isTopQuadrant = false;

switch block
  case 'Number Practice'
    nCycles = parms.numberPracCycles;
    nTrials = parms.numberPracTrials;
    blockMsg = parms.numberPracMsg;
    isTopQuadrant = true;
  case 'Number'
    nCycles = parms.numberCycles;
    nTrials = parms.numberTrials;
    blockMsg = parms.numberMsg;
    isTopQuadrant = true;
  case 'Letter Practice'
    nCycles = parms.letterPracCycles;
    nTrials = parms.letterPracTrials;
    blockMsg = parms.letterPracMsg;
  case 'Letter'
    nCycles = parms.letterCycles;
    nTrials = parms.letterTrials;
    blockMsg = parms.letterMsg;
  case 'Number-Letter Practice'
    nCycles = parms.numberLetterPracCycles;
    nTrials = parms.numberLetterPracTrials;
    blockMsg = parms.numberLetterPracMsg;
    isClockwise = true;
  case 'Number-Letter'
    nCycles = parms.numberLetterCycles;
    nTrials = parms.numberLetterTrials;
    blockMsg = parms.numberLetterMsg;
    isClockwise = true;
end

charStimuli = randSequence([parms.consonants, parms.vowels], nCycles, nTrials);
digitStimuli = randSequence([parms.oddDigits, parms.evenDigits], nCycles, nTrials);
topQuadrantStimuli = randSequence(parms.quadrants(1:1+1), nCycles, nTrials);
bottomQuadrantStimuli = randSequence(parms.quadrants(end-1:end), nCycles, nTrials);

stimuli = cell(1, nCycles * nTrials);
for i = 1:nCycles * nTrials
  if isClockwise
    remain = num2str(rem(i, 4));
    switch remain
      case '1'
        quadrant = '1';
      case '2'
        quadrant = '4';
      case '3'
        quadrant = '3';
      case '0'
        quadrant = '2';
    end
  end
  if isTopQuadrant
    stimuli{i} = strcat(digitStimuli{i}, charStimuli{i}, topQuadrantStimuli{i});
  end
  if ~isTopQuadrant && ~isClockwise
    stimuli{i} = strcat(digitStimuli{i}, charStimuli{i}, bottomQuadrantStimuli{i});
  end
  if isClockwise
    stimuli{i} = strcat(digitStimuli{i}, charStimuli{i}, quadrant);
  end
end