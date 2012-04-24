var options = { 
  target: '#felix',   
  success: function() { 
  } 
};

$(document).ready(
  function() {
    // bind all the form where the data-remote is setted with an ajax request
    $('form[data-remote]').ajaxForm(options);
  }
);
