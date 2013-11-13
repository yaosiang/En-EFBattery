function p = getParameters

% Messages:
p.checkEquipmentMsg = 'Check microphone and recorder are ready.';
p.questionMsg = 'Press [SPACE] to read instructions.';
p.pracMsg = 'Press [SPACE] to begin practice.';
p.question2Msg = 'Press [SPACE] if you understand the instruction.\n\n\nIf you did not understand the instructions, \n\nplease ask the researcher for assistance.';
p.expMsg = 'Press [SPACE] to begin experiment.';
p.breakMsg = 'Take Break Please! \n\nPress any key to contiune.';
p.thanksMsg = 'Thanks for your participation, \n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';
p.readyMsg = 'READY\n\nPress [SPACE] to begin.';
p.fixationMsg = '+';

% Cycles:
p.pracCycles = 1;
p.expCycles = 1;

% Trial numbers:
% It must be an even number!
p.pracTrials = 36;
p.expTrials = 96;

% Duration (secs):
p.ITI = 0.5;

% Stimuli:
p.globalFeatures = {'Circle', 'Cross', 'Triangle', 'Rectangle'};
p.localFeatures  = {'Circle', 'Cross', 'Triangle', 'Rectangle'};
p.colorFeatures  = {'Blue', 'White'};

% Voice trigger level:
p.triggerLevel = 0;
p.frequency = 44100;

% Output header:
p.header = 'Block Cycle Trial Target RT';

% Colors:
p.foreColor = 255;
p.backColor = 0;

% Text size:
p.textSize = 24;

% Screen resolution (px):
p.screenWidth = 1024;
p.screenHeight = 768;