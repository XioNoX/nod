var timeline = {
  startTime:null,
  endTime:null,
  activities:[],
  container:null,
  
  //possible options : 
  //containerId:Id of the htmlElement that will contain the timeline
  init:function(options) {
    var existsInDatabase = false;
    //TODO get all the activities in the local database 
    //TODO get the start and end time of the timeline in the database 
    //if there is no timeline in the database
    if (!existsInDatabase) {
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
  },
  
  /**** DISPLAY FUNCTIONS ****/
  display:function() {
    if(!this.container) {return ;}
    $(this.container).html("");
    for(var i in this.activities) {
      var activity = this.activities[i];
      var listElement = document.createElement("li");
      var timeDiv = document.createElement("div");
      var nameDiv = document.createElement("div");
      timeDiv.className = "time";
      nameDiv.className = "name";
      $(timeDiv).html("Time");
      $(nameDiv).html(activity.label);
      listElement.appendChild(timeDiv);
      listElement.appendChild(nameDiv);
      this.container.appendChild(listElement);
    }

  },
  
  addActivity:function(poi) {
    this.activities.push(poi);
    this.display();
  },
};
