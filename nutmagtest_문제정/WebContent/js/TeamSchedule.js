/*
	TeamSchedule.js
*/

var currentEvents = [];
var calendar;

// [0 순서] 페이지 로드 시 실행 (달력에 일정 표시)
document.addEventListener('DOMContentLoaded', function()
{
	// FullCalendar 초기화
	var calendarEl = document.getElementById('calendar');
	
	// 캘린더 초기화 부분 수정
	calendar = new FullCalendar.Calendar(calendarEl,
	{
		initialView: 'dayGridMonth',
		headerToolbar:
		{
			left: 'prev,next today',
			center: 'title',
			right: 'dayGridMonth,timeGridWeek,listMonth'
		},
		events: function(info, successCallback, failureCallback)
		{
			$.ajax(
			{
				url: contextPath + '/MatchList.action',
				type: 'GET',
				dataType: 'json',
				success: function(data)
				{
					console.log("서버에서 받은 데이터:", data);
					
					if (!data || data.length == 0)
					{
						console.log("데이터가 없습니다.");
						successCallback([]);
						return;
					}
					
					var events = data.map(match =>
					{
						console.log("매치 데이터:", match);
						console.log("날짜:", match.match_date, "시간:", match.start_time);
						
						// 날짜 형식 처리
						var dateStr = match.match_date;
						
						if (dateStr && dateStr.includes(" 00:00:00"))
							// "2025-04-17 00:00:00" 형식에서 시간 부분 제거
							dateStr = dateStr.split(" ")[0];
						
						// 시작 시간 형식 처리
						var startTimeStr = match.start_time;
						
						if (startTimeStr && startTimeStr.includes("~"))
							// "10:00~11:50" 형식에서 시작 시간만 추출
							startTimeStr = startTimeStr.split("~")[0].trim();
						
						// 종료 시간 형식 처리
						var endTimeStr = match.end_time;
						
						if (endTimeStr && endTimeStr.includes("~"))
							// "10:00~11:50" 형식에서 시작 시간만 추출
							endTimeStr = endTimeStr.split("~")[1].trim();
						
						// 완전한 ISO 형식으로 조합 (HH:MM 형식이면 :00 초 추가)
						var startDateTime = dateStr;
						
						if (startTimeStr)
							// FullCalendar에 맞는 ISO 형식으로 변환 (~ 제거)
							startDateTime = dateStr + "T" + startTimeStr;
						
						return { id: match.field_res_id,
								 title: match.home_team_name + (match.away_team_name ? ' vs ' + match.away_team_name : ''),
								 start: dateStr + "T" + startTimeStr,	// start 필드에는 시작 시간만
								 end: endTimeStr ? dateStr + "T" + endTimeStr : null,	// end 필드 별도 지정
								 extendedProps:
								 {
									 homeTeam: match.home_team_name,
									 awayTeam: match.away_team_name ? match.away_team_name : "",  // null이면 빈 문자열로 설정
									 homeScore: match.match_result_home_score || '-',
									 awayScore: match.match_result_away_score || '-',
									 venue: match.stadium_addr,
									 attendance: match.match_inwon,
									 status: match.match_status,
									 fullTime: startTimeStr + "~" + endTimeStr || ""
								 },
								 className: 'event-' + (match.match_status ? match.match_status.replace(/\s+/g, '-').toLowerCase() : 'default')
								};
					});
			
					console.log("변환된 이벤트:", events);
					successCallback(events);
				},
				error: function(xhr, status, error)
				{
					console.error('일정을 불러오는데 실패했습니다:', error);
					failureCallback(error);
				}
			});
		},
	    locale: 'ko',
	    eventClick: function(info)
	    {
	    	showMatchDetails(info);
	    }
	});
	
	calendar.render();
	
	// 필터 버튼 이벤트 설정
	document.querySelectorAll('.status-filter-btn').forEach(function(button)
	{
		button.addEventListener('click', function()
		{
			var status = this.getAttribute('data-status');
			filterMatchesByStatus(status);
			
			// 활성화된 버튼 스타일 변경
			document.querySelectorAll('.status-filter-btn').forEach(function(btn)
			{
				btn.classList.remove('active');
			});
			
			this.classList.add('active');
		});
	});
	
	// '전체' 필터 버튼 초기 활성화
	document.querySelector('.status-filter-btn[data-status="all"]').classList.add('active');
	
	// 초기 데이터 로드
	fetchEvents();
	
	// [1 순서] AJAX로 이벤트 데이터 가져오기 (기존 코드 유지)
	function fetchEvents()
	{
		loadEvents(null, null, function(events)
		{
			updateListView(events);
		});
	}
	
	// [2 순서] 목록 뷰 업데이트 - 수정된 버전으로 교체
	function updateListView(events)
	{
		var listView = document.getElementById('listView');
		
		listView.innerHTML = '';
		
		if (!events || events.length == 0)
		{
			listView.innerHTML = '<div class="text-center p-5">등록된 경기 일정이 없습니다.</div>';
			return;
		}
		
		// 전체 이벤트 저장
		currentEvents = events;
		
		// 현재 활성화된 필터 찾기
		var activeFilter = document.querySelector('.status-filter-btn.active');
		var status = activeFilter ? activeFilter.getAttribute('data-status') : 'all';
		
		// 필터링 적용
		filterMatchesByStatus(status);
	}
	
	// 보기 전환 버튼 이벤트
	document.getElementById('listViewBtn').addEventListener('click', function()
	{
		document.getElementById('listView').style.display = 'block';
		document.getElementById('calendarView').style.display = 'none';
		document.getElementById('listViewBtn').classList.add('active');
		document.getElementById('calendarViewBtn').classList.remove('active');
	});
	
	document.getElementById('calendarViewBtn').addEventListener('click', function()
	{
		document.getElementById('listView').style.display = 'none';
		document.getElementById('calendarView').style.display = 'block';
		document.getElementById('listViewBtn').classList.remove('active');
		document.getElementById('calendarViewBtn').classList.add('active');
		calendar.updateSize();
	});
});

