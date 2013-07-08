$(function() {
  
  // clear search fields and results
  function clearLdapPersonSearchForm() {
    $('#first_name').val('');
    $('#last_name').val('');
    $("#lps-results").empty();
    $('#matches').empty();
  }
  
  function setHiddenField(link, dataAttribute) {
    var selector = '#' + dataAttribute;
    var value = link.data(dataAttribute);
    $(selector).val(value);
  }

  // add hidden fields to from coming from data attribute of link
  function setHiddenFields(link) {
    setHiddenField(link, 'search-field-name');
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
    
    var link = $(this);
    setHiddenFields(link);
    setSearchUrl(link)
  });
    
  // Clear button
  $('#lps-clear').click(function() {
    clearLdapPersonSearchForm();
  });

  // modal shown
  $("#lps-modal").on('shown', function() {
    $("#first_name").focus();
  });
  
  // modal hidden
  $("#lps-modal").on('hide', function() {
    clearLdapPersonSearchForm();
  });
  
  // Default handler for search.  Implementers should specify a result-link-class
  // data attribute on the element that starts the search.
  $(document).on('click', 'a.result-link-default', function (e) {
    var link = $(this);
    alert('Default click handler: ' + link.data('uid'));
    e.preventDefault();
    hideLpsModal();
  });
  
});

function hideLpsModal() {
  $("#lps-modal").modal('hide');
}
