/*
	ajax.js
*/

var ajax;

//AJAX(XMLHttpRequest 객체) 객체 생성하는 함수
function createAjax()
{
	if(window.XMLHttpRequest)
		return new XMLHttpRequest();
	
	else if(window.ActiveXObject)
		return new ActiveXObject("Microsoft.XMLHTTP");
	
	else
		return null;
}