/*
	Template.js
*/

$(function()
{
	$(".menu-icon").click(function()
	{
		if ($(this).hasClass("active"))
		{
			$(this).removeClass("active").addClass("inactive");
			$(".nav-menu").removeClass("active");
			$(".nav-sub").hide();
		}
		
		else
		{
			$(this).removeClass("inactive").addClass("active");
			$(".nav-menu").addClass("active");
			$(".nav-sub").show();
		}
	});
	
	$(".right-menu").on("click", function ()
	{
		if ($(this).hasClass("active"))
		{
			$(this).removeClass("active").addClass("inactive");
			$(this).find(".user-icon").removeClass("shrink").addClass("inshrink");
			
			if (user_code_id != null)
				$(".user-menu").hide();
		}
		
		else
		{
			$(this).removeClass("inactive").addClass("active");
			$(this).find(".user-icon").removeClass("inshrink").addClass("shrink");
			
			if (user_code_id != null)
				$(".user-menu").show();
		}
	});
	
	// 동호회 모집
	$(".teamRecruit").click(function()
	{
		window.location.href = "MainPage.action";
	});
	
	// 동호회 개설
	$(".temp-team").click(function()
	{
		window.location.href = "TeamOpen.action";
	});
	
	// 경기장 예약
	$(".field").click(function()
	{
		window.location.href = "StadiumMainPage.action";
	});
	
	// 경기장 등록
	$(".field_reg").click(function()
	{
		window.location.href = "StadiumListForm.action";
	});
	
	// 구장 등록
	$(".stadium_reg").click(function()
	{
		window.location.href = "StadiumRegInsertForm.action";
	});
	
	// 용병 게시판
	$(".mercenary-offer").click(function()
	{
		window.location.href = "MercenaryOffer.action";
	});
	
	// 용병 등록
	$(".mercenary").click(function()
	{
		window.location.href = "MercenaryInsertForm.action";
	});
	
	// 매치 참가
	$(".match").click(function()
	{
		window.location.href = "MatchMainPage.action";
	});
	
	// 회사소개
	$(".company").click(function()
	{
		window.location.href = "Aboutme.action";
	});
	
	// 알림
	$(".bi-bell-fill, .bi-bell").click(function()
	{
		window.location.href = "UserNotification.action";
	});
	
	// 내 정보
	$(".myInformation").click(function()
	{
		window.location.href = "UserMainPage.action";
	});
	
	// 내 동호회
	$(".myTeam").click(function()
	{
		window.location.href = "TeamMain.action";
	});
	
	// 구장운영자 가입
	$(".operatorSignUp").click(function()
	{
		window.location.href = "OperatorSignupForm.action";
	});
	
	// 내 구장
	$(".myStadium").click(function()
	{
		window.location.href = "OperatorMainPage.action";
	});
	
	// 로그아웃
	$(".logout").click(function()
	{
		var currentPath = window.location.pathname.replace("/Nutmeg", "");
		var currentUrl = currentPath + window.location.search;
		var returnUrl = currentUrl + (currentUrl.includes('?') ? '&' : '?') + "logoutMsg=1";
		
		window.location.href = "/Nutmeg" + "/Logout.action?returnUrl=" + encodeURIComponent(returnUrl);
	});
});