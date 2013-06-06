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
//= require twitter/bootstrap
//= require_tree .
//= require jquery_nested_form
//= require bootstrap-timepicker
//= require bootstrap-modal
//= require bootstrap-modalmanager

function formSwitch(form) {
  document.getElementById('sign_in_form').style.display = 'none';
  document.getElementById('sign_up_form').style.display = 'none';  
  document.getElementById(form).style.display = 'block';
}

function changePagination() {
  $('.pagination').append('<ul></ul>');
  
  if($('.pagination span').is('.previous_page')) {
    $('.pagination ul').append('<li class="disabled"><a href="#">' + $('.pagination span').text() + '</a></li>');
    $('.pagination span').remove();
  }
  
  $('.pagination').find('a, em').each(function() {
    if(!$(this).parent().is('.disabled')) {
      if($(this).is('.current')) {
        $(this).parent().find('ul').append('<li class="active"><a href="#">' + $(this).text() + '</a></li>');
      } else {
        $(this).parent().find('ul').append('<li><a href=' + $(this).attr('href') + ' data-remote="true">' + $(this).text() + '</a></li>');
      }
      
      $(this).remove();
    }
  });
  
  if($('.pagination span').is('.next_page')) {
    $('.pagination ul').append('<li class="disabled"><a href="#">' + $('.pagination span').text() + '</a></li>');
    $('.pagination span').remove();
  }
}

$(function() {
  $('html, body').height($('html, body').height() - $('footer').height() - $('#navigation_bar').height());
  
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
  
  
  var time = parseFloat($('#question_buttons p span').text());
  if(!isNaN(time)) { $('#question_buttons p span').text(time * 60); }
  $(document).on('click', '#start_test_button', function() {
    $(this).hide();
    $('.question_button').attr('disabled', false);
    $('.question_button').first().click();
    
    if(!isNaN(time)) {
      time *= 60;
      $('#question_buttons p span').everyTime('1s', function(i) {
        $(this).text(time);
        time--;
        
        if(time < 0) {
          alert('Yay!');
          $(this).stopTime();
        }
      });
    }
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
  
  $('.breadcrumb').css({ 'padding-left' : parseInt($('#left-side').width()) + parseInt($('#right-side').css('marginLeft')) });
  window.onresize = function() {
    $('.breadcrumb').css({ 'padding-left' : parseInt($('#left-side').width()) + parseInt($('#right-side').css('marginLeft')) });
  }
  
  $(document).on('click', '.destroy_link', function() {
    $('.delete_link').attr('href', $(this).attr('data-url'));
  });
});

$(function() {
  $('#submenu').tree();
});

$(document).ready(function($) {
  $('#slideshow').bjqs({
    width: 600,
    height: 368,
    animtype: 'slide',
    animduration: 1000,
    animspeed: 5000,
    nexttext : 'Next',
    prevtext : 'Prev',
    showcontrols: false
  });
});

$(function() {
  $('.timepicker').timepicker({
    defaultTime: false,
    minuteStep: 1,
    showSeconds: true,
    showMeridian: false
  });
});