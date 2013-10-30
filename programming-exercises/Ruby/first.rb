#First input file names are written in these variables**
ninput = 'input'
ndictionary = 'dictionary'
noutput = 'output'

#Second, the dictionar is created. It is used a hash for create the dictionary
#because it is easy to test if a word is in the dictionary by evaluating
#the dictionary[word]. 
dictionary = Hash.new()
File.foreach(ndictionary){ |line|
    line.chomp! #removes \n marks from the line. 
    dictionary[line]=true
    }

#Create the output file. Creates the file if it does not exists and for write only. 
theOutput = File.new(noutput,File::CREAT|File::WRONLY)

#Gets every word of every line and do the block code. Surround emails and word with brackets and braces. 
File.foreach(ninput){ |line|
 #Surronded every email defined by the regular expression with braces. 
 line.gsub!(/([\w-]+(\.[\w-]+)*@[A-Za-z0-9-]+(\.[A-Za-z0-9-]+)*(\.[A-Za-z]{2,4}))/,
 '{\1}')
 
 #Gets every word, test if it is in the dictionary, if it is it is surrounded by brackets, if it is not, it is leave in its state. 
 line.gsub!(/(^[A-Za-z'-]+)/) {
    if dictionary[$1]
        '['+$1+']'
    else
        $1
    end
 }
 #The previous example does not take into account words which are in the beginning of the line. With this substitution this exception is solved. 
 line.gsub!(/(\s+)([A-Za-z'-]+)/) {
    if dictionary[$2]
        $1+'['+$2+']'
    else
        $1+$2
    end
 }

 #write the modified line in the output file
 theOutput.puts line 
 }

#close file
theOutput.close()

puts '*** END OF THE PROGRAM ***'
#end
