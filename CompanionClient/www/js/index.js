

function getProjectList(){

  $.ajax({
    url : URL+'/getProjectList.php', // URL of Web Service
    type : 'GET', //web Service method
    crossDomain: true, // to enable cross origin resource(CORS) sharing
    success : function(response){ 
    // is request is a success, this block is executed
      displayProjectList(response);
    }, error : function(resultat, statut, erreur){
    // in case of error log will be added
      console.log("Error encountered. Could not retrieve details");
    }
  });
};

function displayProjectList(results){
  var result_arr = JSON.parse(results); // converting results to JSON object
      display_string ="";
      result_arr.forEach(function(project) {
            display_string += " <option value='"+project.project_id+"'>"+project.project_name+"</option>";
          });
         $("#projectList").html(display_string);
}

function getUserListByProject(projectId){

  $.ajax({
    url : URL+'/getUserList.php', 
    type : 'GET', 
    data: { project_id:projectId } ,
    crossDomain: true, 
    success : function(response){ 
      displayUserList(response);
    }, error : function(resultat, statut, erreur){
  
      console.log("Error encountered. Could not retrieve details");
    }
  });
};

function getUserList(){

  $.ajax({
    url : URL+'/getUserList.php', 
    type : 'GET', 
    crossDomain: true, 
    success : function(response){ 
      displayUserDropDown(response);
    }, error : function(resultat, statut, erreur){
  
      console.log("Error encountered. Could not retrieve details");
    }
  });
};

function displayUserDropDown(results){
  user_id = localStorage.getItem("user_id");
  alert(user_id);
    var users = JSON.parse(results); // converting results to JSON object
      display_string ="<select id='userList' align='center' style='height: 70px;"+
                      "width: 400px;"+
                      "border: 2px solid #4e88e5;"+
                      "border-radius: 10px;"+
                      "margin-bottom: 10%;"+
                      "margin-top: 5%;"+
                      "color: #4e88e5;"+
                      "text-align: center;'>";

      users.forEach(function(user) {
            if(user.user_id != user_id){
                display_string += " <option value='"+user.user_id+"'>"+user.first_name+ " "+user.last_name+"</option>";
            }
          });

      display_string += "</select>";
      alert(display_string);
         $("#userListDropDown").html(display_string);


}



function displayUserList(results){

  var users = JSON.parse(results); // converting results to JSON object
      display_string ="";

      var len = users.length

       for (i = 0; i <len; i+=3) { 
        display_string += "<div class='block clear avatar'>";
          for(j=i;j<i+3;j++){
            if(j >=len){
              break;
            }

            display_string += "<div class='one_third'>"
            display_string += "<div class='clear'><a href='HomePage.html?login=new&user_id="+users[j].user_id+"''><img style='border-radius: 50%' src='img/" + users[j].photo + "'></a></div>"
            // display_string += "    <div class='clear'><img src='../img/" + users[j].photo + "'></div>"
            display_string += "</div>"

            
          }
        display_string += "</div>";
      }
          
      $("#UserList").html(display_string);
      
      var str = "";
      str += "<script type='text/javascript'>";
      str += "  $(document).ready(function(){"
      str += "$('img').click(function(event){"
      str += "        $(this).parent().parent().css('background-color', 'coral');"
      str += "        $(this).parent().parent().parent().siblings().children().css('background-color', '');"
      str += "        $(this).parent().parent().siblings().css('background-color', '');"
      str += "      });"
      str += "});"
      str += "</script>"
      $("body").append(str);
}

function getUserInfo(userId){

  $.ajax({
    url : URL+'/login.php', 
    type : 'GET', 
    data: { user_id:userId } ,
    crossDomain: true, 
    success : function(response){ 
      localStorage.setItem("user_details",response);
      displayUserInfo();
    }, error : function(resultat, statut, erreur){
      console.log("Error encountered. Could not retrieve details");
    }
  });
};


function displayUserInfo(){
    user = JSON.parse(localStorage.getItem("user_details"))[0];

    $("#user_picture").html("<img style='border-radius: 50%' src='img/"+user.photo+"'>");
    $("#user_name").html(user.first_name+" "+user.last_name);
    $("#user_gold").html(user.user_gold);
    $("#user_project").html(user.project_name);
    $("#user_level").html(user.level);
    $("#user_pushed").html("+ "+user.count_pushes);
    $("#user_reviewed").html("+ "+user.count_reviews);
    $("#user_xp_diff").html("+ "+user.xp_diff);

    
};


function shareGold(_from,_to,_amount){

  $.ajax({
    url : URL+'/gold.php', 
    type : 'GET', 
    data: {from:_from,
            to:_to,
            amount:_amount} ,
    crossDomain: true, 
    success : function(response){ 
      alert("Your gold has been transferred");
      $("#currGold").html(Number($("#currGold").html())-Number(_amount));
    }, error : function(resultat, statut, erreur){
      console.log("Error encountered. Could not retrieve details");
    }
  });
};

