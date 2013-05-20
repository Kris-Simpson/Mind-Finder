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
  
  // $(document).on('click', '#minus, #plus', function() {
  //   var inputField = $('#' + $(this).attr('class'));
  //   var min = parseInt(inputField.attr('min'));
  //   var max = parseInt(inputField.attr('max'));
  //   var value = parseInt(inputField.val(), 10);
    
  //   if(isNaN(value)) { value = 0; }
    
  //   if($(this).is('#minus')) {
  //     if(!isNaN(min)) { value -= value > min ? 1 : 0; }
  //     else { value--; }
  //   } else {
  //     if(!isNaN(max)) { value += value < max ? 1 : 0; }
  //     else { value++; }
  //   }
        
  //   inputField.val(value);
  // });
  
  // $(document).on('blur', '.type-number', function() {
  //   var value = parseInt($(this).val());
    
  //   if(isNaN(value)) { $(this).val(0); }
  //   else {
  //     min = parseInt($(this).attr('min'));
  //     max = parseInt($(this).attr('max'));
      
  //     if(!isNaN(min) && !isNaN(max)) {
  //       if(value >= min && value <= max) { $(this).val(value); } else { $(this).val(min); }
  //     } else if(isNaN(min) && isNaN(max)) { $(this).val(value); }
  //     else if(!isNaN(min) && isNaN(max)) {
  //       if(value >= min) { $(this).val(value); } else { $(this).val(min); }
  //     } else if(isNaN(min) && !isNaN(max)) {
  //       if(value <= max) { $(this).val(value); } else { $(this).val(max); }
  //     }
  //   }
  // });

  $(document).on('change', ".question_type_select", function() {
    var index = $(this).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(this).parents(".question_" + index);
    var value = parent.find(".question_type_select option:selected").val();
    var answers = parent.find(".answer_fields");
    var add_link = parent.find('.add_answer_link');

    answers.remove();

    if(value == 1) {
      add_link.click();
      add_link.click();
      add_link.click();

      answers = parent.find(".answer_fields");
      answers.first().find('.answer_checkbox').prop('checked', true);
      answers.first().find('.answer_checkbox').prop('disabled', true);
    } else {
      add_link.click();
      add_link.click();
    }
    parent.find('.answer_fields').find('.remove_nested_fields').hide();
  });

  $(document).on('nested:fieldRemoved:answers', function(event){
    var field = event.field;
    var index = $(field).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(field).parents(".question_" + index);
    var value = parent.find(".question_type_select option:selected").val();
    var answers = parent.find(".answer_fields:visible");
    var checkboxes_checked = answers.find('.answer_checkbox:checked');
    var checkboxes_not_checked = answers.find('.answer_checkbox:not(:checked)');

    if(value == 1 && answers.length == 3) {
      answers.find('.remove_nested_fields').hide();

      if(checkboxes_checked.length == 1)
        checkboxes_checked.prop('disabled', true);
      else if(checkboxes_checked.length == 2)
        checkboxes_not_checked.prop('disabled', true);
      else if(checkboxes_checked.length == 3) {
        checkboxes_checked.last().prop('checked', false).prop('disabled', true);
      }
    } else if(value == 2 && answers.length == 2)
      answers.find('.remove_nested_fields').hide();

    if(value == 2 && field.find('.answer_radio').is(':checked')) {
      parent.find(".answer_radio:visible").first().prop('checked', true);
      return;
    }
    
    var ranges = parent.find('input[type=range]');
    
    ranges.filter('.max').attr('max', answers.length).val(0).parent().find('span').text('0');
    ranges.filter('.min').val(0).parent().find('span').text('0');
  });

  $(document).on('nested:fieldAdded:answers', function(event){
    var field = event.field;
    var index = $(field).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(field).parents(".question_" + index);
    var value = parent.find(".question_type_select option:selected").val();
    var answers = parent.find(".answer_fields:visible");
    var checkboxes = answers.find('.answer_checkbox');
    var checkboxes_checked = answers.find('.answer_checkbox:checked');
    var radios = answers.find('.answer_radio');
    var radio_checked = answers.find('.answer_radio:checked');

    answers.find('.remove_nested_fields').show();

    if(value == 1) {
      checkboxes.show();
      radios.hide();
      if(checkboxes_checked.length > 1)
        checkboxes.prop('disabled', false);
    } else {
      checkboxes.hide();
      radios.show();
      radios.attr('name', index);

      if(radio_checked.length == 0)
        radios.first().prop('checked', true);
    }
    
    parent.find('input[type=range]').filter('.max').attr('max', answers.length);
  });

  $(document).on('nested:fieldAdded:questions', function(event){
    var field = event.field;
    var count = 0;
    var questions = $(".question_fields");
    var answers = $(field).find('.answer_fields');
    var add_link = field.find('.add_nested_fields');

    questions.each(function(){
      for(var i = 0; i < 200; i ++) {
        $(this).removeClass("question_" + i);
      }

      $(this).addClass("question_" + count);
      count ++;
    });

    add_link.click();
    add_link.click();
    add_link.click();

    var answers = field.find(".answer_fields");
    answers.first().find('.answer_checkbox').prop('checked', true);
    answers.first().find('.answer_checkbox').prop('disabled', true);

    field.find('.answer_fields').find('.remove_nested_fields').hide();

    $('#test_max_shewn_questions').attr('max', questions.length);
    $('#test_min_shewn_questions').attr('max', $('#test_max_shewn_questions').val());
    field.find('input[type=range]').filter('.max').attr('max', answers.length);
  });
  
  $(document).on('nested:fieldRemoved:questions', function(event) {
    var questions = $(".question_fields:visible");
    $('#test_max_shewn_questions').attr('max', questions.length).parent().find('span').text('0');
  });

  $(document).on('click', ".answer_checkbox", function() {
    var index = $(this).parents(".question_fields").attr('class');
    index = index.substring(index.length - 1);
    var parent = $(this).parents(".question_" + index);
    var checkboxes = parent.find(".answer_checkbox:visible");
    var checkboxes_checked = parent.find(".answer_checkbox:checked:visible");

    if(checkboxes_checked.length > 1)
      checkboxes_checked.prop('disabled', false);
    else if(checkboxes_checked.length == 1)
      checkboxes_checked.prop('disabled', true);

    if(checkboxes_checked.length == checkboxes.length - 1) {
      var lastCheckbox = parent.find(".answer_checkbox:not(:checked):visible");
      lastCheckbox.prop('disabled', true);
    } else {
      var lastCheckbox = parent.find(".answer_checkbox:not(:checked):visible");
      lastCheckbox.attr('disabled', false);
    }
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