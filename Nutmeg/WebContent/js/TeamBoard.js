/*
	TeamBoard.js
*/

document.addEventListener("DOMContentLoaded", function ()
{
	var rows = document.querySelectorAll(".clickable-row");
	
	rows.forEach(row =>
	{
		row.addEventListener("click", function ()
		{
			var href = this.getAttribute("data-href");
			
			if (href)
				window.location.href = href;
		});
	});
});