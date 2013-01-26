// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

/* for changing link to AJAX link
$(function() {
  $("#knowledges th a, #knowledges .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
});

$(function() {
	$("#knowledges_search").submit(function() {
		$.get(this.action, $(this).serialize(), null, "script");
		console.log(this);
		console.log(this.action);
		console.log($(this).serialize());
		return false;
		});	
});
*/

// AJAX for search
$(function() {
	$("#resources_search input").keyup(function() {
	  $.get($("#resources_search").attr("action"), $("#resources_search").serialize(), null, "script");
	  return false;
	});
});

function add_lesson_to_log (link, user_id, lesson_plantation_id) {
  //http://api.jquery.com/jQuery.ajax/
  console.log(link);
  console.log(link.href);
  console.log(user_id);
  console.log(lesson_plantation_id);

  if (user_id>0)
    {
      var request = $.ajax({
        type: "POST",
        url: "/logs",
        data: { log : { user_id : user_id, lesson_plantation_idn_id: lesson_plantation_id, status : "1" } }
      });
      request.done(function() {
        // xxx - make this a notice, not alert
        alert("Added to to-do list.");
      });
    } 
  else
    {
      window.location = "/sign_up";
      // xxx - how to pass parameter lesson_plantation_id with window.location
      //alert("Log in or create account to save item to to-do list.");
    };
}

// auto focus on search field on load
$(function() {
	$("#search_field").focus();
});

function add_knowledge_to_log (link, user_id, knowledge_id) {
  //http://api.jquery.com/jQuery.ajax/
  console.log(link);
  console.log(link.href);
  console.log(user_id);
  console.log(knowledge_id);

  if (user_id>0)
    {
      var request = $.ajax({
        type: "POST",
        url: "/logs",
        data: { log : { user_id : user_id, knowledge_id: knowledge_id, status : "1" } }
      });
      request.done(function() {
        alert("Added to to-do list.");
      });
    } 
  else
    {
      window.location = "/sign_up";
      // xxx - how to pass parameter knowledge_id with window.location
      //alert("Log in or create account to save item to to-do list.");
    };
}

//clickable function for current window change
jQuery(function(){
  jQuery("#home_controller li, #knowledges_controller #lesson_plans td, #knowledges_controller #knowledges td[class='knowledges_title']").click(function() {
    if (jQuery(this).find("a").length > 0) {
      window.location = jQuery(this).find("a").attr("href");
    };
    return false;
  });
});


//clickable function to open show function from home window resource boxes
jQuery(function(){
  jQuery(".clickable").click(function() {
    if (jQuery(this).find("a").length > 0) {
      window.location = jQuery(this).find("a").attr("href");
    };
    return false;
  });
});

//clickable function for new window
jQuery(function(){
  jQuery("").click(function() {
    if (jQuery(this).find("a").length > 0) {
      window.open(jQuery(this).find("a").attr("href"));
    };
    return false;
  });
});

//clickable function for running script - TK
jQuery(function(){
  jQuery("").click(function() {
    if (jQuery(this).find("a").length > 0) {
      window.location = jQuery(this).find("a").attr("href");    
    };
    return false;
  });
});

function remove_fields (link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest("div").hide();
}

function add_knowledge_fields (link, fields) {
  var id = new Date().getTime();
  var reg_exp = new RegExp("new_knowledge", "g");
  $(link).parent().before(fields.replace(reg_exp, id));
}

