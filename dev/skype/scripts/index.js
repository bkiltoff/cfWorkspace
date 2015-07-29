$(function () {
   'use strict';
       


  function initializeSkypeApi() {
        Skype.initialize({
            apiKey: 'SWX-BUILD-SDK',
        }, function (api) {
            window.skypeWebApp = new api.application();
            //Make sign in table appear
            $(".menu #sign-in").click();

            // whenever client.state changes, display its value
            window.skypeWebApp.signInManager.state.changed(function (state) {
            $('#client_state').text(state);

            });
        }, function (err) {
            alert('some error occurred: ' + err);
        });
    }

  initializeSkypeApi();

});