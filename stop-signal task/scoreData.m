function [id, dv, transformedDv] = scoreData

exp = getRawData;

id = zeros(1, length(exp.subject));
dv = zeros(1, length(exp.subject));
transformedDv = 1:length(exp.subject);

for i = 1:length(exp.subject)
  id(i) = str2double(exp.subject(i).Id);

  cycleDv = zeros(1, length(exp.subject(1).block(2).cycle));
  for j = 1:length(exp.subject(i).block(2).cycle)
    correctCount = 0;
    for k = 1:length(exp.subject(i).block(2).cycle(j).trial)
      if strcmp(exp.subject(i).block(2).cycle(j).trial(k).isStop, 'Y')
        if strcmp(exp.subject(i).block(2).cycle(j).trial(k).accuracy, 'Y')
          correctCount = correctCount + 1;
        end
      end
    end
    cycleDv(j) = correctCount / (length(exp.subject(i).block(2).cycle(j).trial) / 4);
  end
  dv(i) = sum(cycleDv) / length(exp.subject(i).block(2).cycle);
  transformedDv(i) = asin(sqrt(dv(i)));
end