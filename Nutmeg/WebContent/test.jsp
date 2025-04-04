<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp =	request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>test.jsp</title>

<style type="text/css">

.menu-icon {
    width: 80px;
    height: 52px; /* (3 * 8px) + (2 * 14px) = 52px */
    cursor: pointer;
    z-index: 50;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.menu-icon .line-1,
.menu-icon .line-2,
.menu-icon .line-3 {
    height: 8px;
    width: 100%;
    background-color: #fff;
    border-radius: 3px;
    box-shadow: 0 2px 10px 0 rgba(0, 0, 0, 0.3);
    transition: background-color 0.2s ease-in-out;
}

.menu-icon .line-2 {
    margin: 14px 0;
}

/* Hover 효과 */
.menu-icon:hover .line-1,
.menu-icon:hover .line-2,
.menu-icon:hover .line-3 {
    background-color: #888;
}

/* ✅ Active 상태 - 애니메이션 적용 */
.menu-icon.active .line-1 {
    animation: animate-line-1 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.active .line-2 {
    animation: animate-line-2 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.active .line-3 {
    animation: animate-line-3 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}

/* ✅ Inactive 상태 - 역방향 애니메이션 적용 */
.menu-icon.inactive .line-1 {
    animation: animate-line-1-rev 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.inactive .line-2 {
    animation: animate-line-2-rev 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}
.menu-icon.inactive .line-3 {
    animation: animate-line-3-rev 0.7s cubic-bezier(0.3, 1, 0.7, 1) forwards;
}

/* Keyframes */
@keyframes animate-line-1 {
    0% { transform: translate3d(0, 0, 0) rotate(0deg); }
    50% { transform: translate3d(0, 22px, 0) rotate(0); }
    100% { transform: translate3d(0, 22px, 0) rotate(45deg); }
}

@keyframes animate-line-2 {
    0% { transform: scale(1); opacity: 1; }
    100% { transform: scale(0); opacity: 0; }
}

@keyframes animate-line-3 {
    0% { transform: translate3d(0, 0, 0) rotate(0deg); }
    50% { transform: translate3d(0, -22px, 0) rotate(0); }
    100% { transform: translate3d(0, -22px, 0) rotate(135deg); }
}

/* 역방향 애니메이션 */
@keyframes animate-line-1-rev {
    0% { transform: translate3d(0, 22px, 0) rotate(45deg); }
    50% { transform: translate3d(0, 22px, 0) rotate(0); }
    100% { transform: translate3d(0, 0, 0) rotate(0deg); }
}

@keyframes animate-line-2-rev {
    0% { transform: scale(0); opacity: 0; }
    100% { transform: scale(1); opacity: 1; }
}

@keyframes animate-line-3-rev {
    0% { transform: translate3d(0, -22px, 0) rotate(135deg); }
    50% { transform: translate3d(0, -22px, 0) rotate(0); }
    100% { transform: translate3d(0, 0, 0) rotate(0deg); }
}

</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	$(function ()
	{
		$(".menu-icon").click(function ()
		{
			if ($(this).hasClass("active"))
			{
				$(this).removeClass("active");
				$(this).addClass("inactive");
			}
			
			else
			{
				$(this).removeClass("inactive");
				$(this).addClass("active");
			}
	    });
	});

</script>

</head>
<body>
    <div class="menu-icon">
        <div class="line-1"></div>
        <div class="line-2"></div>
        <div class="line-3"></div>
    </div>
</body>
</html>