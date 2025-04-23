<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="section-title">
  <i class="bi bi-list-check me-2"></i> 경기장 승인, 취소 내역
</div>
<h5>구장 승인 목록</h5>
<c:forEach var="ok" items="${fieldApprOkList}">
    <div class="match-card">
        <div class="stadium-card">
            <div class="stadium-img-wrapper">
            <img src="${ok.field_reg_image}" alt="" class="stadium-img">
                <div class="stadium-info">
                    <strong>${ok.field_reg_name}</strong> <br>
                    경기장 이름 : ${ok.field_reg_name} <br>
                    경기장 승인 신청일 : ${ok.field_reg_at } <br>
                    경기장 승인 허가일 : ${ok.field_appr_at }
                </div>
            </div>

        </div>

    </div>
</c:forEach>

<h5>구장 반려 목록</h5>
<c:forEach var="cancel" items="${fieldApprCancelList}">
    <div class="match-card">
        <div class="stadium-card">
            <div class="stadium-img-wrapper">
            <img src="${cancel.field_reg_image}" alt="" class="stadium-img">
                <div class="stadium-info">
                    <strong>${cancel.field_reg_name}</strong> <br>
                    경기장 이름 : ${cancel.field_reg_name} <br>
                    경기장 승인 신청일 : ${cancel.field_reg_at }
                    경기장 승인 반려일 : ${cancel.field_appr_cancel_at }
                </div>
            </div>

        </div>

    </div>
</c:forEach>
