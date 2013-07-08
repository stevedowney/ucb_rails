$(function() {
  
  // clear search fields and results
  function clearLdapPersonSearchForm() {
    $('#first_name').val('');
    $('#last_name').val('');
    $("#lps-results").empty();
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

  function setSearchUrl(link) {
    var url = link.data('url');
    var formAction = url == undefined ? '/ucb_rails/ldap_person_search' : url;
    $('form#lps-form').attr('action', formAction);
  }
  
  // open search dialog
  $('.ldap-person-search').click(function() {
    $('#lps-modal').modal('show');
    $('#first_name').focus();
    
    var link = $(this);
    setHiddenFields(link);
    setSearchUrl(link)
  });
    
  // Clear button
  $('#lps-clear').click(function() {
    clearLdapPersonSearchForm();
  }); 

  // modal shown
  $("#lps-modal").on('show', function() {
    //clearLdapPersonSearchForm();
    $("#first_name").focus();
  });
  
  // modal hidden
  $("#lps-modal").on('hide', function() {
    clearLdapPersonSearchForm();
  });
});

function hideLdapPersonSearchModal() {
  $("#lps-modal").modal('hide');
}