var timeline = {
  startTime:null,
  endTime:null,
  activities:[],
  container:null,
  backgroundContainer:null,
  
  //possible options : 
  //containerId:Id of the htmlElement that will contain the timeline
  init:function(options) {
    var existsInDatabase = false;
    //TODO get all the activities in the local database 
    // DEBUG
    //localStorage.clear();
    existsInDatabase = this.getElementsFromLocalStorage();
    //TODO get the start and end time of the timeline in the database 
    //if there is no timeline in the database
    if (true || !existsInDatabase) { //XXX
      this.startTime = new Date();
      this.startTime.setHours(8);
      this.startTime.setMinutes(0);
      this.startTime.setSeconds(0);

      this.endTime = new Date();
      this.endTime.setHours(20);
      this.endTime.setMinutes(0);
      this.endTime.setSeconds(0);
    }
    if(options["containerId"]) {
      this.container = document.getElementById(options["containerId"]);
    }
    this.backgroundContainer = options["backgroundContainerId"] ? document.getElementById(options["backgroundContainerId"]) : null;
    this.displayBackground();
  },
  
  /**** DISPLAY FUNCTIONS ****/
  //display the empty timeline with a padding each 30 min
  displayBackground:function() {
    if(!this.backgroundContainer) {return ;}
    $(this.backgroundContainer).html("");
    for(var i =this.startTime.getHours(); i <= this.endTime.getHours(); i++) {
      var divElement = document.createElement("div");
      $(divElement).html(i+"h");
      divElement.className = "hour-marker";
      this.backgroundContainer.appendChild(divElement);
    }
  },

  display:function() {
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

  },

  setEditing:function() {
    this.backgroundContainer.className = "editing";
  },
  
  addActivity:function(poi,_beginTime, _endTime) {
    var lclPoi = {
      "label" : poi.label,
      "description" : poi.description,
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
    this.display();
  },
  
  getElementsFromLocalStorage:function() {
    if(typeof localStorage != 'undefined'){
      console.log(localStorage,length);
      if(localStorage.length > 0){
	for(var i=0;i<localStorage.length;i++){
	  console.log(localStorage.getItem("poi"+i));
	  curPOI =JSON.parse(localStorage.getItem("poi"+i));
	  this.activities.push(curPOI);
	}
      this.display();
      return true;
      }
     return false;
    }
  },
};
