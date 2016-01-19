//= require jquery2
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery-ui/tabs
//= require jquery.slick
//= require jquery.clearfield
//= require moment
//= require fullcalendar
//= require fullcalendar/lang-all
//= require 'foundation/foundation' 
//= require foundation
//= require rails-timeago
//= require locales/jquery.timeago.fi.js
//= require locales/jquery.timeago.sv.js
//= require jquery.infinite-pages
//= require madhouse/javascripts/calendar

$(document).foundation();

function toggleCalendar() {

  if ( jQuery('#calendar_container').css("left") == "0px")  {
    jQuery('#calendar_container').animate({left:"-85%"}, 600);
    jQuery('#calendar_container').animate({top: parseInt($('#container').offset().top) + 'px' }, 600);

    jQuery('#calendar_container').css('position', 'fixed');
  } else {
    
    var eTop = $('#calendar_container').offset().top; 
    jQuery('#calendar_container').css('position', 'absolute');
    jQuery('#calendar_container').css('top', parseInt(eTop) + 'px'); 
        jQuery('#calendar_container').animate({left:"0%"}, 100);
  }

}