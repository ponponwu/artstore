$(document).on('page:change', function () {
  $('.dropdown-toggle').dropdown();
});

$(document).ready(function() {

  $('#myTabs a').click(function (e) {
    e.preventDefault();
    $(this).tab('show')
  })
  $('#grid_view').click(function (e) {
    e.preventDefault();
    if ($(this).hasClass( "active" )==false){
      $.ajax({
        url: '/products/change_product_grid',
        type: 'POST',
        dataType: 'script',
        data: {

        }
      }).done(function(data) {
      	console.log(data);
      });
    };
  })

  // $('.portfolio-item').on('click', function () {
  //
  // var title = $(this).find('.title').text();
  // console.log(title);
  //   $('#myModal1').find('.modal-title').html("<h2>"+title+"</h2>");
  // var img = $(this).find('img').prop('src');
  // console.log(img);
  //   $('#myModal1').find('.modal-body').html("<img src="+img+" />").css('text-align','center');
  //  $('#myModal1').modal('show');
// });



});
