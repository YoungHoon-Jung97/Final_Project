/*
	Template.js
*/

$(function()
{
	$(".search-box").hide();

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

	$(".search-icon").click(function()
	{
		if ($(this).hasClass("active"))
		{
			$(this).removeClass("active").text("🔍");
			$(".search-box").slideUp();
			$(".right-menu").removeClass("expanded");
		}
		
		else
		{
			$(this).addClass("active").text("✖");
			$(".search-box").slideDown();
			$(".right-menu").addClass("expanded");
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
	
	$(".field").click(function()
	{
		window.location.href = "Field.action";
	});
	
	$(".stadium").click(function()
	{
		window.location.href = "Stadium.action";
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
});