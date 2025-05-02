/*
	TeamOpen.js
*/

$(function()
{
	$('#submitBtn').prop('disabled', true);
	
	// 팀이름 입력시 에러메시지 제거
	$('#teamName').on('input', function()
	{
		$('#teamNameCheck').css('display', 'none');
		$('#submitBtn').prop('disabled', false);
	});
	
	// 사용자 코드 넣기 위한 코드
	$('#user_code_id').val(user_code_id);
	
	
	// city select의 option을 나열하기 위한 코드
	var region = $("#regions").val();
	
	if (region == "")
		$("#citys").html('<option value="">-- 먼저 시를 선택하세요 --</option>');
	
	$("#regions").on('change', function()
	{
		region = $("#regions").val();
		//alert("확인");
		$.ajax(
		{
			url : "SearchCity.action",
			type : "GET",
			data : { region : region },
			dataType : "JSON",
			success : function(result)
			{
				$('#citys').empty();
				
				if (result.length > 0)
				{
					$.each(result, function(index, city)
					{
						$('#citys').append('<option value="' + city.city_id + '">' + city.city_name + '</option>');
					});
				}
			},
			error : function(xhr, status, error)
			{
				console.log("오류 상태:", status);
				console.log("오류 메시지:", error);
				console.log("응답 데이터:", xhr.responseText);
				alert("도시 목록을 불러오는 중 오류가 발생했습니다.");
			}
		});
	});
		
	
	
	// submit하기전 이름 중복확인
	$('form').on('submit', function(event)
	{
		event.preventDefault();
		
		checkTeamName(function(isValid)
		{
			if (isValid)
				// 중복 검사 통과 시 폼 제출
				$('form')[0].submit();
		});
	});
	
	$('#image').on('change', function ()
	{
		var fileName = this.files.length > 0 ? this.files[0].name : '선택된 파일 없음';
		$('#file-name').text(fileName);
	});
	
});


function checkTeamName(callback)
{
	var teamName = $('#teamName').val();
	
	$.ajax(
			{
				url : 'CheckTeamName.action',
				type : 'get',
				data : { teamName : teamName },
				dataType : 'text',
				success : function(result)
				{
					if (result == "이미 사용중인 팀네임 입니다.")
					{
						$('#teamNameCheck').text(result);
						$('#teamNameCheck').css(
								{
									'display' : 'inline',
									'color' : 'red'
								})
								callback(false);
					}
					
					else if (result == "사용 가능한 팀네임 입니다.")
					{
						$('#teamNameCheck').text(result);
						$('#teamNameCheck').css(
								{
									'display' : 'inline',
									'color' : 'green'
								})
								callback(true);
					}
				},
				error : function()
				{
					$('#teamNameCheck').text("팀네임을 입력하세요").css(
							{
								'display' : 'inline',
								'color' : 'red'
							});
					callback(false);
				}
			});
}