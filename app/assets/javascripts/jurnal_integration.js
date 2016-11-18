(function(window){
    'use strict';
    var received_access_token = null;
    function define_integration(){
      var JurnalIntegration = {};
      JurnalIntegration.greet = function(){
        alert("welcome to JurnalIntegration.");
      }
      JurnalIntegration.get_access_token = function(){
        if(sessionStorage.jurnal_access_token != undefined){
          return sessionStorage.jurnal_access_token;
        } 
      }
      return JurnalIntegration;
    }

    function receiveMessage(event)
    {
      if (event.data != null){
        sessionStorage.setItem("jurnal_access_token",event.data);
      }
    }

    //define globally if it doesn't already exist
    if(typeof(JurnalIntegration) === 'undefined'){
      window.JurnalIntegration = define_integration();
    }
    else{
      console.log("Library already defined.");
    }

    if (typeof(Storage) !== "undefined") {
    // Code for localStorage/sessionStorage.
    } else {
      console.log("Your browser does not support localStorage");
    }

    window.addEventListener("message", receiveMessage, false);

})(window);

