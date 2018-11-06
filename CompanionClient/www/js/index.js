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

function getUserList(projectId){

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


function displayUserList(results){

  var users = JSON.parse(results); // converting results to JSON object
      display_string ="<table>";

      var len = users.length

       for (i = 0; i <len; i+=3) { 
          for(j=i;j<i+3;j++){
            if(j >=len){
              break;
            }
            display_string = display_string+"<tr>";

            "<a href='HomePage.html?user_id="+users[j].user_id+"' data-ajax='false'>"+
            "<img src='img/"+users[j].photo+"'>"+
            "</a>"
            display_string = display_string+"<td>"
            display_string = display_string+"<a href='HomePage.html?user_id="+users[j].user_id+"' data-ajax='false'>"+
            "<img src='img/"+users[j].photo+"'>"+
            "</a>";
             display_string = display_string+"</td>";
            display_string = display_string +"</tr>";
          }
      }
          
        
      display_string +="</table>";

      alert(display_string);
         $("#UserList").html(display_string);
}

function getUserInfo(userId){

  $.ajax({
    url : URL+'/getUserInfo.php', 
    type : 'GET', 
    data: { user_id:userId } ,
    crossDomain: true, 
    success : function(response){ 
      user = JSON.parse(response)[0];

        $("#user_picture").html("<img src='img/"+user.photo+"/>");
        $("#user_name").html(user.first_name+" "+user.last_name);
        $("#user_gold").html(user.user_gold);
      
    }, error : function(resultat, statut, erreur){
  
      console.log("Error encountered. Could not retrieve details");
    }
  });
};
