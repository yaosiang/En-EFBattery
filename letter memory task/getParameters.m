function p = getParameters

% Messages:
p.readyMsg = 'READY\n\nPress [SPACE] to begin.';
p.questionMsg = 'Press [SPACE] to read instructions.';
p.pracMsg = 'Press [SPACE] to begin practice.';
p.question2Msg = 'Press [SPACE] if you understand the instructions.\n\n\nIf you did not understand the instructions, \n\nplease ask the researcher for assistance';
p.expMsg = 'Press [SPACE] to begin experiment.';
p.breakMsg = 'Take Break Please! Press any key to contiune.';
p.thanksMsg = 'Thanks for your participation!\n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';

% Cycles:
p.pracCycles = 1;
p.expCycles = 1;

% Trial numbers:
p.pracTrials = 4;
p.expTrials = 12;

% Duration (secs):
p.ITI = 1;
p.letterDuration = 2;

% Stimuli:
p.consonants = {'B', 'C', 'D', 'F', 'G', ...
    'H', 'J', 'K', 'L', 'M', ...
    'N', 'P', 'Q', 'R', 'S', ...
    'T', 'V', 'X', 'Z'};

% N letters for recall:
p.lastNo = 4;

% List length:
p.pracListLength = {'5', '7'};
p.listLength = {'5', '7', '9', '11'};

% Output header:
p.header = 'Block Cycle Trial Target Response RT Accuracy';

% Colors:
p.foreColor = 255;
p.backColor = 0;

% Text size:
p.textSize = 24;

% Screen resolution (px):
p.screenWidth = 1024;
p.screenHeight = 768;