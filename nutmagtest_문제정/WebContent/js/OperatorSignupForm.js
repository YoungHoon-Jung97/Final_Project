/*
	OperatorSignupForm.js
*/

$(function()
{
	$('#submitBtn').prop('disabled', true);
	
	$('#user_code_id').val(user_code_id);
	
	$('#email').on('input', function()
	{
		$('#emailCheck').css('display', 'none');
		$('#submitBtn').prop('disabled', true);
	});
	
	$('#AccountNo').on('input', function()
	{
		$('#AccountNoCheck').css('display', 'none');
		$('#submitBtn').prop('disabled', true);
	});
});

function checkEmail()
{
	var email = $('#email').val();
	
	$.ajax(
	{
		url : 'CheckEmailOperator.action',
		type : 'get',
		data : { email : email },
		dataType : 'text',
		success : function(result)
		{
			if (result == "이미 사용중인 이메일 입니다.")
			{
				$('#emailCheck').text(result);
				$('#emailCheck').css(
				{
					'display' : 'inline',
					'color' : 'red'
				})
				$('#submitBtn').prop('disabled', true);
			}
			
			else
			{
				$('#emailCheck').text(result);
				$('#emailCheck').css(
				{
					'display' : 'inline',
					'color' : 'green'
				})
				$('#submitBtn').prop('disabled', false);
			}
		},
		error : function()
		{
			$('#emailCheck').text("이메일을 입력하세요").css(
			{
				'display' : 'inline',
				'color' : 'red'
			});
			$('#submitBtn').prop('disabled', true);
		}
	});
}

function checkAccountNo()
{
	var accountNo = $('#accountNo').val();
	
	$.ajax(
	{
		url : 'CheckAccountNo.action',
		type : 'get',
		data : { accountNo : accountNo },
		dataType : 'text',
		success : function(result)
		{
			if (result == "이미 사용중인 계좌번호 입니다.")
			{
				$('#accountNoCheck').text(result);
				$('#accountNoCheck').css(
				{
					'display' : 'inline',
					'color' : 'red'
				})
				$('#submitBtn').prop('disabled', true);
			}
			
			else
			{
				$('#accountNoCheck').text(result);
				$('#accountNoCheck').css(
				{
					'display' : 'inline',
					'color' : 'green'
				})
				$('#submitBtn').prop('disabled', false);
			}
		},
		error : function()
		{
			$('#accountNoCheck').text("계좌 번호를 입력 하세요").css(
			{
				'display' : 'inline',
				'color' : 'red'
			});
			$('#submitBtn').prop('disabled', true);
		}
	});
}