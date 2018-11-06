function getProjectList(){

  $.ajax({
                   url : URL+'/getProjectList.php', // URL of Web Service
                   type : 'GET', //web Service method
                   crossDomain: true, // to enable cross origin resource(CORS) sharing
                   success : function(response){ 
                    // is request is a success, this block is executed
                  
                         displayProjectList(response);
                        
                        }
            ,

                   error : function(resultat, statut, erreur){
                    // in case of error log will be added

                        console.log("Error encountered. Could not retrieve details");

                   }

                });

};

function displayProjectList(results){
  var result_arr = JSON.parse(results); // converting results to JSON object
      display_string ="<select>";
      result_arr.forEach(function(project) {
            display_string += " <option id='"+project.project_id+"'>"+project.project_name+"</option>";
          });
         display_string += " </select>";

         $("#projectList").html(display_string);
}
