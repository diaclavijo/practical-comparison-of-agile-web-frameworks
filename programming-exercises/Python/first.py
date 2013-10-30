import string
import re
print 'hello'
#variable declaration
ninput = 'input'
ndic = 'dictionary'
noutput = 'output'
EMAIL_REGEX = re.compile(r"^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$")

# i will open a file input
inputf = open(ninput,'r')

# i will open a dictionary and create it in some data
dicf = open(ndic,'r')

dic = {}

for line in dicf:
  line = line.rstrip()
  dic[line] = True

# i will open an out put file to write data
outputf = open(noutput,'w')

#i will read each line of the input file
for line in inputf:
  #i will search for every word in the input file
  words = line.split()
  for word in words:
    word = word.strip(string.punctuation)
    regexword = r'\b' + re.escape(word) + r'\b'
    if word in dic: #i will look if it is an email or it is in the diccionary
      line = re.sub(regexword, "[" + word + "]",line ) #i will change this line accoridng to it
    elif EMAIL_REGEX.match(word):
      regexword = r'\b' + re.escape(word) + r'\b'
      line = re.sub(regexword, "{" + word + "}",line ) #
  
  outputf.write(line) #write the line in the output file
  
    
#i will close the file
inputf.close()
dicf.close()
outputf.close()
