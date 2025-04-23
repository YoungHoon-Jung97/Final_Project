/*
	UserInfoEdit.js
*/

var original =
{
	email : "${userInfo.user_email}",
	tel : "${userInfo.user_tel}",
	nick : "${userInfo.user_nick_name}",
	postal : "${userInfo.user_postal_addr}",
	addr : "${userInfo.user_addr}",
	detailed : "${userInfo.user_detailed_addr}"
};

function execPostCode()
{
	new daum.Postcode(
	{
		oncomplete : function(data)
		{
			var addr = data.roadAddress ? data.roadAddress : data.jibunAddress;
			$("#post").val(data.zonecode);
			$('#address1').val(addr);
			$('#address2').focus();
		}
	}).open(
	{
		popupName : 'postPopup',
		width : 400,
		height : 500
	});
}

function resetPasswordFields()
{
	document.querySelector('input[name="user_pwd"]').value = '';
	document.querySelector('input[name="password2"]').value = '';
	document.querySelector('input[name="user_pwd"]').focus();
}

function handleSubmit()
{
	var pwd = document.querySelector('input[name="user_pwd"]').value.trim();
	var pwd2 = document.querySelector('input[name="password2"]').value.trim();
	var form = document.getElementById("updateForm");
	var hiddenCurrentPwd = document.querySelector('input[name="current_pwd"]');
	
	if (pwd != "" || pwd2 != "")
	{
		if (pwd != pwd2)
		{
			alert("❌ 비밀번호가 일치하지 않습니다.");
			resetPasswordFields();
			
			return;
		}
	}
	
	var current =
	{
		email : $('input[name="user_email"]').val().trim(),
		tel : $('input[name="user_tel"]').val().trim(),
		nick : $('input[name="user_nick_name"]').val().trim(),
		postal : $('input[name="user_postal_addr"]').val().trim(),
		addr : $('input[name="user_addr"]').val().trim(),
		detailed : $('input[name="user_detailed_addr"]').val().trim(),
		pwd : pwd
	};
	
	var allSame = (current.email == original.email
					&& current.tel == original.tel
					&& current.nick == original.nick
					&& current.postal == original.postal
					&& current.addr == original.addr
					&& current.detailed == original.detailed && pwd == "" && pwd2 == "");
	
	alert("✔️ 수정이 완료되었습니다.");
	form.submit();
}