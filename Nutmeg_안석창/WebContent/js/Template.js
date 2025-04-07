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
			
			if (user_id != null)
				$(".user-menu").hide();
		}
		
		else
		{
			$(this).removeClass("inactive").addClass("active");
			$(this).find(".user-icon").removeClass("inshrink").addClass("shrink");
			
			if (user_id != null)
				$(".user-menu").show();
		}
	});
	
	$(".team").click(function()
	{
		window.location.href = "Team.action";
	});
	
	$(".temp-team").click(function()
	{
		window.location.href = "TempTeam.action";
	});
	
	$(".stadium").click(function()
	{
		window.location.href = "Stadium.action";
	});
	
	$(".stadium-reg").click(function()
	{
		window.location.href = "StadiumReg.action";
	});
	
	$(".field").click(function()
	{
		window.location.href = "Field.action";
	});
	
	$(".field-reg").click(function()
	{
		window.location.href = "FieldReg.action";
	});
	
	$(".mercenary-offer").click(function()
	{
		window.location.href = "MercenaryOffer.action";
	});
	
	$(".mercenary").click(function()
	{
		window.location.href = "Mercenary.action";
	});
	
	$(".match").click(function()
	{
		window.location.href = "Match.action";
	});
	
	$(".myInformation").click(function()
	{
		window.location.href = "MyInformation.action";
	});
	
	$(".myTeam").click(function()
	{
		window.location.href = "MyTeam.action";
	});
	
	$(".logout").click(function()
	{
		var currentPath = window.location.pathname.replace("/Nutmeg", "");
		var currentUrl = currentPath + window.location.search;
		var returnUrl = currentUrl + (currentUrl.includes('?') ? '&' : '?') + "logoutMsg=1";
		
		window.location.href = "/Nutmeg" + "/Logout.action?returnUrl=" + encodeURIComponent(returnUrl);
	});
});