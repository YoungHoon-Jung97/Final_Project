/*
	Modal.js
*/

$(function()
{
	// 모달 이벤트 리스너
	$('.open-modal').click(function()
	{
		openModal();
	});
	
	$('.close-modal, .modal-cancel').click(function()
	{
		closeModal();
	});
	
	// 모달 열기
	function openModal()
	{
		$('.modal').css('display', 'block');
		$("header, .floatingButton-wrapper, .filter-panel").addClass("blur-background");
	}
	
	// 모달 닫기
	function closeModal()
	{
		$('.modal').css('display', 'none');
		document.getElementById('menu-bar').classList.remove('blur-background');
		document.getElementById('floatingButton-wrapper').classList.remove('blur-background');
		document.getElementById('filterPanel').classList.remove('blur-background');
		$("header, .floatingButton-wrapper, .filter-panel").removeClass("blur-background");
	}
	
	// 다른 페이지 누를 시 모달 닫힘
	$(window).click(function(event)
	{
		if ($(event.target).is('.modal'))
			closeModal();
	});
});