/*
	MercenaryOffer.js
*/

var selectedRegionId = '';
var selectedCityId = '';

$(function()
{
	function searchMercenary()
	{
		var selectedRegionName = $('#regionSelect option:selected').text().trim();
		var selectedCityName = $('#citySelect option:selected').text().trim();
		var time = $('#searchDate').val();
		
		// 디버깅 로그 추가
		console.log("AJAX 요청 시작");
		console.log("지역:", selectedRegionName);
		console.log("도시:", selectedCityName);
		console.log("검색 시간:", time);
		
		// '전체'는 공백 처리
		if (selectedRegionName == '전체')
			selectedRegionName = '';
		
		if (selectedCityName == '전체')
			selectedCityName = '';
		
		// AJAX 코드 수정
		$.ajax(
		{
			url : contextPath + "/SearchMercenary.action",
			type : "GET",
			data :
			{
				region_name: selectedRegionName,
				city_name: selectedCityName,
				time: time
			},
			dataType : 'json',
			success : function(data)
			{
				console.log("AJAX 성공", data);
				
				// HTML 생성
				var html = '';
				
				if (data && data.length > 0)
				{
					data.forEach(function(mercenary)
					{
						html += '<div class="table-row">';
						html += '<div class="table-cell">' + mercenary.user_nick_name + '</div>';
						html += '<div class="table-cell">' + mercenary.position_name + '</div>';
						html += '<div class="table-cell">' + mercenary.region_name + '</div>';
						html += '<div class="table-cell">' + mercenary.city_name + '</div>';
						html += '<div class="table-cell">';
						html += '<form action="hireMercenary.action" method="POST">';
						html += '<input type="hidden" name="mercenary_id" value="' + mercenary.mercenary_id + '">';
						html += '<button type="submit" class="btn-hire">고용</button>';
						html += '</form>';
						html += '</div>';
						html += '</div>';
					});
				}
				
				else
					html = '<div class="table-row"><div class="table-cell" style="grid-column: span 5; text-align: center;">필터에 맞는 용병이 없습니다.</div></div>';

				$('#mercenaryList').html(html);
			},
			error : function(xhr, status, error)
			{
				console.error("AJAX 오류 발생:", status, error);
				console.log(xhr.responseText);
			}
		});
	}
	
    $('#searchBtn').click(function(e)
    {
		e.preventDefault();
		searchMercenary();
	});
    
	$('#regionSelect').change(function()
	{
		var selectedRegionId = $(this).val();
		
		// 도시 목록 초기화
		$('#citySelect').html('<option value="">전체</option>');
		
		if (selectedRegionId)
		{
			$.ajax(
			{
				url: contextPath + "/GetCityListByRegionId.action",
				type: 'GET',
				data: { region_id: selectedRegionId },
				success: function(cityList)
				{
					// 도시 목록을 <option>으로 추가
					$.each(cityList, function(index, city)
					{
						$('#citySelect').append('<option value="' + city.city_id + '">' + city.city_name + '</option>');
					});
					
					searchMercenary();  // 지역 선택 후 바로 검색
				}
			});
		}
		
		else
			searchMercenary();  // 지역을 선택하지 않은 경우에도 검색
	});
	
	$('#citySelect').change(function()
	{
		searchMercenary();
	});
});