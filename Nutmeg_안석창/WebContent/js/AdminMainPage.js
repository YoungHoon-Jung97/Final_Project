/*
	AdminMainPage.js
*/

$(function()
{
	$('.menu-link').click(function(e)
	{
		e.preventDefault();
		var url = $(this).data('url');
		
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
});