// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(function(){
  var preview = $('#text-preview');
  $('.lab_article .mainarea').keyup(function(event) {
    console.log(event.keyCode);
    markDownText = markdown.toHTML($(this).val());
    preview.html(markDownText);
  });
});
