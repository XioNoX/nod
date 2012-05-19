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
                    //console.log(activity);
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
    var editing = bool_editing || bool_editing == undefined;
    if(this.droppingTimeContainer == null) return;
    if (editing) {
      this.droppingTimeContainer.classList.add("editing")
    } else {
      this.droppingTimeContainer.classList.remove("editing")
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
    this.activities.push(lclPoi);

    if(typeof localStorage != 'undefined'){
      localStorage.setItem("userActivities", JSON.stringify(this.activities));
     /*var poiToStore = JSON.stringify(lclPoi);
     console.log(poiToStore);
     localStorage.setItem('poi'+localStorage.length,poiToStore);
     console.log(localStorage.length);*/
    } else {
      console.log("cannot save to local storage");
    }
    this.displayActivity(lclPoi);
  },

  deleteActivity:function(activity) {
    var index = this.activities.indexOf(activity);
    if(index != -1) { 
      this.activities.splice(index, 1);
      this.clear();
      this.display();
    }
    localStorage.setItem("userActivities", JSON.stringify(this.activities));

    /*var found = false;
    var i = 0;
    while(!found && i < localStorage.length){
      var key = localStorage.key(i);
      var currentItem = JSON.parse(localStorage.getItem(key));
      if(currentItem.poi.label == activity.poi.label && currentItem.beginTime == activity.beginTime){
        localStorage.removeItem(key);
        found = true;
      } else {
        i++;
      }
    }*/
  },
  
  getElementsFromLocalStorage:function() {
    if(typeof localStorage == 'undefined') return false;
    this.activities = JSON.parse(localStorage.getItem("userActivities"));
    if (this.activities == null) this.activities = [];
      /*console.log(localStorage,length);
      if(localStorage.length > 0){
        var count = 0;
        var i = 0;
        while(count < localStorage.length) {
          curPOI =JSON.parse(localStorage.getItem("poi"+i));
          if (curPOI) {
            this.activities.push(curPOI);
            count++;
          }
          i++;
        }
        return true;
      }*/
  },
};
