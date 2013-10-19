function p = getParameters

% Messages:
p.readyMsg = 'READY\n\nPress [SPACE] to begin.';
p.fixationMsg = '***';
p.cueMsg = '=';
p.maskMsg = 'H';
p.waitForResponseMsg = '8';
p.checkEquipmentMsg = 'Wear Headphone Please!\n\nPress [SPACE] to begin.';
p.questionMsg = 'Press [SPACE] to read instructions.';
p.responseMappingPracMsg = 'Press [SPACE] to begin practice.';
p.question2Msg = 'Press [SPACE] if you understand the instruction.\n\n\nIf you did not understand the instructions, \n\nplease ask the researcher for assistance.';
p.responseMappingMsg = 'Press [SPACE] to begin experiment.';
p.antisaccadePracMsg = 'Press [SPACE] to begin practice.';
p.antisaccadeMsg = 'Press [SPACE] to begin experiment.';
p.breakMsg = 'Take Break Please! Press any key to contiune.';
p.takeOffEquipmentMsg = 'Take Off Headphone Please!';
p.thanksMsg = 'Thanks for your participation, \n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';

% Cycles:
p.responseMappingPracCycles = 1;
p.responseMappingCycles = 1;
p.antisaccadePracCycles = 1;
p.antisaccadeCycles = 1;

% Trial numbers:
p.responseMappingPracTrials = 6;
p.responseMappingTrials = 18;
p.antisaccadePracTrials = 6;
p.antisaccadeTrials = 72;

% Duration (secs):
p.ITI = 0.4;
p.fixationDuration = [0.2, 0.6, 1, 1.4, 1.8, 2.2];
p.cueDruation = 0.1;
p.maskDuration = 0.05;
p.targetDuration = 0.1;
% Stimuli:
p.stimuli = {'BR', 'PR', 'RR', 'BL', 'PL', 'RL'};

% Feedback sound:
p.beep = sin(1:0.5:100);

% Output header:
p.header = 'Block Cycle Trial FixationDur TargetPos Target Response RT Accuracy';

% Colors:
p.foreColor = 255;
p.backColor = 0;

% Text size:
p.textSize = 24;

% Screen resolution (px):
p.screenWidth = 1024;
p.screenHeight = 768;