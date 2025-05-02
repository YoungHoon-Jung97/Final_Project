/*
	FieldReservationForm.js
*/

window.onload = function ()
{
	initialize();
};

$(function()
{
	var startTimeId = null;
	var endTimeId = null;
	var selectionMode = "start";
	
	$(".time-container").on("click", function()
	{
		if ($(this).hasClass("resv-disabled"))
		{
			console.log("🚫 예약 불가 시간 클릭 차단됨");
			return;
		}
		
		var clickedTimeId = parseInt($(this).attr("data-time-id"));
		console.log("⏱ 클릭된 시간 ID:", clickedTimeId);
		
		if (selectionMode == "start")
		{
			resetSelection();
			startTimeId = clickedTimeId;
			$(this).addClass("in-range");
			selectionMode = "end";
		}
		
		else
		{
			endTimeId = clickedTimeId;
			
			if (startTimeId > endTimeId)
				[ startTimeId, endTimeId ] = [ endTimeId, startTimeId ];
			
			var hasDisabled = false;
			
			for (var i = startTimeId; i <= endTimeId; i++)
			{
				var $check = $('.time-container').filter(function()
				{
					return Number($(this).data("time-id")) == i;
				});
				
				if ($check.hasClass("resv-disabled"))
				{
					hasDisabled = true;
					break;
				}
			}
			
			if (hasDisabled)
			{
				alert("선택한 시간 범위에 예약 불가능한 시간이 포함되어 있어요.");
				resetSelection();
				return;
			}
			
			timeRange(startTimeId, endTimeId);
			selectionMode = "start";
			$("#submit-button").prop("disabled", false);
		}
	});
	
	$("#reset-button").click(function()
	{
		resetSelection();
	});
	
	function resetSelection()
	{
		$('.time-container').not('.resv-disabled') // 예약 불가능 시간은 유지
		.removeClass('in-range');
		$('#submit-button').prop('disabled', true);
		startTimeId = null;
		endTimeId = null;
		selectionMode = "start";
	}
	
	function timeRange(start, end)
	{
		$('.time-container').removeClass('in-range');
		for (var i = start; i <= end; i++)
		{
			var element = $('.time-container[data-time-id="' + i + '"]');
			
			if (!element.hasClass('resv-disabled'))
				element.addClass('in-range');
		}
	}
	
	$("#matchDateInput").on("change", function()
	{
		var match_date = $(this).val();
		var field_code_id = $("#field_code_id").val();
		
		var today = new Date();
		today.setHours(0, 0, 0, 0); // 시간 제거
		var selectedDate = new Date(match_date);
		
		if (selectedDate < today)
		{
			alert("오늘 이전 날짜는 선택할 수 없습니다.");
			$(this).val(""); // 날짜 초기화
			return;
		}
		
		resetSelection();
		
		$(".time-table").show();
		
		console.log("날짜 변경됨:", match_date);
		console.log("Ajax 요청 주소:", "GetUnavailableTimeRange.action");
		
		if (match_date && field_code_id)
		{
			$.ajax(
			{
				url : "GetUnavailableTimeRange.action",
				type : "GET",
				data :
				{
					match_date : match_date,
					field_code_id : field_code_id
				},
				headers : { "Accept" : "application/json" },
				success : function(timeRanges)
				{
					console.log("✅ Ajax 성공!");
					console.log("📦 서버 응답 데이터:", timeRanges);
					
					// 모든 슬롯 초기화
					$(".time-container").removeClass( "resv-disabled") .removeAttr("style");
					$(".unavailable-label").remove();
					
					var totalDisabled = 0;
					
					timeRanges.forEach(function(range, index)
					{
						var start = Number(range.STADIUM_TIME_ID1);
						var end = Number(range.STADIUM_TIME_ID2);
						
						if (isNaN(start) || isNaN(end))
						{
							console.warn(`⚠️ 잘못된 시간값: start=${start}, end=${end}`);
							return;
						}
						
						for (var i = start; i <= end; i++)
						{
							var $slot = $('.time-container').filter(function()
							{
								return Number($(this).data("time-id")) == i;
							});
							
							$slot.addClass("resv-disabled").css(
							{
								"background-color" : "red",
								"color" : "white",
								"cursor" : "not-allowed",
								"pointer-events" : "none"
							});
							
							if ($slot.find(".unavailable-label").length == 0)
								$slot.append('<div class="unavailable-label">예약불가</div>');
							
							console.log(`🟥 예약 불가 처리 완료: data-time-id="${i}"`);
							
							totalDisabled++;
						}
					});
					
					console.log(`✅ 총 예약 불가 시간 슬롯 수: ${totalDisabled}`);
					
					blockUnavailableTimeByStadiumTimeId();
				},
				error : function(xhr, status, error){},
				complete : function()
				{
					console.log("🔁 Ajax 완료");
				}
			});
		}
	});
	
	// 폼 전송 구문
	$("#submit-button").click(function(e)
	{
		e.preventDefault();
		
		if (startTimeId == null || endTimeId == null)
		{
			alert("시간을 선택해 주세요.");
			return;
		}
		
		if ($("#matchDateInput").val() == null || $("#matchDateInput").val() == "")
		{
			alert("날짜를 선택해 주세요.");
			return;
		}
		
		// 시작 시간 텍스트 추출 (예: "12:00")
		var startText = $('.time-container[data-time-id="' + startTimeId + '"]').find('.time-title').text();
		var startOnly = startText.split('~')[0].trim();
		
		// 종료 시간 텍스트 추출 (예: "15:50")
		var endText = $('.time-container[data-time-id="' + endTimeId + '"]').find('.time-title').text();
		var endOnly = endText.split('~')[1].trim();
		
		console.log("✅ 설정된 시간 ID:", startTimeId, "~", endTimeId);
		console.log("🕒 설정된 시간 텍스트:", startOnly, "~", endOnly);
		
		// hidden 필드에 값 넣기
		$("#start_time_id").val(startTimeId);
		$("#end_time_id").val(endTimeId);
		$("#start_time_text").val(startOnly);
		$("#end_time_text").val(endOnly);
		
		// 폼 전송
		$(this).closest("form")[0].submit();
	});
});

