//= require creativeterritories/javascripts/jquery.sticky
//= require foundation
//= require moment
//= require fullcalendar
// = require featherlight


$(function(){ $(document).foundation(); });

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
    $.each(data, function (id, option) {
        items.push('<li><a href="#" onClick="alert(\'look for id ' + option.id + '\');">' + option.name + '</a></li>');
    });  
    select.html(items.join(''));
}
