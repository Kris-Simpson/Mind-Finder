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

    answers.remove();
    parent.find('.add_answer_link').click();
    parent.find('.add_answer_link').click();
    parent.find('.answer_fields').find('.remove_nested_fields').hide();
  });

  $(document).on('nested:fieldRemoved:answers', function(event){
    var field = event.field;
    var index = $(field).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(field).parents(".question_" + index);
    var value = parent.find(".question_type_select option:selected").val();
    var answers = parent.find(".answer_fields");

    if(answers.length == 3)
      answers.find('.remove_nested_fields').hide();

    if(value == 2 && field.find('.answer_radio').is(':checked')) {
      field.remove();
      parent.find(".answer_radio").first().prop('checked', true);
      return;
    }

    if(answers.length == 2) {
      answers.find('.answer_checkbox').click();
      answers.find('.answer_checkbox').attr('disabled', true);
    }

    field.remove();
  });

  $(document).on('nested:fieldAdded:answers', function(event){
    var field = event.field;
    var index = $(field).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(field).parents(".question_" + index);
    var value = parent.find(".question_type_select option:selected").val();
    var answers = parent.find(".answer_fields");
    var checkboxes = answers.find('.answer_checkbox');
    var radios = answers.find('.answer_radio');
    var radio_checked = answers.find('.answer_radio:checked');

    answers.find('.remove_nested_fields').show();

    if(value == 1) {
      checkboxes.show();
      radios.hide();
    } else {
      checkboxes.hide();
      radios.show();
      radios.attr('name', index);

      if(radio_checked.length == 0)
        radios.first().prop('checked', true);
    }
  });

  $(document).on('nested:fieldAdded:questions', function(event){
    var field = event.field;
    var count = 0;
    var questions = $(".question_fields");

    questions.each(function(){
      for(var i = 0; i < 200; i ++) {
        $(this).removeClass("question_" + i);
      }

      $(this).addClass("question_" + count);
      count ++;
    });

    field.find('.add_nested_fields').click();
    field.find('.add_nested_fields').click();
    field.find('.answer_fields').find('.remove_nested_fields').hide();
  });

  $(document).on('nested:fieldRemoved:questions', function(event){
    event.field.remove();
  });

  $(document).on('click', ".answer_checkbox", function() {
    var index = $(this).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(this).parents(".question_" + index);
    var checkboxes = parent.find(".answer_checkbox");
    var checkboxes_checked = parent.find(".answer_checkbox:checked");

    if(checkboxes_checked.length == checkboxes.length - 1) {
      var lastCheckbox = parent.find(".answer_checkbox:not(:checked)");
      lastCheckbox.attr('disabled', true);
    } else {
      var lastCheckbox = parent.find(".answer_checkbox:not(:checked)");
      lastCheckbox.attr('disabled', false);
    }
  });

  $(document).on('click', "#test-submit", function() {
    alert('Yay!');
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