function blockUnavailableTimeByStadiumTimeId()
{
	var minTimeId = parseInt($("#timeStartLimit").val()); // 예: 2
	var maxTimeId = parseInt($("#timeEndLimit").val()); // 예: 6
	
	console.log("🔧 제한 시간 시작:", $("#timeStartLimit").val());
	console.log("🔧 제한 시간 끝:", $("#timeEndLimit").val());
	
	if (isNaN(minTimeId) || isNaN(maxTimeId))
		console.warn("❗ minTimeId 또는 maxTimeId가 유효하지 않습니다.");
	
	$(".time-container").each(function()
	{
		var timeId = parseInt($(this).attr("data-time-id"));
		
		if (timeId < minTimeId || timeId > maxTimeId)
		{
			$(this).addClass("resv-disabled").css(
			{
				"background-color" : "red",
				"color" : "white",
				"cursor" : "not-allowed",
				"pointer-events" : "none"
			});
			
			if ($(this).find(".unavailable-label").length == 0)
				$(this).append('<div class="unavailable-label">이용불가</div>');
		}
	});
}

// 지도 생성 함수
function initialize()
{
	var container = document.getElementById("map");
	
	var map = new kakao.maps.Map(container,
    {
		// 임시 좌표 설정
		center: new kakao.maps.LatLng(37.5665, 126.9780),
		level: 3
    });
	
	// 좌표로 변환하는 메소드
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 입력한 주소를 좌표로 변환하는 메소드
	geocoder.addressSearch(fullAddress, function(result, status)
	{
		// 만약 불러온 좌표의 값의 length가 0 이상 이라면 (값이 불러져 왔다면)
		if (status == kakao.maps.services.Status.OK && result.length > 0)
		{
			var cords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			// 맵의 센터를 cords라는 좌표로 이동 시켜라
			map.setCenter(cords);
			
			// 마커 생성
			var marker = new kakao.maps.Marker(
			{
				map: map,
				position: cords
			});
		}
		
		else
			alert("❌ 주소 검색 실패. 입력한 주소: " + fullAddress);
	});
}