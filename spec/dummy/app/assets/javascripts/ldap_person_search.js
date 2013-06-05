$(function() {
  
  // clear search fields and results
  function clearLdapPersonSearchForm() {
    $('#first_name').val('');
    $('#last_name').val('');
    $("#ldap-person-search-results").empty();
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
    $('#ldap-person-search-modal').modal('show');
    $('#first_name').focus();
    addHiddenFields($(this));
  });
    
  // Clear button
  $('#ldap-person-search-clear-btn').click(function() {
    clearLdapPersonSearchForm();
  }); 

  // modal shown
  $("#ldap-person-search-modal").on('show', function() {
    clearLdapPersonSearchForm();
    $("#first_name").focus();
  });
  
  // modal hidden
  $("#ldap-person-search-modal").on('hide', function() {
    clearLdapPersonSearchForm();
  });
});