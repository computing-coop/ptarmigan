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
