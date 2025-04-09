/*
	UserSignupForm.js
*/

// 전역 상태 변수
var isEmailValid = false;
var isNickNameValid = false;
var isPasswordValid = false;

$(function()
{
    // 비밀번호와 비밀번호 확인 필드 입력 시
    $('#password, #passwordConfirm').on('input', function()
    {
        checkPassword();
        updateSubmitButton();
    });

    // 폼 제출 시
    $('form').on('submit', function(event)
    {
        event.preventDefault();
        // 모든 조건 충족 시 폼 제출
        if (isEmailValid && isNickNameValid && isPasswordValid)
        {
            alert("회원가입이 완료되었습니다!");
            this.submit();
        }
        
        else
            alert("모든 정보를 정확히 입력해주세요.");
    });
});

// 이메일 중복 확인 함수
function checkEmail()
{
    var email = $('#email').val();
    $.ajax(
    {
        url: 'CheckEmail.action',
        type: 'get',
        data: { email: email },
        dataType: 'text',
        success: function(result)
        {
            if (result == "이미 사용중인 이메일 입니다.")
            {
                $('#emailCheck').text(result).css({'display': 'inline', 'color': 'red'});
                isEmailValid = false;
            }
            
            else
            {
                $('#emailCheck').text("사용 가능한 이메일입니다.").css({'display': 'inline', 'color': 'green'});
                isEmailValid = true;
            }
            
            updateSubmitButton();
        },
        error: function()
        {
            $('#emailCheck').text("이메일을 입력하세요.").css({'display': 'inline', 'color': 'red'});
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
        url: 'CheckNickName.action',
        type: 'get',
        data: { nickName: nickName },
        dataType: 'text',
        success: function(result)
        {
            if (result == "이미 사용중인 닉네임 입니다.")
            {
                $('#nickNameCheck').text(result).css({'display': 'inline', 'color': 'red'});
                isNickNameValid = false;
            }
            
            else
            {
                $('#nickNameCheck').text("사용 가능한 닉네임입니다.").css({'display': 'inline', 'color': 'green'});
                isNickNameValid = true;
            }
            
            updateSubmitButton();
        },
        error: function()
        {
            $('#nickNameCheck').text("닉네임을 입력하세요.").css({'display': 'inline', 'color': 'red'});
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

    if (password1 == password2 && password1.length >= 8)
    {
        $('#passwordCheck').text("비밀번호가 일치합니다.").css({'display': 'inline', 'color': 'green'});
        isPasswordValid = true;
    }
    
    else
    {
        $('#passwordCheck').text("비밀번호가 일치하지 않습니다.").css({'display': 'inline', 'color': 'red'});
        isPasswordValid = false;
    }
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
		//oncomplete : 주소를 선택하면 팝업이 닫히고 값이 입력 필드에 설정
		oncomplete: function(data)
		{
			//도로명 주소와 지번 주소 중 하나를 선택하여 출력
			var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
			
			//우편번호와 주소를 입력란에 넣기
			$("#post").val(data.zonecode);  //우편번호
			$('#address1').val(addr);		//기본 주소
			
			//상세주소 입력창 포커스 이동
			$('#address2').focus();
		},
	}).open(
	{
		popupName: 'postPopup', // 팝업 이름 지정(중복 방지)
		width: 400,
        height: 500
	});
}