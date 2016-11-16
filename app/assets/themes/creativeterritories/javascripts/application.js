//= require creativeterritories/javascripts/jquery.sticky
//= require foundation
//= require moment
//= require fullcalendar
// = require featherlight


$(function(){ $(document).foundation();  });

function miniTitle(view, element) {
  element.find('.fc-toolbar .fc-center').each(function() {
    var theDate = moment($(this).data('date')); /* th.data-date="YYYY-MM-DD" */
    $(this).html(buildminiTitleHeader(theDate));
  });
}

function buildminiTitleHeader(theDate) {
    var container = document.createElement('div');
    var DDD = document.createElement('div');
    var ddMMM = document.createElement('div');
    DDD.textContent = theDate.format('YYYY');
    ddMMM.textContent = theDate.format('MMMM');
    DDD.className = "ct-day";
    container.appendChild(DDD);
    container.appendChild(ddMMM);
    return container;
}

function populateCTFilters(select, data) {
  var items = [];
  var active = [];
  $.each(data, function (id, option) {
     items.push('<li><a href="#" class="active" data-state="enabled" data-ct-filter="' + option.id + '">' + option.name + '</a></li>');
  });
  select.html(items.join(''));
  setFilters();
}

var dontcallback = 0;

function setFilters() {
  $('ul#other_venues li a').click(function() {
      
      var choice = $(this);
      var filter_by = $(this).attr('data-ct-filter');
      var state = choice.attr('data-state');
      
      if (state == 'disabled') {
        choice.attr('data-state', 'enabled');
        choice.addClass('active');
      
        $('#calendar').fullCalendar('refetchEvents');
        dontcallback = 1;
      } else if (state == 'enabled') {
        choice.attr('data-state', 'disabled');
        choice.removeClass('active');
   
        $('ul#other_venues li a[data-state="disabled"]').map(function() {
          var t = $(this).attr('data-ct-filter');
          
          $('#calendar').fullCalendar('removeEvents', function(event) {
            //alert('event is ' + event.place_id + ' and t is  ' + t);
            return parseInt(event.place_id) == parseInt(t);
          });
        });  
    }
      //$('#calendar').fullCalendar('rerenderEvents');
    });
    
}

var map = null;
var riga = null;
function displayMap() {
    $('#map').slideToggle(function() {
      initialize();
    });
    
}

function initialize() {
  riga = new google.maps.LatLng(56.9496487, 24.1051864);
  var mapOptions = {
    center: riga,
    zoom: 15,
    panControl: true,
    mapTypeControl: false,
    streetViewControl: false,

    zoomControl: true,
    zoomControlOptions: {
      style: google.maps.ZoomControlStyle.LARGE,
     },
    mapTypeId: google.maps.MapTypeId.ROADMAP,
     styles: [ { "elementType": "geometry", "stylers": [ { "color": "#f5f5f5" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f5f5" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "road.arterial", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#dadada" } ] }, { "featureType": "road.highway",     "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#c9c9c9" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] } ]
  };
  
  map = new google.maps.Map(document.getElementById("map"), mapOptions);
  var marker = new google.maps.Marker({
          position: riga,
          map: map,
          optimized: false
        });
}

