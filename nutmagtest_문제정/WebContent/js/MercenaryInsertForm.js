/*
	MercenaryInsertForm.js
*/

$(function()
{
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
	
	// 지역 변경 이벤트
	$('#regions').change(function()
	{
		var regionId = $(this).val();
		loadCities(regionId);
	});
	
	// 지역에 따른 도시 로드
	function loadCities(regionId)
	{
		if (!regionId)
		{
			$('#citys').html('<option value="">구를 선택하세요</option>');
			return;
		}
		
		$.ajax(
		{
			url : "SearchCity.action",
			type : 'GET',
			data : { region : regionId },
			dataType : 'json',
			success : function(data)
			{
				var citySelect = $('#citys');
				
				citySelect.html('<option value="">구를 선택하세요</option>');
				
				if (data && data.length > 0)
				{
					data.forEach(function(city)
					{
						citySelect.append($('<option>',
						{
							value : city.city_id,
							text : city.city_name
						}));
					});
				}
			},
			error : function(xhr, status, error)
			{
				console.error('도시 목록 로드 오류:', error);
				alert('도시 목록을 불러오는 중 오류가 발생했습니다.');
			}
		});
	}
});