// 전역 함수로 정의
function filterMatchesByStatus(status)
{
	var listView = document.getElementById('listView');
	
	listView.innerHTML = '';
	
	if (!currentEvents || currentEvents.length == 0)
	{
		listView.innerHTML = '<div class="text-center p-5">등록된 경기 일정이 없습니다.</div>';
		return;
	}
	
	// 필터링된 이벤트
	var filteredEvents;
	
	if (status == 'all' || status == '전체')
	    filteredEvents = currentEvents; // 전체 보기
	
	else
	{
		filteredEvents = currentEvents.filter(function(event)
		{
			return getStatusText(event.extendedProps.status) === status;
		});
	}
	
	if (filteredEvents.length == 0)
	{
		listView.innerHTML = '<div class="text-center p-5">해당 상태의 경기 일정이 없습니다.</div>';
		return;
	}
	
	// 날짜순 정렬
	filteredEvents.sort(function(a, b)
	{
		return new Date(a.start) - new Date(b.start);
	});
	
	// 목록 업데이트
	filteredEvents.forEach(function(event)
	{
		createMatchListItem(event, listView);
	});
}

// [1 순서] AJAX로 이벤트 데이터 가져오기
function fetchEvents()
{
	loadEvents(null, null, function(events)
	{
		updateListView(events);
	});
}

// [2 순서] 목록 뷰 업데이트
function updateListView(events)
{
	var listView = document.getElementById('listView');
	listView.innerHTML = '';
	
	if (!events || events.length == 0)
	{
		listView.innerHTML = '<div class="text-center p-5">등록된 경기 일정이 없습니다.</div>';
		return;
	}
	
	// 전체 이벤트 저장
	currentEvents = events;
	
	// 현재 활성화된 필터 찾기
	var activeFilter = document.querySelector('.status-filter-btn.active');
	var status = activeFilter ? activeFilter.getAttribute('data-status') : 'all';
	
	// 필터링 적용
	filterMatchesByStatus(status);
}

