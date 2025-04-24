/*
	OperatorMainPage.js
*/

$(document).on('click', '.menu-link', function(e)
{
	e.preventDefault();
	
	var url = $(this).data('url');
	
	if (!url)
		return;
	
	$('.menu-link').removeClass('active');
	$(this).addClass('active');
	
	console.log("요청 URL: ", $(this).data('url'));
	
	$.ajax(
	{
		url : url,
		method : 'GET',
		success : function(result)
		{
			$('#content-area').html(result);
		},
		error : function()
		{
			alert("콘텐츠를 불러오는 데 실패했습니다.");
		}
	});
});