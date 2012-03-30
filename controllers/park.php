<?php
  
  class park {
    
/*called for the url /parks.
  lists all the parks in the database */
    static function index() {
#TODO get poi and link it with the table park
    }
     
/*called for the url /parks/(id)
  return a single park */
     static function show() {
        $id = F3::get('PARAMS["id"]');
        echo "you have asked for the park ".$id;
     }
    
  }
  
?>
