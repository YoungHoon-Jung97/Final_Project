/*
	UserSignupForm.js
 */

// 전역 상태 변수
var isEmailValid = false;
var isNickNameValid = false;
var isPasswordValid = false;

$(function()
{
	$('#submitBtn').prop('disabled', true);

	// 비밀번호와 비밀번호 확인 필드 입력 시
	$('#password, #passwordConfirm').on('input', function()
	{
		checkPassword();
		updateSubmitButton();
	});

	$('#ssn1').on('input', function()
	{
		if (this.value.length == 6)
		{
			var ssn1 = this.value;
			var ssn2 = $('#ssn2').val();
			
			// ssn2가 아직 비어있으면 포커스만 이동
			if (!ssn2)
			{
				$('#ssn2').focus();
				return;
	        }
			
			if (!isValidSsnDateWithCentury(ssn1, ssn2))
			{
				swal("유효하지 않은 생년월일", "정확한 주민등록번호를 입력해주세요.", "error");
				$(this).val('').focus();
	        }
			
			else
				$('#ssn2').focus();
		}
	});
	
	$('#ssn2').on('input', function ()
	{
		var ssn1 = $('#ssn1').val();
		var ssn2 = $(this).val();
		
		if (ssn1.length == 6 && ssn2.length == 1)
		{
			if (!isValidSsnDateWithCentury(ssn1, ssn2))
			{
				swal("유효하지 않은 주민번호", "정확한 주민등록번호를 입력해주세요.", "error");
				$('#ssn1').val('').focus();
			}
		}
	});

	// 폼 제출 시
	$('form').on('submit', function(event)
	{
		event.preventDefault();
		// 모든 조건 충족 시 폼 제출
		if (isEmailValid && isNickNameValid && isPasswordValid)
		{
			swal(
			{
				title : "회원가입 성공",
				text : "회원가입이 완료되었습니다.",
				icon : "success",
				button : "확인"
			});

			setTimeout(function()
			{
				$(".swal-button--confirm").on("click", function()
				{
					$('form')[0].submit();
				});
			}, 50);
		}

		else
			swal("회원가입 실패", "모든 정보를 정확히 입력해주세요.", "warning");
	});
});

// 이메일 중복 확인 함수
function checkEmail()
{
	var email = $('#email').val();
	$.ajax(
	{
		url : 'CheckEmail.action',
		type : 'get',
		data : { email : email },
		dataType : 'text',
		success : function(result)
		{
			if (result == "이미 사용중인 이메일 입니다.")
			{
				$('#emailCheck').text(result).css(
				{
					'display' : 'inline',
					'color' : 'red'
				});
				isEmailValid = false;
			}

			else
			{
				$('#emailCheck').text("사용 가능한 이메일입니다.").css(
				{
					'display' : 'inline',
					'color' : 'green'
				});
				isEmailValid = true;
			}

			updateSubmitButton();
		},
		error : function()
		{
			$('#emailCheck').text("이메일을 입력하세요.").css(
			{
				'display' : 'inline',
				'color' : 'red'
			});
			isEmailValid = false;
			updateSubmitButton();
		}
	});
}

// 닉네임 중복 확인 함수
function checkNickName()
{
	var nickName = $('#nickName').val();
	$.ajax(
	{
		url : 'CheckNickName.action',
		type : 'get',
		data : { nickName : nickName },
		dataType : 'text',
		success : function(result)
		{
			if (result == "이미 사용중인 닉네임 입니다.")
			{
				$('#nickNameCheck').text(result).css(
				{
					'display' : 'inline',
					'color' : 'red'
				});
				isNickNameValid = false;
			}

			else
			{
				$('#nickNameCheck').text("사용 가능한 닉네임입니다.").css(
				{
					'display' : 'inline',
					'color' : 'green'
				});
				isNickNameValid = true;
			}

			updateSubmitButton();
		},
		error : function()
		{
			$('#nickNameCheck').text("닉네임을 입력하세요.").css(
			{
				'display' : 'inline',
				'color' : 'red'
			});
			isNickNameValid = false;
			updateSubmitButton();
		}
	});
}

// 비밀번호 일치 확인 함수
function checkPassword()
{
	var password1 = $('#password').val();
	var password2 = $('#passwordConfirm').val();
	
	$("#passwordConfirm").on("change keyup", function()
	{
		if (password1 == password2 && password1.length >= 8)
		{
			$('#passwordCheck').text("비밀번호가 일치합니다.").css(
			{
				'display' : 'inline',
				'color' : 'green'
			});
			isPasswordValid = true;
		}
		
		else
		{
			$('#passwordCheck').text("비밀번호가 일치하지 않습니다.").css(
			{
				'display' : 'inline',
				'color' : 'red'
			});
			isPasswordValid = false;
		}
	});
}

// 제출 버튼 활성화 함수
function updateSubmitButton()
{
	if (isEmailValid && isNickNameValid && isPasswordValid)
		$('#submitBtn').prop('disabled', false);

	else
		$('#submitBtn').prop('disabled', true);
}

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
		},
	}).open(
	{
		popupName : 'postPopup', // 팝업 이름 지정(중복 방지)
		width : 400,
		height : 500
	});
}

function isValidSsnDateWithCentury(ssn1, ssn2)
{
	if (!/^\d{6}$/.test(ssn1) || !/^\d$/.test(ssn2)) return false;
	
	var year = parseInt(ssn1.substring(0, 2), 10);
	var month = parseInt(ssn1.substring(2, 4), 10);
	var day = parseInt(ssn1.substring(4, 6), 10);
	var centuryPrefix;
	
	if (['1', '2', '5', '6'].includes(ssn2))
		centuryPrefix = 1900;
	
	else if (['3', '4', '7', '8'].includes(ssn2))
		centuryPrefix = 2000;
	
	else
		return false;  // 유효하지 않은 성별코드
	
	var fullYear = centuryPrefix + year;
	var date = new Date(fullYear, month - 1, day);
	
	return (
		date.getFullYear() == fullYear &&
		date.getMonth() == month - 1 &&
		date.getDate() == day
	);
}