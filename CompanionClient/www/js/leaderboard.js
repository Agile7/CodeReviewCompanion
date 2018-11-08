

function getUserRanking(){

  $.ajax({
    url : URL+'/getLeaderBoardRanking.php', // URL of Web Service
    type : 'GET', //web Service method
    crossDomain: true, // to enable cross origin resource(CORS) sharing
    success : function(response){ 
    // is request is a success, this block is executed
      displayLeaderboard(response);
    }, error : function(resultat, statut, erreur){
    // in case of error log will be added
      console.log("Error encountered. Could not retrieve details");
    }
  });
};

function displayLeaderboard(results){
  var result_arr = JSON.parse(results); // converting results to JSON object
  display_string ="";
  var rank = 1;

  var user_id = localStorage.getItem("user_id");

  var picture = "generic.png";

  result_arr.forEach(function(user) {
    if(user.photo !=""){
          
          picture = user.photo;

        }
        var user_display ="";

        if(user.user_id ==user_id){
          user_display = user_display+ "<hr><div class='block clear' style='margin-top: 3%'>"+
                        "<div class='block clear' style=''>";
        }
        else{
          user_display = user_display+ "<div class='block clear' style='margin-top: 3%'>"+
                        "<div class='block clear' style=''>";
        }
        

        if(rank == 1){
            user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #ffae23;'>";
        }
        else if(rank==2){
          user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #9eb2b2;'>";

        }
        else if(rank==3){
          user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #7c4803;'>";

        }
        else{
          user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #000;'>";

        }            
        user_display = user_display+ "<div class='clear'>"+rank+"</div>"+
                        "</div>"+
                        "<div class='two_quarter' style=''>"+ 
                        "<div class='clear'><img src='img/"+picture+"' onerror=\"this.src='img/generic.png'\" style='width: 20%;'><span style='margin-left: 13%;''>"+user.first_name+"</span></div>"+
                        "</div>"+
                        "<div class='one_quarter' style='text-align: center; margin-top: 3%;'>"+
                        "<div class='clear'>"+user.level+"</div>"+
                        "</div>"+
                        "</div>"+
                        "</div>"+
                        "<hr>";

      if(user.user_id == user_id){
        $("#user_position_div").html(user_display);

      }
      else{
        display_string +=user_display;
      }
      rank++;
  });
                
  $("#leaderboard_div").html(display_string);
  //document.getElementById("5").focus();
}


function getWeeklyRanking(){

  $.ajax({
    url : URL+'/getWeeklyRanking.php', // URL of Web Service
    type : 'GET', //web Service method
    crossDomain: true, // to enable cross origin resource(CORS) sharing
    success : function(response){ 
    // is request is a success, this block is executed
      displayWeeklyBoard(response);
    }, error : function(resultat, statut, erreur){
    // in case of error log will be added
      console.log("Error encountered. Could not retrieve details");
    }
  });
};


function displayWeeklyBoard(results){
  var result_arr = JSON.parse(results); // converting results to JSON object
  display_string ="";
  var rank = 1;
  var picture = "generic.png";
  var user_id = localStorage.getItem("user_id");
  result_arr.forEach(function(user) {

        var user_display="";
        if(user.photo !=""){
          
          picture = user.photo;

        }

        if(user.user_id == user_id){
        user_display = user_display+ "<hr><div class='block clear' style='margin-top: 3%'>"+
                          "<div class='block clear ' style=''>";
        }
        else{
          user_display = user_display+ "<div class='block clear' style='margin-top: 3%'>"+
                          "<div class='block clear ' style=''>";
        }

        if(rank == 1){
            user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #ffae23;'>";
        }
        
        else if(rank==2){
          user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #9eb2b2;'>";

        }
        else if(rank==3){
          user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #7c4803;'>";

        }
        else{
          user_display = user_display+ "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 100%; font-weight: bold;color: #000;'>";

        } 
        
        user_display = user_display+ "<div class='clear'>"+rank+"</div>"+
                          "</div>"+
                          "<div class='two_quarter' style=''> "+
                          "<div class='clear'><img src='img/"+picture+"' style='width: 20%;'><span style='margin-left: 13%;'>"+user.first_name+"</span></div>"+
                          "</div>"+
                          "<div class='one_quarter' style='text-align: center; margin-top: 3%;'>"+
                          "<div class='clear'>"+user.diff+"</div>"+
                          "</div>"+
                          "</div>"+
                          "</div>"+
                          "<hr>";

    if(user.user_id == user_id){
        $("#user_position_div").html(user_display);

      }
      else{
        display_string +=user_display;
      }
      rank++;
  });
                
  $("#resultsboard_div").html(display_string);
}
