function acc = isCorrect(parms, keySet, answer, response)

isStop = answer(length(answer));
animalKey = keySet(1);
nonAnimalKey = keySet(2);

acc = 'N';

if char(isStop) == 'N'
  animal = parms.animalStimuli;
  for i = 1:length(animal)
    if answer(1) == animal{i}(1) && ~strcmp(response, 'TimeOut')
      if KbName(response) == animalKey
        acc = 'Y';
        break;
      end
    end
  end

  nonAnimal = parms.nonAnimalStimuli;
  for i = 1:length(nonAnimal)
    if answer(1) == nonAnimal{i}(1) && ~strcmp(response, 'TimeOut')
      if KbName(response) == nonAnimalKey
        acc = 'Y';
        break;
      end
    end
  end
else
  if strcmp(response, 'Null')
    acc = 'Y';
  end
end