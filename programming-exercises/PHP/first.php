<?php
const NINPUT = 'input';
const NDIC = 'dictionary';
const NOUTPUT = 'output';
const EMAIL_REGEX = "/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/";
$finput = fopen(NINPUT, 'r');
$fdic = fopen(NDIC, 'r');
$foutput = fopen(NOUTPUT, 'w');

while(!feof($fdic)){ // create dictionary
    $word = fgets($fdic);
    $word = trim($word);
    $dic[$word] = True;
}


while(!feof($finput)){ // read the input file to look for words
    $line = fgets($finput); // read the a line from inputfile
    $splitline = preg_split("/\s+/", $line, -1, PREG_SPLIT_NO_EMPTY); //separate all the words , or characters separed by spaces 
    foreach ($splitline as $word){ // for each word test 
        
        if ( preg_match(EMAIL_REGEX,$word) ){ //is email ?
            $replace = '{'.$word.'}'; // write the replacement word
            $line = str_replace($word,$replace,$line); // write it on the line variable
        }else{ // is in the dictionary ? 
            preg_match("/([\w-]+)/", $word, $matches);
           
            if (isset($dic[$matches[1]])){

                $replace = '['.$matches[1].']'; // write the replacement word
                $regex = '/\b'.$matches[1].'\b/';
                
                $line = preg_replace($regex,$replace,$line); // write it on the line variable
            }
        }
    };
    fwrite($foutput,$line); // write the modfied line 
}



fclose($finput); // close files
fclose($fdic);
fclose($foutput);

echo 'hello';



?>