// 날짜 문자열을 올바르게 파싱하는 함수
function parseMatchDate(dateStr)
{
	// "2025-04-17 00:00:00T10:00" 형식을 분리
	var parts = dateStr.split('T');
	var datePart = parts[0].split(' ')[0]; // "2025-04-17" 부분만 추출
	var timePart = parts[1]; // "10:00" 부분 추출
	
	// ISO 형식으로 조합
	return new Date(`${datePart}T${timePart}:00`);
}

// [3 순서] 경기 목록 아이템 생성
function createMatchListItem(event, container)
{
	var props = event.extendedProps;
	var id = event.id;
	
    // 날짜 추출 및 형식화
    var formattedDate = "날짜 정보 없음";
    
	if (event.start)
	{
		var dateObj;
		
		if (typeof event.start == 'string')
		{
			// ISO 형식의 문자열에서 날짜 부분만 추출
			var datePart = event.start.split('T')[0];
			dateObj = new Date(datePart);
		}
		
		else
			dateObj = new Date(event.start);
		
		if (!isNaN(dateObj.getTime()))
		{
			// 연, 월, 일 추출
			var year = dateObj.getFullYear();
			var month = dateObj.getMonth() + 1;
			var day = dateObj.getDate();
			
			// 기본 날짜 형식
			formattedDate = year + '년 ' + month + '월 ' + day + '일';
			
			// 시간 정보 추가 (있는 경우)
			if (props.fullTime)
				formattedDate += ' ' + props.fullTime;
		}
	}
	
	var statusStyle = getStatusStyle(props.status);
	var statusText = getStatusText(props.status);
	
	console.log("상태:", statusText);
	console.log("시작 날짜:", event.start);
	console.log("현재 날짜:", new Date());
	console.log("조건 결과:", statusText != "취소됨" && new Date(event.start) > new Date());
	
	var matchItem = document.createElement('div');
	matchItem.className = 'match-item';
	
	// 날짜 문자열을 올바르게 파싱하는 함수
	function parseMatchDate(dateStr)
	{
		// "2025-04-17 00:00:00T10:00" 형식을 분리
		var parts = dateStr.split('T');
		var datePart = parts[0].split(' ')[0]; // "2025-04-17" 부분만 추출
		var timePart = parts[1]; // "10:00" 부분 추출=
		
		// ISO 형식으로 조합
		return new Date(`${datePart}T${timePart}:00`);
	}
	
	// matchItem.innerHTML 내에서 조건 수정
	matchItem.innerHTML =
		'<div class="match-header">' +
			'<span class="match-date">' + formattedDate + '</span>' +
			'<span class="match-status" style="' + statusStyle + '">' + statusText + '</span>' +
		'</div>' +
		'<div class="match-teams">' +
			'<div class="team">' +
				'<div class="team-name">' + props.homeTeam + '</div>' +
				'<div class="team-score">' + props.homeScore + '</div>' +
			'</div>' +
			'<div class="vs">VS</div>' +
			'<div class="team">' +
				'<div class="team-name">' + props.awayTeam + '</div>' +
				'<div class="team-score">' + props.awayScore + '</div>' +
			'</div>' +
		'</div>' +
		'<div class="match-details">' +
			'<div class="detail-item">' +
				'<div>'+
					'<span class="detail-label">경기장:</span>' +
					'<span>' + props.venue + '</span>' +
				'</div>'+
				'<div>'+
					'<span class="detail-label">참석 인원:</span>' +
					'<span>' + props.attendance + '</span>' +
				'</div>'+
			'</div>' +
			'<div class="buttons-container">' +
			  (statusText !== "취소됨" && (statusText === "예정됨" || statusText === "상대미정" || statusText === "결제대기") ? 
			    '<a class="match-btn btn btn-outline-primary" href="ApplyMatch.action?field_res_id=' + id + '" ' +
			    'onclick="return confirm(\'참여하시겠습니까?\');">참가 하기</a>' : '') +
			  '<a class="match-btn btn btn-outline-secondary" href="Participant.action?field_res_id=' + id + '">참가인원 보기</a>' +
			  (statusText === "결제대기" && teamStatus === 1 ? 
			    '<a class="match-btn btn btn-outline-success" href="ApproveMatch.action?field_res_id=' + id + '" ' +
			    'onclick="return confirm(\'정말 결재 승인하시겠습니까?\');">결재 승인</a>' : '') +
			'</div>'

		'</div>';
	
	container.appendChild(matchItem);
}

