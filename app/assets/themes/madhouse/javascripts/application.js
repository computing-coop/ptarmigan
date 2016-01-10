//= require jquery2
//= require jquery_ujs
//= require jquery-ui/core
//= require jquery-ui/tabs
//= require jquery.slick
//= require moment
//= require fullcalendar
//= require 'foundation/foundation' 
//= require foundation
//= require rails-timeago
//= require locales/jquery.timeago.fi.js


$(document).foundation();

jQuery.timeago.settings.strings["sv-SE"] = {
  prefixAgo: "för",
    prefixFromNow: "om",
    suffixAgo: "sedan",
    suffixFromNow: "",
    seconds: "mindre än en minut",
    minute: "ungefär en minut",
    minutes: "%d minuter",
    hour: "ungefär en timme",
    hours: "ungefär %d timmar",
    day: "en dag",
    days: "%d dagar",
    month: "ungefär en månad",
    months: "%d månader",
    year: "ungefär ett år",
    years: "%d år"
};