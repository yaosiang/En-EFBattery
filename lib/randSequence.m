function totalSequence = randSequence(table, nCycles, nTrials)

totalSequence = [];

for i = 1:nCycles
  if length(table) >= nTrials
    sequenceIndex = NRandPerm(length(table), nTrials);
  else
    sequenceIndex = rem(randperm(nTrials), length(table)) + 1;
  end
  sequence = table(sequenceIndex);
  totalSequence = horzcat(totalSequence, sequence);
end