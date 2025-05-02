/*
	FieldReservationCheckForm.js
*/

document.addEventListener("DOMContentLoaded", function()
{
	var radios = document.querySelectorAll(".toggle-group input[type='radio']");
	var underline = document.querySelector(".toggle-group .underline");
	
	function updateUnderline()
	{
		var activeRadio = document.querySelector(".toggle-group input[type='radio']:checked");
		var index = Array.from(radios).indexOf(activeRadio);
		var totalRadios = radios.length;
		var widthPercentage = 100 / totalRadios;

		underline.style.left = (index * widthPercentage) + "%";
		underline.style.width = widthPercentage + "%";
	}
	
	radios.forEach(function(radio)
	{
		radio.addEventListener("change", updateUnderline);
	});
	
	updateUnderline(); // 초기 위치 설정
});