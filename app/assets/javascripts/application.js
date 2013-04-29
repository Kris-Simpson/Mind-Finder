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

function formSwitch(form) {
  document.getElementById('sign_in_form').style.display = 'none';
  document.getElementById('sign_up_form').style.display = 'none';
  document.getElementById(form).style.display = 'block';
}

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