/*
	TeamApply.js
 */

$(function()
{
	$("#teamApply").on("click", function()
	{
		$('#applyModal').css('display', 'flex');
		$("#applyModal").show();
		$("body").css("overflow", "hidden"); // 페이지 스크롤 방지
		$("header, .floatingButton-wrapper, .filter-panel").addClass("blur-background");
	});
	
	// 페이지 로드 시 첫 번째 포지션 버튼을 기본 선택 상태로 설정
	var firstButton = $('.position-button').first();
	var positionId = firstButton.data('position-id');
	
	firstButton.addClass('active'); // 첫 번째 버튼 활성화
	$('#selected-position-id').val(positionId); // 해당 포지션 ID를 hidden input에 저장
	
	// 포지션 선택 버튼 클릭 이벤트
	$('.position-button').on('click', function()
	{
		var positionId = $(this).data('position-id');
		var positionName = $(this).text();
		
		// 버튼 선택 활성화
		$('.position-button').removeClass('active');
		$(this).addClass('active');
		
		// 선택된 포지션 ID를 hidden input에 저장
		$('#selected-position-id').val(positionId);
		
		console.log('선택된 포지션 ID:', positionId);
		console.log('선택된 포지션 이름:', positionName);
	});
	
	// 모달 닫기 버튼
	$("#reset-apply").on("click", function()
	{
		$('#applyModal').css('display', 'none');
		$("#applyModal").hide(); // 모달 숨기기
		$("body").css("overflow", "auto"); // 페이지 스크롤 복원
		$("header, .floatingButton-wrapper, .filter-panel").removeClass("blur-background");
	});
});