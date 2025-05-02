<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<li class="nav-item">
    <a class="nav-link active" href="#" data-id="">전체</a>
</li>
<c:forEach var="city" items="${cityList}">
    <li class="nav-item">
        <a class="nav-link" href="#" data-id="${city.city_id}">${city.city_name}</a>
    </li>
</c:forEach>