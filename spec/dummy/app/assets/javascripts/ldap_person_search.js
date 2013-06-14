$(function() {
  
  // clear search fields and results
  function clearLdapPersonSearchForm() {
    $('#first_name').val('');
    $('#last_name').val('');
    $("#lps-results").empty();
  }
  
  function addHiddenField(link, dataAttribute) {
    $('<input>').attr({
        type: 'hidden',
        id: dataAttribute,
        name: dataAttribute,
        value: link.data(dataAttribute)
    }).appendTo('form');
  }
  // add hidden fields to from coming from data attribute of link
  function addHiddenFields(link) {
    addHiddenField(link, 'js');
    addHiddenField(link, 'http-method');
    addHiddenField(link, 'item-label');
    addHiddenField(link, 'item-url');
  }

  // open search dialog
  $('.ldap-person-search').click(function() {
    $('#lps-modal').modal('show');
    $('#first_name').focus();
    addHiddenFields($(this));
  });
    
  // Clear button
  $('#lps-clear').click(function() {
    clearLdapPersonSearchForm();
  }); 

  // modal shown
  $("#lps-modal").on('show', function() {
    clearLdapPersonSearchForm();
    $("#first_name").focus();
  });
  
  // modal hidden
  $("#lps-modal").on('hide', function() {
    clearLdapPersonSearchForm();
  });
});