<?php
  
  class parks {
    
/*called for the url /parks.
  lists all the parks in the database */
    static function specific() {
      $count = isset($_GET["count"]) && is_numeric($_GET["count"]) ? F3::get('GET["count"]') : 25;
     return $parks = DB::sql("SELECT * FROM points_of_interest 
                        INNER JOIN parks
                        ON parks.id = points_of_interest.type_id_in_table
                        WHERE type='parks'
                        LIMIT $count");
    }
     
/*called for the url /parks/(id)
  return a single park */
    static function show() {
      $id = F3::get('PARAMS["id"]');
      $park = DB::sql("SELECT * FROM points_of_interest 
                        INNER JOIN parks
                        ON parks.id = points_of_interest.type_id_in_table
                        WHERE type='parks'
                        AND parks.id=$id");
      echo json_encode($park);
     }
     
     static function query($id = NULL) {
   		if (F3::get('include_parks') != TRUE) exit();
   		if(isset($id)) return single($id);
   		return specific($id);
   }
    
  }
  
?>
