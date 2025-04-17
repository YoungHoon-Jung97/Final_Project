/*
	StadiumRegInsertForm
*/

$(function()
{
	$('#submitBtn').prop('disabled', true);
	
	$('#user_code_id').val(user_code_id);
	
	$("#checkDuplicateBtn").click(function()
	{
		var name = $("#name").val().trim();
		
		if (!name)
		{
			$("#nameCheckMsg").text("구장 이름을 입력하세요.").css("color", "red");
			isNameChecked = false;
			updateSubmitButtonState();
			return;
		}
		
		$.ajax(
		{
			url : "CheckStadiumName.action",
			type : "GET",
			data : { stadium_reg_name : name },
			success : function(result)
			{
				if (result == "duplicate")
				{
					$("#nameCheckMsg").html("이미 있는 이름입니다.").css("color", "red");
					isNameChecked = false;
				}
				
				else
				{
					$("#nameCheckMsg").html("사용 가능한 이름입니다.").css("color", "green");
					isNameChecked = true;
				}
				
				updateSubmitButtonState();
			},
			error : function()
			{
				$("#nameCheckMsg").text("오류 발생").css("color", "red");
				isNameChecked = false;
				updateSubmitButtonState();
			}
		});
	});

	$('#image').on('change', function()
	{
		var fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
		$('#file-name').text(fileName);
		updateSubmitButtonState();
	});
	
	$("input, select").on("change keyup", function()
	{
		updateSubmitButtonState();
	});
});

function execPostCode()
{
	new daum.Postcode(
	{
		// oncomplete : 주소를 선택하면 팝업이 닫히고 값이 입력 필드에 설정
		oncomplete : function(data)
		{
			// 도로명 주소와 지번 주소 중 하나를 선택하여 출력
			var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
			
			// 우편번호와 주소를 입력란에 넣기
			$("#post").val(data.zonecode); // 우편번호
			$('#address1').val(addr); // 기본 주소
			
			// 상세주소 입력창 포커스 이동
			$('#address2').focus();
			
			updateSubmitButtonState();
		},
	}).open(
	{
		popupName : 'postPopup', // 팝업 이름 지정(중복 방지)
		width : 400,
		height : 500
	});
}

function updateSubmitButtonState()
{
	if (isNameChecked && isFormFilled())
		$("#submitBtn").prop("disabled", false);
		
	else
		$("#submitBtn").prop("disabled", true);
}

function isFormFilled()
{
	var start = parseInt($("#stadium_time_id1").val());
	var end = parseInt($("#stadium_time_id2").val());
	
	return $("#name").val().trim() !== "" &&
			$("#post").val().trim() !== "" &&
		   $("#address1").val().trim() !== "" &&
		   $("#address2").val().trim() !== "" &&
		   $("#stadium_time_id1").val() !== "" &&
		   $("#stadium_time_id2").val() !== "" &&
		   $("#image")[0].files.length > 0 &&
		   !isNaN(start) && !isNaN(end) && start <= end;
}