function p = getParameters

% Messages:
p.checkEquipmentMsg = 'Wear Headphone Please!\n\nPress [SPACE] to begin.';
p.questionMsg = 'Press [SPACE] to read instructions.';
p.numberPracMsg = 'Press [SPACE] to begin stage 1 practice.';
p.question2Msg = 'Press [SPACE] if you understand the instruction.\n\n\nIf you did not understand the instructions, \n\nplease ask the researcher for assistance.';
p.numberMsg = 'Press [SPACE] to begin stage 1 experiment.';
p.letterPracMsg = 'Press [SPACE] to begin stage 2 practice.';
p.letterMsg = 'Press [SPACE] to begin stage 2 experiment.';
p.numberLetterPracMsg = 'Press [SPACE] to begin stage 3 practice.';
p.numberLetterMsg = 'Press [SPACE] to begin stage 3 experiment.';
p.breakMsg = 'Take Break Please! Press any key to contiune.';
p.takeOffEquipmentMsg = 'Take Off Headphone Please!';
p.thanksMsg = 'Thanks for your participation, \n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';
p.readyMsg = 'READY\n\nPress [SPACE] to begin.';

% Cycles:
p.numberPracCycles = 1;
p.numberCycles = 1;
p.letterPracCycles = 1;
p.letterCycles = 1;
p.numberLetterPracCycles = 1;
p.numberLetterCycles = 1;

% Trial numbers:
p.numberPracTrials = 6;
p.numberTrials = 32;
p.letterPracTrials = 6;
p.letterTrials = 32;
p.numberLetterPracTrials = 8;
p.numberLetterTrials = 128;

% Duration (secs):
p.ITI = 0.15;
p.errorResponseITI = 0.5;
p.timeOut = 5;

% Quadrants:
p.quadrants= {'1', '2', '3', '4'};

% Stimuli:
p.consonants = {'G', 'K', 'H', 'R'};
p.vowels     = {'A', 'E', 'I', 'U'};
p.evenDigits  = {'2', '4', '6', '8'};
p.oddDigits   = {'3', '5', '7', '9'};

% Feedback sound:
p.beep = sin(1:0.5:100);

% Output header:
p.header = 'Block Cycle Trial Quadrant Target Response RT Accuracy';

% Colors:
p.foreColor = 255;
p.backColor = 0;

% Text size:
p.textSize = 24;

% Screen resolution (px):
p.screenWidth = 1024;
p.screenHeight = 768;