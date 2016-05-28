$(document).on('page:change', function () {
  $('.dropdown-toggle').dropdown();
  $('#product_grid_area').hide();
  $('.grid_view').click(function () {
    if ($(this).hasClass( "active" )==false){
      $('#product_grid_area').show();
      $('#product_list_area').hide();
    };
  })
  $('.list_view').click(function () {
    if ($(this).hasClass( "active" )==false){
      $('#product_list_area').show();
      $('#product_grid_area').hide();
    };
  })

  $('.input-group-btn').click(function(){
    alert($('#input_search').val());
    $.ajax({
      url: '/products/index',
      type: 'get',
      dataType: 'script',
      data: {
        search: $('#input_search').val()
      }
    }).done(function(data) {
    	console.log(data);
    });
  })

  // $('.btn-cart').click(function(){
  //
  //
  // })
});

$(document).ready(function() {

  $('#myTabs a').click(function (e) {
    e.preventDefault();
    $(this).tab('show')
  })
  $('#product_grid_area').hide();

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
