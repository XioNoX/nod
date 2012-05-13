//defining custom icons for the page 
var NodIcon = L.Icon.extend({
  iconUrl: 'images/map/icon.png',
  shadowUrl: 'images/map/icon-shadow.png'
});

var currentMarker = null;
var tanXhr = null;
var map = null; //the main map of the page
var markerLayer = null;

var ajaxFormOptions = { 
  success: function(responseText, textStatus, xhr, form) {
    if (textStatus === "success") {
      var arrayOfPoi = JSON.parse(responseText);
      if (markerLayer) markerLayer.clearLayers();
      markerLayer = new L.LayerGroup();
      for (index in arrayOfPoi) {
        poi = arrayOfPoi[index];
        var icon = iconForPoi(poi);
        var latLong = new L.LatLng(poi.latitude, poi.longitude);
        var marker = new L.Marker(latLong, {icon:icon});
        marker.poi = poi;
        marker.addEventListener("click", function(event) { 
           openTimeline();
           timeline.setEditing();
           deselectCurrentMarker(false);
           currentMarker = this;
           var icon = new NodIcon("images/map/selected-icon.png");
           this.setIcon(icon);
           openDescription(this.poi);
           return true;
        }, false);
        //marker.addEventListener("dblclick", function(event) {timeline.addActivity(this.poi);}, false);
        markerLayer.addLayer(marker);
      }
      map.addLayer(markerLayer);
    }
  } 
};

function iconForPoi(poi) {
  return new NodIcon("images/map/"+poi.type+"-icon.png");
}

function addDraggingEventListener(element) {
  element.addEventListener('dragstart', function(e) { 
    openTimeline();
    showDragMessage();
  }, false);
}

function initDraggingEventListeners() {
  //$(".leaflet-marker-icon").each(function(index, element) {addDraggingEventListener(element)}, false);
}


function openLeftDrawer(element, b_open) {
  var jElement = $(element);
  if (jElement.css("right") == "0px" && !b_open) jElement.animate({right:"100%"});
  else jElement.animate({right:"0"});
  
}

function openTimeline() {
  timelineDrawer = document.getElementById("timeline-drawer");
  openLeftDrawer(timelineDrawer, true);
}

function openFilters() {
  timelineDrawer = document.getElementById("filters-drawer");
  openLeftDrawer(timelineDrawer, true);
}

function openDescription(poi) {
    if(tanXhr != null) tanXhr.abort();
    var container= $("#description");
    var titleContainer = $("#poi-title");
    var descContainer = $("#poi-description");
    var adressContainer = $("#poi-address");
    var tanContainer = $("#poi-tan-stops");

    container.show("slide", {direction:"down"}, 500);
    titleContainer.html(poi.label);
    descContainer.html(poi.description);
    adressContainer.html(poi.address + "<br/>" + poi.zip + " " + poi.city); 
    tanContainer.html("");
    showAjaxLoader("poi-tan-stops");

    tanXhr = $.ajax({url:"http://api.naonod.com/pois/"+poi.id+"", 
          success:function(data, textStatus, xhr) {
            var htmlElement = processTanInfos(JSON.parse(data));
            tanContainer.html(htmlElement);
          }});
}

function closeDescription() {
  $("#description").hide("slide", {direction:"down"}, 500);
}

function showDragMessage() {
}

//show the popup of the details of the activity (time, tan stops, descriptions ...)
function showDetails(timelineActivity) {
}

function showAjaxLoader(containerId) {
  var cl = new CanvasLoader(containerId);
  cl.setColor('#a8a8a8'); // default is '#000000'
  cl.setShape('spiral'); // default is 'oval'
  cl.setDiameter(36); // default is 40
  cl.setDensity(30); // default is 40
  cl.setSpeed(1); // default is 2
  cl.setFPS(25); // default is 24
  cl.show(); // Hidden by default
}

function processTanInfos(tanInfos) {
  var htmlElement = document.createElement("span");
  var hiddenSpan = document.createElement("span");
  hiddenSpan.style.display = "none";
  for(var i in tanInfos) {
    var info = tanInfos[i];
    var stop = document.createElement("p"); 
    var lines = document.createElement("p"); 
    stop.innerHTML = info.libelle + " à " + info.distance;
    for (var j in info.ligne) {
      var ligne = info.ligne[j];
      lines.innerHTML += ligne.numLigne+" ";
    }
    if(i == "0") {
      htmlElement.appendChild(stop);
      htmlElement.appendChild(lines);
    } else {
      hiddenSpan.appendChild(stop);
      hiddenSpan.appendChild(lines);
    }
  }
  htmlElement.appendChild(hiddenSpan);
  return htmlElement;
}

function initMap() {
    var url = 'http://a.tiles.mapbox.com/v3/xionox.map-ef0s39bd.jsonp';
    map = new L.Map('mapbox')  // container's id="mapbox"
    .setView(new L.LatLng(47.215, -1.541), 13);
    document.getElementById("mapbox").addEventListener("click", function(evt) {
        deselectCurrentMarker(true);
    }, false);
    wax.tilejson(url, function(tilejson) {
        map.addLayer(new wax.leaf.connector(tilejson));
    });
}


// Should only play on the displaying of the time form
function addCurrentPoiInTimeline() {
  if(currentMarker != null) {
  }
}

function deselectCurrentMarker(b_closeDescription) {
  if (currentMarker != null) {
    currentMarker.setIcon(iconForPoi(currentMarker.poi));
    currentMarker = null;
  }
  if(b_closeDescription) closeDescription();
}

/*function createTimelinePOIObject(){
  var timeDebutInput = document.getElementsByName("begin-time")[0].value;
  var timeEndInput = document.getElementsByName("end-time")[0].value;
  timeline.addActivity(currentMarker.poi, timeDebutInput, timeEndInput);
  
}*/

$(document).ready(
  function() {
    // bind all the form where the data-remote is setted with an ajax request
    $('form[data-remote]').ajaxForm(ajaxFormOptions);
    $('.filter-button').each(function(index, buttonElement) {
      buttonElement.addEventListener("click", function(evt) {
        checkboxName = this.id.match(/filter-(.*)/)[1];
        var cb = $("#filter-form :input[name='"+checkboxName+"']")[0];
        cb.checked = !cb.checked; 
        cb.checked ? this.classList.add("selected") : this.classList.remove("selected");
      }, false);
    });

    $(".left-drawer h3").each(function(index, element) {
      element.addEventListener("click", function(event) { openLeftDrawer(this.parentNode); }, false);
    });

    openFilters();
    
    timeline.init({containerId:"timeline-hours-list"});
    timeline.display();

    //adding the dropping event on the timeline
    var timelineDiv = document.getElementById("timeline-content");
    timelineDiv.addEventListener("drop", function(e) { e.preventDefault(); alert("TODO"); return false; }, false); 
    timelineDiv.addEventListener("dragover", function(e) { e.preventDefault(); }, false); 
    /***** MAP *******/
    initMap();
  }
);
