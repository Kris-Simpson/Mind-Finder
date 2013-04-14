$(document).ready(function() {
  var selectBox = $(".selectbox");
  var divSelect = selectBox.find('div.select');
  var divText = selectBox.find('div.text');
  var dropdown = selectBox.find('div.dropdown');
  var li = dropdown.find('li');

  /* .select click */
  divSelect.click(function() {
    $('div.selectbox').css({zIndex: 1}).removeClass('focused');
    selectBox.css({zIndex: 2});

    if (dropdown.is(':hidden')) {
      $('div.dropdown:visible').hide();
      dropdown.slideDown(200);
    }
    else {
      dropdown.fadeOut(200);
    }
    return false;
  });

  /* .dropdown li hover */
  li.hover(function() {
    $(this).siblings().removeClass('selected');
  });
  var selectedText = li.filter('.selected').text();

  /* .dropdown mouseleave */
  dropdown.mouseleave(function() {
    dropdown.fadeOut(200);
  });

  $(document).on('click', function(e) {
    if (!$(e.target).parents().hasClass('selectbox')) {
      dropdown.fadeOut(200);
    }
  });
});