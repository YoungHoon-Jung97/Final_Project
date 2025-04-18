/*
	Time.js
*/

$(function()
{
	// 오늘 날짜를 기본값으로 설정
	var today = new Date();
	var formattedDate = today.toISOString().split('T')[0];
	$('#searchDate').val(formattedDate);
	$('#stardate').val(formattedDate);
	
	// 날짜 제한 설정 (오늘부터 1달 후까지)
	var oneMonthLater = new Date(today);
	oneMonthLater.setMonth(today.getMonth() + 1);
	var maxDate = oneMonthLater.toISOString().split('T')[0];
	
	$('#searchDate').attr('min', formattedDate);
	$('#searchDate').attr('max', maxDate);
	$('#stardate').attr('min', formattedDate);
	$('#stardate').attr('max', maxDate);
	$('#endDate').attr('min', formattedDate);
	$('#endDate').attr('max', maxDate);
	
	// 시작 날짜가 변경될 때 종료 날짜의 최소값 설정
	$('#stardate').change(function()
	{
		$('#endDate').attr('min', $(this).val());
		
		// 만약 종료 날짜가 시작 날짜보다 이전이면 시작 날짜로 설정
		if ($('#endDate').val() < $(this).val())
			$('#endDate').val($(this).val());
	});
});