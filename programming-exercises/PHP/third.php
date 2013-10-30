<?php

abstract class Component{
    abstract public function __toString();
}

class TextComponent extends Component{
    private $text;

    public function __toString(){
        return $this->text;
    }
    
    function __construct($text){
        $this->text = $text;
    }

    
}
class NumberComponent extends Component{
    private $number;
    function __construct($number){
        $this->number = $number;
    }

    function __toString(){
        return $this->number;
    }
}

class DateComponent extends Component{
    private $date;
    function __construct($date){
        $this->date = $date;
    }

    function __toString(){
        return $this->date;
    }
}

class CompositeComponent extends Component{
    private $list;

    function __toString(){
        $string = '';
        foreach ($this->list as $element){
            $string .= $element->__toString();
        }
        return $string;
    }

    function add(Component $element ){
        $this->list[] = clone $element;
    }

    function size(){
        return $this->list.count();
    }

    function modify($index, Component $element){
        $this->list[$index] = clone $element;
    }
}

$p = new CompositeComponent();

$p->add( new TextComponent("String. Number:"));
$p->add( new NumberComponent(1));
$p->add( new TextComponent("\n"));
$p->add( new TextComponent("Date:"));
$p->add( new DateComponent("7/7/12"));
$p->add( new TextComponent("\n"));
$d = new CompositeComponent();
$d->add( new TextComponent("Testing composite"));
$d->add( new TextComponent("\n"));
$d->add($p);
unset($p);
$d->add( new TextComponent("End testing composite"));

echo $d;

echo " new test\n";

$d->modify(0, new TextComponent("Beginning modified"));
echo $d;


?>
