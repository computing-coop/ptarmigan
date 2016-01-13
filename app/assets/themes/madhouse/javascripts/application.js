//= require jquery2
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery-ui/tabs
//= require jquery.slick
//= require moment
//= require fullcalendar
//= require fullcalendar/lang/fi
//= require fullcalendar/lang/sv
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
    jQuery('#calendar_container').animate({left:"-85%"}, 100);
  } else {
    jQuery('#calendar_container').animate({left:"0%"}, 100);
  }

}