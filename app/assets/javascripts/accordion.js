$(function(){
  $('.accordion_title').on('click', function () {
    $(this).next().slideToggle(400);
    $(this).toggleClass('open', 400);
  });
});