function square = genLatinSquare(nTasks)

square = zeros(nTasks);

[nRow, nColumn] = size(square);
m = 0;
c = 3;
for i = 1:nRow
  if i == 1
    for j = 1:nColumn
      if j == 1; square(i, j) = 1; end
      if j == 2; square(i, j) = 2; end
      if (j ~= 1) && (j ~= 2) && (mod(j, 2) == 1)
        square(i, j) = nColumn - m;
        m = m + 1;
      end
      if (j ~= 1) && (j ~= 2) && (mod(j, 2) == 0)
        square(i, j) = c;
        c = c + 1;
      end
    end
  else
    for j = 1:nColumn
      n = square(i-1, j);
      if (n + 1) > nTasks
        square(i, j) = 1;
      else
        square(i, j) = (n + 1);
      end
    end
  end
end

if mod(nTasks, 2) == 1 && (nTasks ~= 1)
  secondSquare = zeros(nTasks);
  for i = 1:nRow
    k = 1;
    for j = nColumn:-1:1
      secondSquare(i, k) = square(i, j);
      k = k + 1;
    end
  end
  square = [square; secondSquare];
end