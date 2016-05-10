$(document).on('page:change', function () {
  $('.dropdown-toggle').dropdown();
});

$(document).ready(function() {

  $('.portfolio-item').on('click', function () {

  var title = $(this).find('.title').text();
  console.log(title);
    $('#myModal1').find('.modal-title').html("<h2>"+title+"</h2>");
  var img = $(this).find('img').prop('src');
  console.log(img);
    $('#myModal1').find('.modal-body').html("<img src="+img+" />").css('text-align','center');
   $('#myModal1').modal('show');
});



});
