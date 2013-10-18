function [blockMsg, stimuli, nCategories, nCycles, nTrials] = initBlock(block, parms)

switch block
  case 'Practice'
    nCycles = parms.pracCycles;
    nTrials = parms.pracTrials;
    blockMsg = parms.pracMsg;
    nCategories = 3;
  case 'Four Categories'
    nCycles = parms.fourCategoriesCycles;
    nTrials = parms.fourCategoriesTrials;
    blockMsg = parms.fourCategoriesMsg;
    nCategories = 4;
  case 'Five Categories'
    nCycles = parms.fiveCategoriesCycles;
    nTrials = parms.fiveCategoriesTrials;
    blockMsg = parms.fiveCategoriesMsg;
    nCategories = 5;
end

stimuli = randSequence(parms.words, nCycles * nTrials, length(parms.words));