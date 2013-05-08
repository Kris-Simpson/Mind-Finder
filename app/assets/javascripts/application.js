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
//= require jquery_nested_form

function formSwitch(form) {
  document.getElementById('sign_in_form').style.display = 'none';
  document.getElementById('sign_up_form').style.display = 'none';
  document.getElementById(form).style.display = 'block';
}

$(function() {
  $("div .destroy_link").hover(
    function() {
      $(this).parent().animate({ "margin-right" : "-5px" }, 200);
    },
    function() {
      $(this).parent().animate({ "margin-right" : "0px" }, 200);
    }
  );

  $("div .edit_link").hover(
    function() {
      $(this).parent().animate({ "margin-right" : "5px" }, 200);
    },
    function() {
      $(this).parent().animate({ "margin-right" : "0px" }, 200);
    }
  );

  $("#content .block .name").hover(
    function() {
      $(this).animate({ "opacity" : "0.8" }, 200);
    },
    function() {
      $(this).animate({ "opacity" : "1" }, 200);
    }
  );

  $(document).on('change', ".question_type_select", function() {
    var index = $(this).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(this).parents(".question_" + index);
    var answers = parent.find(".answer_fields");
    var add_answer_link = parent.find(".add_answer_link");

    if(this.value == "2") {
      var i = 0;
      answers.each(function() {
        $(this).remove();
      });
      add_answer_link.click();
      add_answer_link.click();

      answers = parent.find(".answer_fields");
      answers.find('input[type=text]').first().val('Yes');
      answers.find('input[type=text]').last().val('No');

      answers.each(function() {
      $(this).find(".remove_nested_fields").remove();
        $(this).find("input[type=text]").attr('readonly', true);
      });

      add_answer_link.hide();
    }
    else {
      answers.each(function() {
        $(this).remove();
      });
      add_answer_link.show();
    }
  });
});

$(function(){
  $('#rooms').tree();
});

$(function(){
  $("#slides").slidesjs({
    play: {
      active: false,
      effect: "fade",
      interval: 5000,
      auto: true,
      swap: true,
      pauseOnHover: false,
      restartDelay: 2500
    },
    pagination: {
      active: true,
      effect: "fade"
    }
  });
});