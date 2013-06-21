$(function() {
  
  $('#ucb_rails_users').dataTable({
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    "sPaginationType": "bootstrap",
    "bProcessing": true,
    "bServerSide": true,
    "sAjaxSource": $('#ucb_rails_users').data('url'),
    "bStateSave": true,
    "iDisplayLength": 20,
    "oLanguage": {
      "sSearch": "First or Last Name starts with:"
    },
    "aLengthMenu": [[20, 50, 100, 1000], [20, 50, 100, 1000]],
    "aaSorting": [[ 5, "desc" ]],
    "aoColumnDefs": [
      { "aDataSort": [ 0, 2, 3 ], "aTargets": [ 0 ] }, // admin
      { "aDataSort": [ 1, 2, 3 ], "aTargets": [ 0 ] }, // active
      { "aDataSort": [ 2, 3 ], "aTargets": [ 2 ] }, // first name
      { "aDataSort": [ 3, 2], "aTargets": [ 3 ] },   // last name
      { "bSortable": false, "aTargets": [ 8 ] },   // edit
      { "bSortable": false, "aTargets": [ 9 ] },   // delete
    ]
  }).fnSetFilteringDelay(250);
  
});