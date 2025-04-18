/*
	Login.js
*/

$(function()
{
	// 페이지 로딩 시 초기 검증
	validateLoginForm();

	// 저장된 쿠키값을 가져와서 Email 칸에 넣어준다. 없으면 공백으로 들어감.
	var key = getCookie('key');

	$('#logEmailKo').val(key);
	$('#logEmailEn').val(key);

	// 그 전에 Email를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 Email가 표시된 상태라면,
	if (key)
	{
		$('#saveEmailKo').prop('checked', true); 		// Email 저장하기를 체크 상태로 두기.
		$('#saveEmailEn').prop('checked', true);

		$('.check').find('i').removeClass('uil-square').addClass('uil-check-square');
	}

	$('#langToggle').on('change', function()
	{
		if (!key)
		{
			$('#logEmailKo').val('');
			$('#logEmailEn').val('');
		}
		
		else
		{
			$('#logEmailKo').val(key);
			$('#logEmailEn').val(key);
			$('#saveEmailKo').prop('checked', true);
			$('#saveEmailEn').prop('checked', true);
			$('.check').find('i').removeClass('uil-square').addClass('uil-check-square');
		}

		$('#logPwKo').val('');
		$('#logPwEn').val('');

		var isChecked = $(this).is(':checked');

		$('.eyes').find('i').removeClass('uil-eye-slash').addClass('uil-eye');
		$('.eyes').removeClass('active');

		if (!isChecked)
			$('#logPwKo').attr('type', 'password');

		else
			$('#logPwEn').attr('type', 'password');

		$('.email-icon-btn').hide();
		$('.pw-icon-btn').hide();

		validateLoginForm();
	});

	$('#saveEmailKo').on('change', function()
	{
		var isChecked = $(this).is(':checked'); 		// 현재 체크 여부를 가져와서

		$('#saveEmailEn').prop('checked', isChecked); 	// 영어 체크박스(#saveEmailEn)에도 동일 적용
	});

	$('#saveEmailEn').on('change', function()
	{
		var isChecked = $(this).is(':checked');

		$('#saveEmailKo').prop('checked', isChecked);
	});

	// 이메일, 비밀번호 입력 시마다 검증 수행
	$('#logEmailKo, #logPwKo, #logEmailEn, #logPwEn').on('input', function()
	{
		validateLoginForm();
	});
	
	$('#logEmailKo, #logEmailEn').on('input', function()
	{
		if ($(this).val().length > 0)
			$('.email-icon-btn').show();

		else
			$('.email-icon-btn').hide();
	}).on('blur', function()
	{
		$('.email-icon-btn').hide();
	});

	$('#logPwKo, #logPwEn').on('input', function()
	{
		if ($(this).val().length > 0)
			$('.pw-icon-btn').show();

		else	
			$('.pw-icon-btn').hide();
	}).on('blur', function()
	{
		$('.pw-icon-btn').hide();
	});
	
	$('#logEmailKo, #logEmailEn').on('focus', function()
	{
		$(this).trigger('input');
	});
	
	$('#logPwKo, #logPwEn').on('focus', function()
	{
		$(this).trigger('input');
	});

	// 클리어 버튼 클릭 시 입력값 삭제 및 포커스
	$('.delete-email').on('mousedown', function(e)
	{
		e.preventDefault();
		
		var isChecked = $('#langToggle').is(':checked');

		if (!isChecked)
			$('#logEmailKo').val('').trigger('input').focus();

		else
			$('#logEmailEn').val('').trigger('input').focus();
	});
	
	$('.delete-pw').on('mousedown', function(e)
	{
		e.preventDefault();
		
		var isChecked = $('#langToggle').is(':checked');

		if (!isChecked)
			$('#logPwKo').val('').trigger('input').focus();

		else
			$('#logPwEn').val('').trigger('input').focus();
	});

	// 눈 아이콘 클릭 시 비밀번호 보이기/숨기기 토글
	$('.eyes').on('mousedown', function(e)
	{
		e.preventDefault();
		
		var isChecked = $('#langToggle').is(':checked');

		$(this).toggleClass('active');

		if ($(this).hasClass('active'))
		{
			$(this).find('i').removeClass('uil-eye').addClass('uil-eye-slash');

			if (!isChecked)
			{
				$('#logPwKo').attr('type', 'text');
				$('#logPwKo').trigger('input').focus();
			}

			else
			{
				$('#logPwEn').attr('type', 'text');
				$('#logPwEn').trigger('input').focus();
			}
		}

		else
		{
			$(this).find('i').removeClass('uil-eye-slash').addClass('uil-eye');

			if (!isChecked)
			{
				$('#logPwKo').attr('type', 'password');
				$('#logPwKo').trigger('input').focus();
			}

			else
			{
				$('#logPwEn').attr('type', 'password');
				$('#logPwEn').trigger('input').focus();
			}
		}
	});

	$('.check').on('click', function()
	{
		var isChecked = $(this).find('.save-email').is(':checked');

		if (isChecked)
		{
			$('.save-email-ko').find('i').removeClass('uil-square').addClass('uil-check-square');
			$('.save-email-en').find('i').removeClass('uil-square').addClass('uil-check-square');
		}

		else
		{
			$('.save-email-ko').find('i').removeClass('uil-check-square').addClass('uil-square');
			$('.save-email-en').find('i').removeClass('uil-check-square').addClass('uil-square');
		}
	});
	
	$('.input-icon5').on('click', function()
	{
		var checkbox = $(this).siblings('.save-email');
		checkbox.prop('checked', !checkbox.prop('checked')).trigger('change');
	});
	
	// 로그인 실패 시 메시지 알림과 주소창의 파라미터 제거 처리
	if (msg == "fail")
	{
		if (lang == "ko")
			swal("로그인 실패", "이메일 / 비밀번호가 올바르지 않습니다.", "error");
		
		else
			swal("Login failed", "email / password is invalid.", "error");

		if (history.replaceState)
			history.replaceState({}, '', location.pathname);
		
		else
		{
			var cleanUrl = location.protocol + '//' + location.host + location.pathname;
			location.href = cleanUrl;
		}
	}
	
	$('#logEmailKo, #logPwKo, #logEmailEn, #logPwEn').on('keypress', function(e)
	{
		if (e.which == 13) // Enter key
		{
			e.preventDefault(); // 기본 폼 제출 막기
			
			// 현재 언어 상태 확인
			var isKo = !$("#langToggle").is(":checked");
			
			// 각각의 값 가져오기
			var email = isKo ? $("#logEmailKo").val() : $("#logEmailEn").val();
			var pw = isKo ? $("#logPwKo").val() : $("#logPwEn").val();
			
			// 유효성 검사 조건 충족 시만 Submit
			if (email.length >= 7 && pw.length >= 4)
				Submit();
		}
	});
	
	var keySequence = [ "ArrowUp", "ArrowUp",
						"ArrowDown", "ArrowDown",
						"ArrowLeft", "ArrowRight",
						"ArrowLeft", "ArrowRight",
						"b", "a" ];
	
	var inputBuffer = [];
	
	var passwordInput = $('#langToggle').is(':checked') ? document.getElementById("logPwEn") : document.getElementById("logPwKo");
	var adminBtn = document.getElementById("adminBtn");
	
	passwordInput.addEventListener("keydown", function(e)
	{
		inputBuffer.push(e.key);
		
		if (inputBuffer.length > keySequence.length)
			inputBuffer.shift();
		
		var matched = true;
		
		for (var i = 0; i < keySequence.length; i++)
		{
			if (inputBuffer[i] !== keySequence[i])
			{
				matched = false;
				break;
			}
		}
		
		if (matched)
		{
			adminBtn.style.display = "block";
			inputBuffer = [];
		}
	});
});

