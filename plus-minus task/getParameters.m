function p = getParameters

% Messages:
p.questionMsg = 'Press [SPACE] to read instructions.';
p.pracMsg = 'Press [SPACE] to begin practice.';
p.question2Msg = 'Press [SPACE] if you understand the instruction.\n\n\nIf you did not understand the instructions, \n\nplease ask the researcher for assistance.';
p.plusMsg = 'Press [SPACE] to begin first stage experiment.';
p.minusMsg = 'Press [SPACE] to begin second stage experiment.';
p.plusMinusMsg = 'Press [SPACE] to begin third stage experiment.';
p.breakMsg = 'Take Break Please! Press any key to contiune.';
p.thanksMsg = 'Thanks for your participation, \n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';
p.readyMsg = 'READY\n\nPress [SPACE] to begin.';

% Cycles:
p.pracCycles = 1;
p.plusCycles = 1;
p.minusCycles = 1;
p.plusMinusCycles = 1;

% Trial numbers:
p.pracTrials = 3;
p.plusTrials = 30;
p.minusTrials = 30;
p.plusMinusTrials = 30;

% Stimuli:
p.stimuli = 13:96;

% Timeout (secs):
p.timeOut = 5;

% N letters for response:
p.lastNo = 2;

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