<?php
  
  class park {
    
/*called for the url /parks.
  lists all the parks in the database */
    static function index() {
      $parks = DB::sql("SELECT * FROM points_of_interest 
                        INNER JOIN parks
                        ON parks.id = points_of_interest.type_id_in_table
                        WHERE type='park'");
      echo json_encode($parks);
    }
     
/*called for the url /parks/(id)
  return a single park */
     static function show() {
        $id = F3::get('PARAMS["id"]');
        echo "you have asked for the park ".$id;
     }
    
  }
  
?>
