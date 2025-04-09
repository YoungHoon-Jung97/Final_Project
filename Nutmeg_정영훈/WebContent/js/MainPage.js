/*
	MainPage.js
*/

$(function()
{
	$("#descModal").css('display','none');
	
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
		$('#descTeamDesc').text(teamInfo.desc);
		$('#descTeamReion').text(teamInfo.region);
		$('#descTeamCity').text(teamInfo.city);
		$('#descTeamMemberCount').text(teamInfo.memberCount);
		$('#descTeamEmblem').attr('src', teamInfo.emblem);
		
		// 팀 상태에 따라 표시
		var statusText = (teamInfo.status == 0) ? '임시' : '정식';
		
		$('#descTeamStaus').text(statusText);
		$('#teamApply').attr('href', 'TeamApply.action?teamId='+teamInfo.id);
		
		// 모달 열기
    	$("#descModal").show();
    	$("body").css("overflow", "hidden");
    	$(".floatingButton-wrapper").addClass("blur-background");
    	$("header").addClass("blur-background");
    });
	
	// 모달 닫기 버튼
	$("#cancel, #cancel-desc").on("click", function()
	{
		$("#descModal").hide(); // 모달 숨기기
		$("body").css("overflow", "auto"); // 페이지 스크롤 복원
		$(".floatingButton-wrapper").removeClass("blur-background");
		$("header, .navbar").removeClass("blur-background");
	});
});