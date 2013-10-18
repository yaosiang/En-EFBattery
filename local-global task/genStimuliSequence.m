function stimuli = genStimuliSequence(stimuliNumber)

stimuli = randperm(stimuliNumber);

while true
  count = 0;
  previousIndex = 0;

  for stimulusNo = 1:length(stimuli)
    currentIndex = stimulusNo;
    if previousIndex ~= 0
      if rem(stimuli(currentIndex), 2) == 1
        if rem(stimuli(previousIndex), 2) == 0;
          count = count + 1;
        end
      else
        if rem(stimuli(previousIndex), 2) == 1;
          count = count + 1;
        end
      end
    end
    previousIndex = currentIndex;
  end

  if count == (length(stimuli) / 2 - 1)
    break;
  else
    stimuli = randperm(stimuliNumber);
  end
end