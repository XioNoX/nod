<?php
  
  class park {
    
/*called for the url /parks.
  lists all the parks in the database */
    static function index() {
      $count = isset($_GET["count"]) && is_numeric($_GET["count"]) ? F3::get('GET["count"]') : 25;
      $parks = DB::sql("SELECT * FROM points_of_interest 
                        INNER JOIN parks
                        ON parks.id = points_of_interest.type_id_in_table
                        WHERE type='parks'
                        LIMIT $count");
      echo json_encode($parks);
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
    
  }
  
?>
