$(function(){
  $(".accordion_elements").hide();

  $(".accordion p").on("click", function() {
    $(this).next().slideToggle();
  });
});