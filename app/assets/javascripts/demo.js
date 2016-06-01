$(document).on('page:change', function () {
  $('.dropdown-toggle').dropdown();
  $('#product_grid_area').hide();
  $('.list_view').addClass('active');
  $('#myTabs a').click(function (e) {
    e.preventDefault();
    $(this).tab('show')
  })
  $('.grid_view').click(function () {
    if ($(this).hasClass( "active" )==false){
      $('#product_grid_area').show();
      $('#product_list_area').hide();
      $('#sort_area').hide();
      $(this).addClass('active');
      $('.list_view').removeClass('active');
    };
  })
  $('.list_view').click(function () {
    if ($(this).hasClass( "active" )==false){
      $('#product_list_area').show();
      $('#product_grid_area').hide();
      $('#sort_area').show();
      $(this).addClass('active');
      $('.grid_view').removeClass('active');
    };
  })

  $('.input-group-btn').click(function(){
    $.ajax({
      url: '/products/search',
      type: 'POST',
      dataType: 'script',
      data: {
        search: $('#input_search').val()
      }
    }).done(function(data) {
    	console.log(data);
    });
  })
  $('#select_sort').change(function(){
    $('#product_list_area').show();
    $('#product_grid_area').hide();
    $.ajax({
      url: '/products/sort',
      type: 'POST',
      dataType: 'script',
      data: {
        sort: $('#select_sort option:selected').val()
      }
    }).done(function(data) {
    	console.log(data);
    });
  });
  $('#display_amount').change(function(){
    $.ajax({
      url: '/products',
      type: 'POST',
      dataType: 'script',
      data: {
        per_page: $('#display_amount option:selected').val(),
        product_id: $('.prodcut').data('id')
      }
    }).done(function(data) {
    	console.log(data);
    });
  });

  // $('.btn-cart').click(function(){
  //
  //
  // })
});

$(document).ready(function() {




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
