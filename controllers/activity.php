<?php
  
class activity {
    
  static function compute() {
    $form_values = F3::scrub($_POST);
    $value = $form_values["value"];
    echo "vous avez demandé $value";
  }
   
}

?>
