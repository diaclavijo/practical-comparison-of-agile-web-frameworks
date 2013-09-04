<?php

class MY_Loader extends CI_Loader {

	/**
    * Load View
    *
    * This function is used to load a "view" file and a set of previous
    * templates. It has three parameters:
    *
    * 1. The name of the "view" file to be included or an array of
    * files to be included. 
    * 2. An associative array of data to be extracted for use in the view.
    * 3. TRUE/FALSE - whether to return the data or load it. In
    * some cases it's advantageous to be able to return data so that
    * a developer can process it in some way.
    *
    * @param string or array 
    * @param array
    * @param bool
    * @return void
    */
    public function view($view, $vars = array(), $return = FALSE)
    {
        //~ parent::view('templates/header.php');
        return parent::view($view, $vars, $return);
    }

}

?>
