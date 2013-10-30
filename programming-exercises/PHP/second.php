<?php

class NumberSet{
    private $arrayset;

    function __construct($vector = null){
        if ($vector == null){
            $this->arrayset = array();
        }else{
            $this->arrayset = array();
            foreach ($vector as $element) {
      
                if (key_exists($element,$this->arrayset)){
                    throw new Exception('Trying to initalize with a vector with repeated elements');
                }
                $this->arrayset[$element]=True;
            }
        }
    }

    function size(){
        return count($this->arrayset);
    }

    function isEmpty(){
        return count($this->arrayset==0);
    }

    function add($number){
        if (key_exists($number,$this->arrayset)){
            throw new Exception('Trying to add a number which is inside the vector');
        }else{
            $this->arrayset[$number] = True;
        }
    }

    function belong($number){
        return key_exists($number, $this->arrayset);
    }

    function equal(NumberSet $theother){
        return ($this->arrayset == $theother->arrayset );
    }

    function subset(NumberSet $theother){
        foreach (array_keys($theother->arrayset) as $number){
            
            if (!key_exists($number, $this->arrayset)){
                return False;
            }
        }
        return True;
    }

    function vector(){
        return array_keys($this->arrayset);
    }

    function union($theother){
        $union = new NumberSet(array_keys($this->arrayset)); //init $union with this instance numbers 
        foreach (array_keys($theother->arrayset) as $number){ //find which numbers which are in the $theother are not in the $union and add them
            if (!key_exists($number, $union->arrayset)){
                $union->arrayset[$number]=True;
            }
        }
        return $union;
    }
}


echo "hello\n";

$aempty = new NumberSet();

var_dump($aempty);

$first = new NumberSet(array(1,2,3,4));
//~ $fail = new NumberSet(array(1,2,3,3,4)); // throws exception



var_dump($first);

assert($first->size() == 4);
assert($aempty->size() == 0);

assert($aempty->isEmpty());

$aempty->add(1);
assert($aempty->size() == 1);
var_dump($aempty);

$first->add(5);
assert($first->size() == 5);
var_dump($first);

//~ $first->add(3); // THROWS EXCEPTION

assert($first->belong(1));
assert($first->belong(4));
assert($aempty->belong(1));

assert(!$first->equal($aempty));

$equal = new NumberSet(array(5,1,4,3,2));

assert($equal->equal($first));

$second = new NumberSet(array(5,6,7));

assert($equal->subset($first));
assert($first->subset($aempty));
assert(!$aempty->subset($first));
assert(!$first->subset($second));

var_dump($equal->vector());
var_dump($aempty->vector());

var_dump($first->union($aempty));
var_dump($first->union($second));
$third = new NumberSet(array(6,7,8));
var_dump($first->union($third));

var_dump($first->union(new NumberSet()));

echo 'THE END';

?>
