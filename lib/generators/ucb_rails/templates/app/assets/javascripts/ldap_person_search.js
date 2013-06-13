$(function() {
  
  // clear search fields and results
  function clearLdapPersonSearchForm() {
    $('#first_name').val('');
    $('#last_name').val('');
    $("#ldap-person-search-results").empty();
  }
  
  function setHiddenField(link, dataAttribute) {
    var selector = '#' + dataAttribute;
    var value = link.data(dataAttribute);
    
    $(selector).val(value);
  }

  // add hidden fields to from coming from data attribute of link
  function setHiddenFields(link) {
    setHiddenField(link, 'js');
    setHiddenField(link, 'result-link-http-method');
    setHiddenField(link, 'result-link-text');
    setHiddenField(link, 'result-link-class');
    setHiddenField(link, 'result-link-url');
  }

  // open search dialog
  $('.ldap-person-search').click(function() {
    $('#ldap-person-search-modal').modal('show');
    $('#first_name').focus();
    setHiddenFields($(this));
  });
    
  // Clear button
  $('#ldap-person-search-clear-btn').click(function() {
    clearLdapPersonSearchForm();
  }); 

  // modal shown
  $("#ldap-person-search-modal").on('show', function() {
    //clearLdapPersonSearchForm();
    $("#first_name").focus();
  });
  
  // modal hidden
  $("#ldap-person-search-modal").on('hide', function() {
    clearLdapPersonSearchForm();
  });
});