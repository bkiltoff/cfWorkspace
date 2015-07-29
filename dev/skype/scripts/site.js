$(function () {
	'use strict';  
	
    $(".menu li a").click(function(){
        var module = this.id;
        if (module=='anonymous-join'||module=='sign-in'||window.skypeWebApp && window.skypeWebApp.signInManager.state() == "SignedIn"){           
            if($(this).hasClass("disable")){
                return;
            }
            loadPage(module);
            $(".menu a").removeClass("selectedNav");
            $(this).addClass("selectedNav");
        }
    });


    function loadPage(module){
        var url = "samples/html/" + module + ".html";
        $.get(url, function(html){
            $(".content").html(html);
        });
    }

});
