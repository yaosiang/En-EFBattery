function [id, dv, transformedDv] = scoreData

exp = getRawData;

id = zeros(1, length(exp.subject));
dv = zeros(1, length(exp.subject));
transformedDv = 1:length(exp.subject);

for i = 1:length(exp.subject)
  id(i) = str2double(exp.subject(i).Id);

  fourCycleDv = zeros(1, length(exp.subject(1).block(1).cycle));
  for j = 1:length(exp.subject(i).block(1).cycle)
    totalAccuracy = 0;
    for k = 1:length(exp.subject(i).block(1).cycle(j).trial)
      totalAccuracy = totalAccuracy + exp.subject(i).block(1).cycle(j).trial(k).accuracy;
    end
    fourCycleDv(j) = totalAccuracy / 12;
  end

  fiveCycleDv = zeros(1, length(exp.subject(1).block(2).cycle));
  for j = 1:length(exp.subject(i).block(2).cycle)
    totalAccuracy = 0;
    for k = 1:length(exp.subject(i).block(2).cycle(j).trial)
      totalAccuracy = totalAccuracy + exp.subject(i).block(2).cycle(j).trial(k).accuracy;
    end
    fiveCycleDv(j) = totalAccuracy / 15;
  end

  dv(i) = (sum(fourCycleDv) / length(exp.subject(i).block(1).cycle)) * (12 / 27) + ...
          (sum(fiveCycleDv) / length(exp.subject(i).block(2).cycle)) * (15 / 27);
  transformedDv(i) = asin(sqrt(dv(i)));
end