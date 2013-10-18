function convertedString = convEncoding(string)

convertedString = 1:length(string);

hexString = dec2hex(unicode2native(string, 'UTF-16BE'));

count = 1;
for i = 1:length(string)
  character = strcat(hexString(count, :), hexString(count + 1, :));
  convertedString(i) = hex2dec(character);
  count = count + 2;
end