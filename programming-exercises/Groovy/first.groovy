
VALID_EMAIL=/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/
inputn = 'input'
dictionaryn = 'dictionary'
outputn = 'output'

//create dictionary
dictionarymap = [:]
dictionary = new File(dictionaryn)
dictionary.eachLine {
  dictionarymap[it]=true;
  }

//read input file and treat it

inputf = new File(inputn)
outputf = new FileWriter(outputn)

inputf.eachLine{
  // split in words
  outputf << it.replaceAll(/([\s,:'?!]*)([^\s,:'?!]+)([\s,:'?!]*)/){
    if ( it[2] ==~ VALID_EMAIL){
        it[2] = '{'+it[2]+'}'
    }else{
      if ( dictionarymap[it[2]] ) {
        it[2] = '['+it[2]+']'
      }
    }
    
    it[1]+it[2]+it[3]
  }
  outputf << '\n'
}
outputf.write()
outputf.close()



