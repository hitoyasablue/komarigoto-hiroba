$(function(){
  $(".accordion_elements").hide();

  $(".accordion .accordion_title").on("click", function() {
    $(this).next().slideToggle();
  });
});