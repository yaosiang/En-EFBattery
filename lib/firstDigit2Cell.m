function result = firstDigit2Cell(response)

result = cell(1, length(response));

for i = 1:length(response)
    temp = response{1, i};
    result(i) = cellstr(temp(1));
end