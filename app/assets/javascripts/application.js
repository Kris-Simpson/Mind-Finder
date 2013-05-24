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
  
  $(document).on('input', 'input[type=range]', function() {
    $(this).parent().find('span').text($(this).val());
    if($(this).is('.max')) {
      $(this).parent().parent().find('.min').attr('max', $(this).val()).val(0).parent().find('span').text('0');
    }
  });
  
  $(document).on('click', '#start_test_button', function() {
    $(this).hide();
    $('.question_button').attr('disabled', false);
    $('.question_button').first().click();
    
    var time = parseInt($('#question_buttons p span').text());
    $('#question_buttons p span').everyTime('1s', function(i) {
      $(this).text(time);
      time--;
      
      if(time < 0) {
        alert('Yay!');
        $(this).stopTime();
      }
    });
  });

  $(document).on('nested:fieldRemoved:answers', function(event){
    var field = event.field;
    var index = $(field).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(field).parents(".question_" + index);
    var answers = parent.find(".answer_fields:visible");
    
    var ranges = parent.find('input[type=range]');
    
    ranges.filter('.max').attr('max', answers.length).val(0).parent().find('span').text('0');
    ranges.filter('.min').val(0).parent().find('span').text('0');
  });

  $(document).on('nested:fieldAdded:answers', function(event){
    var field = event.field;
    var index = $(field).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    parent = $(field).parents(".question_" + index);
    
    parent.find('input[type=range]').filter('.max').attr('max', $(parent).find('.answer_fields:visible').length);
  });

  $(document).on('nested:fieldAdded:questions', function(event){
    var field = event.field;
    var count = 0;
    var questions = $(".question_fields:visible");
    var answers = $(field).find('.answer_fields');

    questions.each(function(){
      for(var i = 0; i < 200; i ++) {
        $(this).removeClass("question_" + i);
      }

      $(this).addClass("question_" + count);
      count ++;
    });

    $('#test_max_shewn_questions').attr('max', questions.length);
  });
  
  $(document).on('nested:fieldRemoved:questions', function(event) {
    var questions = $(".question_fields:visible");
    $('#test_max_shewn_questions').attr('max', questions.length).parent().find('span').text('0');
  });
});

$(function() {
  $('#submenu').tree();
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