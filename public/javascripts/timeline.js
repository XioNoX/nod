var timeline = {
  startTime:null,
  endTime:null,
  activities:[],
  container:null,
  droppingTimeContainer:null,
  
  //possible options : 
  //containerId:Id of the htmlElement that will contain the timeline
  init:function(options) {
    var existsInDatabase = false;
    //TODO get all the activities in the local database 
    // DEBUG
    //localStorage.clear();
    existsInDatabase = this.getElementsFromLocalStorage();
    if (true || !existsInDatabase) { //XXX
      this.startTime = new Date();
      this.startTime.setHours(0);
      this.startTime.setMinutes(0);
      this.startTime.setSeconds(0);

      this.endTime = new Date();
      this.endTime.setHours(23);
      this.endTime.setMinutes(0);
      this.endTime.setSeconds(0);
    }
    this.container = options["containerId"] ? document.getElementById(options["containerId"]) : null;
    this.droppingTimeContainer = options["droppingTimeContainerId"] ? document.getElementById(options["droppingTimeContainerId"]) : null;
    this.displayBackground();
  },
  
  /**** DISPLAY FUNCTIONS ****/
  //display the empty timeline with a padding each 30 min
  displayBackground:function() {
    if(!this.container) {return ;}
    $(this.container).html("");
    for(var i =this.startTime.getHours(); i <= this.endTime.getHours(); i++) {
      var divElement = document.createElement("div");
      divElement.setAttribute("data-starttime", i);
      divElement.setAttribute("data-endtime", i+1);
      divElement.addEventListener("drop", function(e) { 
        e.preventDefault(); 
      }, false); 
      divElement.addEventListener("dragover", function(e) { 
        e.preventDefault(); 
        var startTime = this.getAttribute("data-starttime");
        var droppingTimeContainer = timeline.droppingTimeContainer;
        if(!droppingTimeContainer) return;
        var settedStartTime = droppingTimeContainer.getAttribute("data-starttime");
        if(settedStartTime == startTime) return;
        droppingTimeContainer.setAttribute("data-starttime", startTime);
        $(droppingTimeContainer).html("Ajouter l'activité à "+startTime+"h");
      }, false); 
      $(divElement).html(i+"h");
      divElement.className = "hour-marker";
      this.container.appendChild(divElement);
    }
  },

  displayActivity:function(activity) {
    var hourContainer = $(".hour-marker[data-starttime="+activity.beginTime+"]");
    var activityDiv = document.createElement("div");
    var deleteSpan = document.createElement("span");
    deleteSpan.innerHTML = "×";
    deleteSpan.className = "delete";
    deleteSpan.addEventListener("click", function(evt) { 
      timeline.deleteActivity(activity);
    });
    activityDiv.className = "activity";
    activityDiv.addEventListener("click", function(evt) {
      showDetails(activity);
    });
    activityDiv.innerHTML = activity.poi.label;
    activityDiv.appendChild(deleteSpan);
    hourContainer.append(activityDiv);
  },
 
  display:function() {
    if(!this.container) {return ;}
    this.clear();
    for(var i in this.activities) {
      var activity = this.activities[i];
      this.displayActivity(activity);
    }
  },

  clear:function() {
    $(this.container).find(".activity").remove();
  },
  /*display:function() {
    if(!this.container) {return ;}
    //$(this.container).html("");
    for(var i in this.activities) {
      var activity = this.activities[i];
      var listElement = document.createElement("div");
      var timeDiv = document.createElement("div");
      var nameDiv = document.createElement("div");
      timeDiv.className = "time";
      nameDiv.className = "name";
      $(timeDiv).html(activity.beginTime+"h - "+activity.endTime+" h");
      $(nameDiv).html(activity.label);
      listElement.appendChild(timeDiv);
      listElement.appendChild(nameDiv);
      this.container.appendChild(listElement);
    }

  },*/


  setEditing:function(bool_editing) {
     alert("TODO");
    var editing = bool_editing || bool_editing == undefined;
    this.container.className = editing ? "editing" : "";
    var hourMarkers = $(".hour-marker");
    hourMarkers.unbind("click");
    if (editing) {
      hourMarkers.click(function(evt) {
        var start = this.getAttribute("data-starttime");
        var end = this.getAttribute("data-endtime");
        timeline.addActivity(currentMarker.poi, start, end);
      });
    }
  },
  
  addActivity:function(poi,_beginTime, _endTime) {
    if(_beginTime == undefined && this.droppingTimeContainer) {
      _beginTime = this.droppingTimeContainer.getAttribute("data-starttime");
    }
    var lclPoi = {
      "poi" : poi,
      "beginTime" : _beginTime,
      "endTime" : _endTime
    };
    if(typeof localStorage != 'undefined'){
     var poiToStore = JSON.stringify(lclPoi);
     console.log(poiToStore);
     
     localStorage.setItem('poi'+localStorage.length,poiToStore);
     console.log(localStorage.length);
   } else {
     alert('Monsieur vous devriez penser a changer de navigateur!!');
   }
    
    this.activities.push(lclPoi);
    this.displayActivity(lclPoi);
    this.setEditing(false);
  },

  deleteActivity:function(activity) {
    var index = this.activities.indexOf(activity);
    console.log(index);
    if(index != -1) { 
      // Remove the item from the localstorage
      var poiToDelete = localStorage.key(index);
      localStorage.removeItem(poiToDelete);
      
      this.activities.splice(index, 1);
      this.clear();
      this.display();
    }
  },
  
  getElementsFromLocalStorage:function() {
    if(typeof localStorage != 'undefined'){
      console.log(localStorage,length);
      if(localStorage.length > 0){
        for(var i=0;i<localStorage.length;i++){
          //console.log(localStorage.getItem("poi"+i));
          curPOI =JSON.parse(localStorage.getItem("poi"+i));
          this.activities.push(curPOI);
        }
        return true;
      }
      return false;
    }
  },
};
