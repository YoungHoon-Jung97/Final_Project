/*
	MainPage.js
*/

$(function()
{
	$(".card-action").on("click",function()
	{
		var card = $(this).closest('.card');
		
		// 팀 정보를 객체로 묶어서 관리
		var teamInfo =
		{
			name: card.find('#teamName').val(),
			desc: card.find('#teamDesc').val(),
			region: card.find('#teamRegion').val(),
			city: card.find('#teamCity').val(),
			memberCount: card.find('#teamMemberCount').val(),
			emblem: card.find('#teamEmblem').val(),
			status: card.find('#teamStaus').val(),
			id: card.find('#teamId').val()
		};
		
		// 모달 정보 세팅
		$('#descTeamName').text(teamInfo.name);
		
		var descText = (teamInfo.desc == null || teamInfo.desc.trim() == "") ? "없음" : teamInfo.desc;
		$('#descTeamDesc').text(descText);
		
		$('#descTeamReion').text(teamInfo.region);
		$('#descTeamCity').text(teamInfo.city);
		$('#descTeamMemberCount').text(teamInfo.memberCount);
		
		if (!teamInfo.emblem || teamInfo.emblem == "/")
			$('#descTeamEmblem').attr('src', 'images/noEmblem.png');
		
		else
			$('#descTeamEmblem').attr('src', teamInfo.emblem);
		
		// 팀 상태에 따라 표시
		var statusText = (teamInfo.status == 0) ? '임시' : '정식';
		
		$('#descTeamStaus').text(statusText);
		$('#teamApply').attr('href', 'TeamApply.action?team_id='+teamInfo.id);
		
		// 모달 열기
		$('#descModal').css('display', 'flex');
		$("#descModal").show();
		$("body").css("overflow", "hidden");
		$("header, .floatingButton-wrapper, .filter-panel").addClass("blur-background");
	});
		
	// 모달 닫기 버튼
	$("#cancel-desc").on("click", function()
	{
		$('#descModal').css('display', 'none');
		$("#descModal").hide(); // 모달 숨기기
		$("body").css("overflow", "auto"); // 페이지 스크롤 복원
		$("header, .floatingButton-wrapper, .filter-panel").removeClass("blur-background");
	});
});