// 상태별 스타일
function getStatusStyle(status)
{
	switch(status)
	{
		case '예정됨': return 'background-color: #e3f2fd; color: #1976d2; border-radius: 10px; padding: 5px 10px 5px 10px;';
		case '완료됨': return 'background-color: #e8f5e9; color: #388e3c; border-radius: 10px; padding: 5px 10px 5px 10px;';
		case '취소됨': return 'background-color: #ffebee; color: #c62828; border-radius: 10px; padding: 5px 10px 5px 10px;';
		case '결제대기': return 'background-color: #fff3e0; color: #e65100; border-radius: 10px; padding: 5px 10px 5px 10px;';
		case '결과입력대기': return 'background-color: #f3e5f5; color: #7b1fa2; border-radius: 10px; padding: 5px 10px 5px 10px;';
		default: return 'background-color: #e0e0e0; color: #616161; border-radius: 10px; padding: 5px 10px 5px 10px;';
	}
}

// 날짜 범위에 따른 이벤트 로드
function loadEvents(start, end, successCallback, failureCallback)
{
	$.ajax(
	{
		url: contextPath + '/MatchList.action',
		type: 'GET',
		data: start && end ? { start: start, end: end } : {},
		dataType: 'json',
		success: function(data)
		{
			// 서버에서 받은 데이터를 FullCalendar 형식으로 변환
			var events = transformEvents(data);
			
			if (typeof successCallback == 'function')
            	successCallback(events);
		},
		error: function(xhr, status, error)
		{
			console.error('일정을 불러오는데 실패했습니다:', error);
			
			if (typeof failureCallback == 'function')
				failureCallback(error);
		}
	});
}

// 데이터 변환 함수
function transformEvents(data)
{
	if (!data || data.length == 0)
	{
		return [];
	}
	
	return data.map(function(match)
	{
		// 시작 시간과 종료 시간 처리
		var startTimeStr = match.start_time;
		var endTimeStr = match.end_time;
		
		if (startTimeStr && startTimeStr.includes("~"))
		{
			// "10:00~11:50" 형식에서 분리
			var timeParts = startTimeStr.split("~");
			startTimeStr = timeParts[0].trim();
			endTimeStr = timeParts[1] ? timeParts[1].trim() : endTimeStr;
		}
		
		// 전체 시간 문자열 생성
		var fullTimeStr = startTimeStr + (endTimeStr ? "~" + endTimeStr : "");
		
		return {
			id: match.field_res_id,
			title: match.home_team_name + (match.away_team_name ? ' vs ' + match.away_team_name : ''),
			start: match.match_date + 'T' + startTimeStr,
			extendedProps:
			{
				homeTeam: match.home_team_name,
				awayTeam: match.away_team_name ? match.away_team_name : "",  // null이면 빈 문자열로 설정
				homeScore: match.match_result_home_score || '-',
				awayScore: match.match_result_away_score || '-',
				venue: match.stadium_addr,
				attendance: match.match_inwon,
				status: match.match_status,
				fullTime: fullTimeStr	// 전체 시간 문자열 추가
			},
			className: 'event-' + match.match_status
		};
	});
}

