function p = getParameters

% Messages:
p.readyMsg = 'READY\n\n\nPress [SPACE] to begin.';
p.waitForResponseMsg = '?';
p.checkEquipmentMsg = 'Wear Headphone Please!\n\nPress [SPACE] to begin.';
p.questionMsg = 'Press [SPACE] to read instructions.';
p.soundDemoMsg = 'Play high, medium and low pitch sounds 3 times! \n\nPress [SPACE] to continue.';
p.lowPitchMsg = 'This is Low Pitch.';
p.mediumPitchMsg = 'This is Middle Pitch.';
p.highPitchMsg = 'This is High Pitch.';
p.pracMsg = 'Press [SPACE] to begin practice.';
p.question2Msg = 'Press [SPACE] if you understand the instruction.\n\n\nIf you did not understand the instructions, \n\nplease ask the researcher for assistance.';
p.expMsg = 'Press [SPACE] to begin experiment.';
p.breakMsg = 'Take Break Please! \n\nPress any key to contiune.';
p.thanksMsg = 'Thanks for your participation, \n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';
p.takeOffEquipmentMsg = 'Take Off Headphone Please!';

% Cycles:
p.pracCycles = 1;
p.expCycles = 1;

% Trial numbers:
p.pracTrials = 1;
p.expTrials = 4;

% Duration (secs):
p.responseDuration = 1.5;
p.ITI = 1.5;

% Stimuli:
p.pracTones = 14;
p.expTones = 25;
p.lowPitch    = sin(2 * pi * 220 * (0:0.000125:0.5));
p.mediumPitch = sin(2 * pi * 440 * (0:0.000125:0.5));
p.highPitch   = sin(2 * pi * 880 * (0:0.000125:0.5));
p.pitchStimuli = {p.lowPitch, p.mediumPitch, p.highPitch};
p.stimuli = {1, 2, 3};
p.pitchMsg = {p.lowPitchMsg, p.mediumPitchMsg, p.highPitchMsg};

% N tones for recall:
p.recallNo = 4;

% Voice trigger level:
p.triggerLevel = 0.03;
p.frequency = 44100;

% Feedback sound:
p.beep = sin(1:0.5:100);

% Output header:
p.header = 'Block Cycle Trial Target Accuracy';

% Colors:
p.foreColor = 255;
p.backColor = 0;

% Text size:
p.textSize = 24;

% Screen resolution (px):
p.screenWidth = 1024;
p.screenHeight = 768;