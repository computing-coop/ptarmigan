//= require jquery.ui.datepicker
//= require jquery.ui.tabs
//= require ckeditor/init
//= require jquery_nested_form

// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
Date.format = 'yyyy-mm-dd';
$(function()
{     $('.date-pick').datepicker({ dateFormat: "yy-mm-dd" });
});
function remove_fields(link) {  
    $(link).prev("input[type=hidden]").val("1");  
    $(link).closest(".fields").hide();  
}  
  
function add_fields(link, association, content) {  
    var new_id = new Date().getTime();  
    var regexp = new RegExp("new_" + association, "g");  
    $(link).parent().before(content.replace(regexp, new_id));  
}