// 경기 상세 정보 표시
function showMatchDetails(info)
{
	var event = info.event;
	var props = event.extendedProps;
	
	// 날짜 형식화
	var date = new Date(event.start);
	var options =
	{ 
		year: 'numeric', 
		month: 'long', 
		day: 'numeric', 
		weekday: 'short'
	};
	
	var formattedDate = date.toLocaleDateString('ko-KR', options);
	
	// 시간 정보가 있으면 원래 시간 범위 표시
	if (props.fullTime)
		formattedDate += ' ' + props.fullTime;
	
	// 모달 내용 생성 (앞의 코드와 동일)
	document.getElementById('matchDetailsContent').innerHTML = 
		'<div class="match-header">' +
			'<span class="match-date">' + formattedDate + '</span>' +
			'<span class="match-status" style="' + getStatusStyle(props.status) + '">' + getStatusText(props.status) + '</span>' +
		'</div>' +
		'<div class="match-teams" style="margin: 20px 0;">' +
			'<div class="team">' +
				'<div class="team-name">' + props.homeTeam + '</div>' +
				'<div class="team-score">' + props.homeScore + '</div>' +
			'</div>' +
			'<div class="vs">VS</div>' +
			'<div class="team">' +
				'<div class="team-name">' + props.awayTeam + '</div>' +
				'<div class="team-score">' + props.awayScore + '</div>' +
			'</div>' +
		'</div>' +
		'<div class="match-details">' +
			'<div class="detail-item">' +
				'<span class="detail-label">경기장:</span>' +
				'<span>' + props.venue + '</span>' +
			'</div>' +
			'<div class="detail-item">' +
				'<span class="detail-label">참석 인원:</span>' +
				'<span>' + props.attendance + '</span>' +
			'</div>' +
		'</div>';
	
	document.getElementById('matchDetailsModal').style.display = 'flex';
	document.getElementById('menu-bar').classList.add('blur-background');
	document.getElementById('floatingButton-wrapper').classList.add('blur-background');
	document.getElementById('filterPanel').classList.add('blur-background');
}

// 상태 텍스트
function getStatusText(status)
{
	return status || '상태 정보 없음';
}

// 모달 기능
function closeDetailsModal()
{
	document.getElementById('matchDetailsModal').style.display = 'none';
	document.getElementById('menu-bar').classList.remove('blur-background');
	document.getElementById('floatingButton-wrapper').classList.remove('blur-background');
	document.getElementById('filterPanel').classList.remove('blur-background');
}

// 기본 날짜 설정
function setDefaultDate()
{
	var today = new Date();
	var yyyy = today.getFullYear();
	var mm = String(today.getMonth() + 1).padStart(2, '0');
	var dd = String(today.getDate()).padStart(2, '0');
	document.getElementById('matchDate').value = yyyy + '-' + mm + '-' + dd;
}

// 폼 제출 처리
function submitMatchForm()
{
	var matchDate = document.getElementById('matchDate').value;
	var matchTime = document.getElementById('matchTime').value;
	var homeTeam = document.getElementById('homeTeam').value;
	var awayTeam = document.getElementById('awayTeam').value;
	var venue = document.getElementById('venue').value;
	var matchType = document.getElementById('matchType').value;
	
	if (!matchDate || !matchTime || !homeTeam || !awayTeam || !venue)
	{
		alert('필수 항목을 모두 입력해주세요.');
		return;
	}
	
	$.ajax(
	{
		url: contextPath + '/api/matches',
		type: 'POST',
		contentType: 'application/json',
		data: JSON.stringify(
		{
			matchDate: matchDate,
			matchTime: matchTime,
			homeTeam: homeTeam,
			awayTeam: awayTeam,
			venue: venue,
			matchType: matchType,
			status: 'upcoming'
		}),
		success: function(response)
		{
			alert('경기 일정이 추가되었습니다.');
			document.getElementById('matchForm').reset();
			closeModal();
			fetchEvents();
			document.getElementById('calendarViewBtn').click();
		},
		error: function(xhr, status, error)
		{
			console.error('일정 추가에 실패했습니다:', error);
			alert('일정 추가에 실패했습니다. 다시 시도해주세요.');
		}
	});
}