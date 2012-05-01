//defining custom icons for the page 
var NodIcon = L.Icon.extend({
  iconUrl: 'images/map/icon.png',
  shadowUrl: 'images/map/icon-shadow.png'
});

var map = null; //the main map of the page

var ajaxFormOptions = { 
  target: '#content',   
  success: function() { 
  } 
};

function initMap() {
    // Define the map to use from MapBox
    // This is the TileJSON endpoint copied from the embed button on your map
    var url = 'http://a.tiles.mapbox.com/v3/xionox.map-ef0s39bd.jsonp';

    // Make a new Leaflet map in your container div
    map = new L.Map('mapbox')  // container's id="mapbox"

    // Center the map on Nantes, DC, at zoom 15
    .setView(new L.LatLng(47.215, -1.541), 13);

    // Get metadata about the map from MapBox
    wax.tilejson(url, function(tilejson) {
        // Add MapBox Streets as a base layer
        map.addLayer(new wax.leaf.connector(tilejson));
    });
}

function showPoi(type) {
  var activitiesUrl = APIURL + "activities";
  var types = {};
  types[type] = true;
  $.post(activitiesUrl, types, function (data, textStatus, xhr) {
    if (textStatus === "success") {
      var arrayOfPoi = JSON.parse(data);

      var icon = new NodIcon();
      for (index in arrayOfPoi) {
        poi = arrayOfPoi[index];
        var latLong = new L.LatLng(poi.latitude, poi.longitude);
        var marker = new L.Marker(latLong, {icon:icon});
        map.addLayer(marker);
      }
    }
  
  });
}

$(document).ready(
  function() {
    /******* AJAX FORMS *******/

    // bind all the form where the data-remote is setted with an ajax request
    $('form[data-remote]').ajaxForm(ajaxFormOptions);

    $('#accordion').accordion();

   
    /***** MAP *******/
    initMap();
  }
);
