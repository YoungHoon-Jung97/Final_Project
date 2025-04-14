
//모달 이벤트 리스너
$('.open-modal').click(function() {
	openModal();
});

$('.close-modal, .btn--reset').click(function() {
	closeModal();
});

// 모달 열기
function openModal() {
    $('.modal').css('display', 'block');
}

// 모달 닫기
function closeModal() {
    $('.modal').css('display', 'none');
  
}



//다른 페이지 누를 시 모달 닫힘
$(window).click(function(event) {
	if ($(event.target).is('.modal')) {
        closeModal();
    }
});