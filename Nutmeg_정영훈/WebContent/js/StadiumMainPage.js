/*
	StadiumMainPage.js
*/

var selectedRegionId = '';
var selectedCityId = '';

$(function()
{
	function searchStadiums()
	{
		var selectedRegionName = $('#regionSelect option:selected').text().trim();
		var selectedCityName = $('#citySelect option:selected').text().trim();
		
		if (selectedRegionName == '전체')
			selectedRegionName = '';
		
		if (selectedCityName == '전체')
			selectedCityName = '';
		
		$.ajax(
		{
			url: contextPath + "/FieldCardList.action",
			type: "GET",
			data:
			{
				region_name: selectedRegionName,
				city_name: selectedCityName,
				keyword: $('#title').val()
			},
			success: function(html)
			{
				if ($.trim(html) == '')
					$('.row.g-4').html('<div class="col-12 text-center"><p class="text-muted fs-5">필터에 맞는 구장이 없습니다.</p></div>');
				
				else
					$('.row.g-4').html(html);
			}
		});
	}
	
    $('#searchBtn').click(function(e)
    {
		e.preventDefault();
		searchStadiums();
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
					
					searchStadiums();  // 지역 선택 후 바로 검색
				}
			});
		}
		
		else
			searchStadiums();  // 지역을 선택하지 않은 경우에도 검색
	});
	
	$('#citySelect').change(function()
	{
		searchStadiums();
	});
});