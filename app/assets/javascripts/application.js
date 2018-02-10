//= require jquery
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require moment/ru
//= require fullcalendar
//= require calendar-initializer
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require i18n
//= require i18n/translations


$(document).on('turbolinks:load', function() {
  var max_height = 0;
  var blocks = $('.card-body');
  blocks.each(function() {
    if ( $(this).height() > max_height ) {
      max_height = $(this).height();
    }
  });
  blocks.each(function() {
    $(this).height(max_height);
  });

  $('.datatable').DataTable({
    "language":
      {
        "processing": I18n.t("datatables.processing"),
        "search": I18n.t("datatables.search"),
        "lengthMenu": I18n.t("datatables.lengthMenu"),
        "info": I18n.t("datatables.info"),
        "infoEmpty": I18n.t("datatables.infoEmpty"),
        "infoFiltered": I18n.t("datatables.infoFiltered"),
        "infoPostFix": I18n.t("datatables.infoPostFix"),
        "loadingRecords": I18n.t("datatables.loadingRecords"),
        "zeroRecords": I18n.t("datatables.zeroRecords"),
        "emptyTable": I18n.t("datatables.emptyTable"),
        "paginate": {
          "first": I18n.t("datatables.paginate.first"),
          "previous": I18n.t("datatables.paginate.previous"),
          "next": I18n.t("datatables.paginate.next"),
          "last": I18n.t("datatables.paginate.last")
        },
        "aria": {
          "sortAscending": I18n.t("datatables.aria.sortAscending"),
          "sortDescending": I18n.t("datatables.aria.sortDescending")
        }
      }
  });
});
