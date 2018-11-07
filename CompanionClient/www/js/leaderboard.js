

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
  alert(results);
  var result_arr = JSON.parse(results); // converting results to JSON object
  display_string ="";
   var rank = 1;
  result_arr.forEach(function(user) {
        display_string = display_string+ "<div class='block clear' style='margin-top: 3%'>"+
                        "<div class='block clear' style=''>"+
                        "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 130%; font-weight: bold;color: #ffae23;'>"+
                        "<div class='clear'>"+rank+"</div>"+
                        "</div>"+
                        "<div class='two_quarter' style=''>"+ 
                        "<div class='clear'><img src='img/"+user.photo+"' style='width: 25%;'><span style='margin-left: 13%;''>"+user.first_name+"</span></div>"+
                        "</div>"+
                        "<div class='one_quarter' style='text-align: center; margin-top: 3%;'>"+
                        "<div class='clear'>"+user.level+"</div>"+
                        "</div>"+
                        "</div>"+
                        "</div>"+
                        "<hr>";
      rank++;
  });
                
  $("#leaderboard_div").html(display_string);
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
  result_arr.forEach(function(user) {
        display_string = display_string+ "<div class='block clear' style='margin-top: 3%'>"+
                          "<div class='block clear ' style=''>"+
                          "<div class='one_quarter' style='text-align: center; margin-top: 2%; font-size: 130%; font-weight: bold;color: #ffae23;'>"+
                          "<div class='clear'>"+rank+"</div>"+
                          "</div>"+
                          "<div class='two_quarter' style=''> "+
                          "<div class='clear'><img src='img/"+user.photo+"' style='width: 25%;'><span style='margin-left: 13%;'>"+user.first_name+"</span></div>"+
                          "</div>"+
                          "<div class='one_quarter' style='text-align: center; margin-top: 3%;'>"+
                          "<div class='clear'>"+user.diff+"</div>"+
                          "</div>"+
                          "</div>"+
                          "</div>"+
                          "<hr>"
      rank++;
  });
                
  $("#resultsboard_div").html(display_string);
}
