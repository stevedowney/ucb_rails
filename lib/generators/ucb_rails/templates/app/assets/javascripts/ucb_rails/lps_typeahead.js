$(function() {
  
  // prevent browser autocomplete from competing with Bootstrap typeahead
  $('.typeahead-lps-search').attr('autocomplete', 'off');
  
  // typing in search field clears uid field
  $('.typeahead-lps-search').keyup(function() {
    var uidSelector = '#' + $(this).data('uid-dom-id');
    $(uidSelector).val('');
  });
  
  // default handler for ldap search result link when used with typeahead
  $(document).on('click', 'a.lps-typeahead-item', function (e) {
    var link = $(this);
    var searchFieldSelector = '#' + link.parents('.modal').find('form input#search-field-name').val();
    var searchField = $(searchFieldSelector);
    var uidSelector = '#' + searchField.data('uid-dom-id');
    $(uidSelector).val(link.data('uid'));
    $(searchFieldSelector).val(link.data('first-name') + ' ' + link.data('last-name'));
    e.preventDefault();
    hideLpsModal();
  });
  
  // set up typeahead callbacks
  $('.typeahead-lps-search').typeahead({
    source: function(query, process) {
      return $.ajax({
        url: $(this)[0].$element[0].dataset.url,
        type: 'get',
        data: {query: query},
        dataType: 'json',

        success: function(uid_name_json) {
          names = [];
          map = {};

          $.each(uid_name_json, function (i, person) {
            map[person.first_last_name] = person;
            names.push(person.first_last_name);
          });

          process(names);
        }
      });
    },
    updater: function (item) {
      var uidSelector = '#' + $(this)[0].$element[0].dataset.uidDomId;
      $(uidSelector).val(map[item].uid);
      return item;
    },
    matcher: function (item) {
      return true;
    },
  });

})