function validateLoginForm()
{
	if (!$("#langToggle").is(":checked"))
	{
		var email = $("#logEmailKo").val();
		var pw = $("#logPwKo").val();

		if (email.length >= 7 && pw.length >= 4)
			$("#loginFormKo .btn.mt-4").prop("disabled", false);

		else
			$("#loginFormKo .btn.mt-4").prop("disabled", true);
	}

	else
	{
		var email = $("#logEmailEn").val();
		var pw = $("#logPwEn").val();

		if (email.length >= 7 && pw.length >= 4)
			$("#loginFormEn .btn.mt-4").prop("disabled", false);

		else
			$("#loginFormEn .btn.mt-4").prop("disabled", true);
	}
}

function Submit()
{
	if (!$("#langToggle").is(":checked"))
	{
		var logEmailKo = document.getElementById("logEmailKo");
		var logPwKo = document.getElementById("logPwKo");

		if (!isValidEmail(logEmailKo.value))
		{
			alert("정상적인 이메일 형식을 입력하세요");
			logEmailKo.focus();
			return;
		}

		document.getElementById("loginFormKo").submit();
	}

	else
	{
		var logEmailEn = document.getElementById("logEmailEn");
		var logPwEn = document.getElementById("logPwEn");

		if (!isValidEmail(logEmailEn.value))
		{
			alert("Please enter a normal e-mail format");
			logEmailEn.focus();
			return;
		}

		document.getElementById("loginFormEn").submit();
	}
}