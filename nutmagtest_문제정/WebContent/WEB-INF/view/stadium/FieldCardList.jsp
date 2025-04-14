<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<c:forEach var="field" items="${fieldList}">
    <div class="col-6">
        <div class="card h-100">
            <div class="row g-0">
                <div class="col-5 field-img">
                    <img src="${field.field_reg_image}" class="img-fluid rounded-start"
                         style="height: 250px; width: 250px; object-fit: cover;">
                </div>
                <div class="col-7 d-flex flex-column justify-content-between">
                    <div class="card-body">
                        <h4 class="card-title">구장: ${field.stadium_reg_name}</h4>
                        <h5 class="card-title">경기장: ${field.field_reg_name}</h5>
                        <p class="card-text">주소: ${field.stadium_reg_addr}, ${field.stadium_reg_detailed_addr}</p>
                        <p class="card-text">이용요금: ${field.field_reg_price}원</p>
                        <p class="card-text">이용시간: ${field.stadium_time_name1}시 ~ ${field.stadium_time_name2}시</p>
                    </div>
                    <div class="px-3 pb-3 d-flex justify-content-end align-items-end mt-auto">
                    	<input type="hidden" class="field_code_id" value="${field.field_code_id}" />
                        <button type="button" class="btn btn-outline-primary">경기장 예약하기</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>