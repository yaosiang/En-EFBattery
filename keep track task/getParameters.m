function p = getParameters

% Messages:
p.readyMsg = 'READY\n\nPress [SPACE] to begin.';
p.questionMsg = 'Press [SPACE] to contiune.';
p.checkEquipmentMsg = 'Check answer sheet and pen are ready.';
p.pracMsg = 'Press [SPACE] to begin practice.';
p.question2Msg = 'Press [SPACE] if you understand the instruction.\n\n\nIf you did not understand the instructions, \n\nplease ask the researcher for assistance.';
p.fourCategoriesMsg = 'Press [SPACE] to begin experiment.';
p.fiveCategoriesMsg = 'Take Break Please! \n\nPress [SPACE] to contiune.';
p.answerMsg = 'Please write down the answer! \n\nPress [SPACE] to contiune.';
p.breakMsg = 'Take Break Please! \n\nPress any key to contiune.';
p.thanksMsg = 'Thanks for your participation, \n\nPress any key to continue.';
p.escapeMsg = 'Call Researcher Please!';

% Cycles:
p.pracCycles = 1;
p.fourCategoriesCycles = 1;
p.fiveCategoriesCycles = 1;

% Trial numbers:
p.pracTrials = 1;
p.fourCategoriesTrials = 3;
p.fiveCategoriesTrials = 3;

% Duration (secs):
p.targetDuration = 1.5;

% Stimuli:
p.categories = {'Animals', 'Colours', 'Countries', ...
                'Distances', 'Metals', 'Relatives'};
p.words = {'Cat'    , 'Sheep'  , 'Chicken' , 'Bird'     , 'Pig'       , 'Dog'   , ...
           'Black'  , 'Blue'   , 'Green'   , 'Purple'   , 'Grey'      , 'Brown' , ...
           'Germany', 'Britain', 'Thailand', 'Australia', 'Russia'    , 'Italy' , ...
           'Mile'   , 'Meter'  , 'Inch'    , 'Kilometer', 'Centimeter', 'Foot'  , ...
           'Iron'   , 'Copper' , 'Steel'   , 'Aluminium', 'Tin'       , 'Bronze', ...
           'Sister' , 'Brother', 'Daughter', 'Mother'   , 'Husband'   , 'Wife'  };

% Output header:
p.header = 'Block Cycle Trial Categories WordSequence';

% Colors:
p.foreColor = 255;
p.backColor = 0;

% Text size:
p.textSize = 24;

% Screen resolution (px):
p.screenWidth = 1024;
p.screenHeight = 768;