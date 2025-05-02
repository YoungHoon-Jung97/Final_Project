/*
	OperatorStadiumUpdateForm.js
*/

// Ajax로 불러온 폼 대응을 위한 중복 확인 및 유효성 검사
$(document).on('click', '.check-dup-btn', function()
{
	var $form = $(this).closest('form');
	var name = $form.find('.stadium-name').val().trim();
	var $msg = $form.find('.name-check-msg');
	
	if (!name)
	{
		$msg.text("구장 이름을 입력하세요.").css("color", "red");
		$form.data('nameChecked', false);
		updateSubmitState($form);
		return;
	}
	
	$.ajax(
	{
		url : 'CheckStadiumName.action',
		type : 'GET',
		data : { stadium_reg_name : name },
		success : function(result)
		{
			if (result == 'duplicate')
			{
				$msg.text("이미 있는 이름입니다.").css("color", "red");
				$form.data('nameChecked', false);
			}
			
			else
			{
				$msg.text("사용 가능한 이름입니다.").css("color", "green");
				$form.data('nameChecked', true);
			}
			
			updateSubmitState($form);
		},
		error : function()
		{
			$msg.text("오류 발생").css("color", "red");
			$form.data('nameChecked', false);
			updateSubmitState($form);
		}
	});
});

// 파일 선택 시 파일명 표시
$(document).on('change', '.image', function()
{
	var fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
	
	$(this).siblings('.file-name').text(fileName);
	
	updateSubmitState($(this).closest('form'));
});

// 주소 API 실행
$(document).on('click', '.search-post-btn', function()
{
	var $form = $(this).closest('form');
	
	new daum.Postcode(
	{
		oncomplete : function(data)
		{
			var addr = data.roadAddress || data.jibunAddress;
			
			$form.find('.post').val(data.zonecode);
			$form.find('.address1').val(addr);
			$form.find('.address2').focus();
			
			updateSubmitState($form);
		}
	}).open();
});

// 입력 변화 감지 (모든 input, select)
$(document).on('change keyup', '.stadium-update-form input, .stadium-update-form select', function()
{
	var $form = $(this).closest('form');
	
	updateSubmitState($form);
});

// 유효성 검사 후 버튼 활성화
function updateSubmitState($form)
{
	var nameChecked = $form.data('nameChecked') == true;
	var start = parseInt($form.find('.time-start').val());
	var end = parseInt($form.find('.time-end').val());
	var isFilled = $form.find('.stadium-name').val().trim() != ''
				&& $form.find('.post').val().trim() != ''
				&& $form.find('.address1').val().trim() != ''
				&& $form.find('.address2').val().trim() != '' && !isNaN(start)
				&& !isNaN(end) && start <= end
				&& $form.find('.image')[0].files.length > 0;

	$form.find('.submit-btn').prop('disabled', !(nameChecked && isFilled));
}