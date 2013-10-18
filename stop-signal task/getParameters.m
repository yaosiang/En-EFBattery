function p = getParameters

% Messages:
p.checkEquipmentMsg = 'Wear Headphone Please!\n\nPress [SPACE] to begin.';
p.questionMsg = 'Press [SPACE] to read instructions.';
p.buildPracMsg = 'Press [SPACE] to begin stage 1 practice.';
p.question2Msg = 'Press [SPACE] if you understand the instruction.\n\n\nIf you didn\¡¦t understand the instructions, \n\nplease ask the researcher for assistance.';
p.buildMsg = 'Press [SPACE] to begin stage 1 experiment.';
p.stopPracMsg = 'Press [SPACE] to begin stage 2 practice.';
p.stopMsg = 'Press [SPACE] to begin stage 2 experiment.';
p.breakMsg = 'Take Break Please! Press any key to contiune.';
p.takeOffEquipmentMsg = 'Take Off Headphone Please!';
p.thanksMsg = 'Thanks for your participation, \n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';
p.readyMsg = 'READY\n\nPress [SPACE] to begin.';
p.fixationMsg = '+';
p.maskMsg = '***';

% Cycles:
p.buildPracCycles = 1;
p.buildCycles = 1;
p.stopPracCycles = 1;
p.stopCycles = 1;

% Trial numbers:
p.buildPracTrials = 6;
p.buildTrials = 24;
p.stopPracTrials = 24;
p.stopTrials = 120;

% Duration (secs):
p.fixationDuration = 0.5;
p.targetDuration = 2;
p.ITI = 0.5;
p.stopSignalLatency = 0.225;
p.stopSignalOnsetTime = 0;
p.buildBlockMeanRT = 0;

% Stimuli:
p.animalStimuli    = {'Horse', 'Rat' , 'Tiger' , ...
                      'Duck' , 'Cat' , 'Lion'  , ...
                      'Bear' , 'Wolf', 'Turtle', ...
                      'Deer' , 'Frog', 'Snake'};
p.nonAnimalStimuli = {'Knife', 'Cup'   , 'Gun'   , ...
                      'Wall' , 'Pot'   , 'Pants' , ...
                      'Salt' , 'Bottle', 'Ladder', ...
                      'Cake' , 'Basin' , 'Stick'};

% N trials for signal:
p.nPracSignal = 12;
p.nSignal = 30;

% Feedback sound:
p.beep = sin(1:0.5:100);

% Output header:
p.header = 'Block Cycle Trial Target IsStop Response RT Accuracy';

% Colors:
p.foreColor = 255;
p.backColor = 0;

% Text size:
p.textSize = 24;

% Screen resolution (px):
p.screenWidth = 1024;
p.screenHeight = 768;