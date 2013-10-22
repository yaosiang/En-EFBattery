function str = joinCellString( cellStr, sep )
%Join a cell-array of string by specified separator
%Ex: str = joinCellString( {'a','b','c'},'_' ); %gives 'a_b_c'

arg = sprintf('%%s%s',sep);
str = sprintf(arg,cellStr{:});
str=str(1:end-numel(sprintf(sep)));
