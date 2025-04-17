<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<input type="hidden" name="field_reg_id" value="${field_reg_id}" />
<input type="hidden" name="user_code_id" value="${user_code_id}" />

<div>
    <div class="mb-3">
        <label class="form-label">반려 사유</label>
        <select class="form-select" name="field_appr_canncel_type_id">
            <option value="">사유를 선택 해주세요</option>
            <c:forEach var="canceltype" items="${cancelTypeList}">
                <option value="${canceltype.field_appr_cancel_type_id}">
                    ${canceltype.field_appr_cancel_type}
                </option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label class="form-label">상세 설명</label>
        <textarea class="form-control" rows="4" placeholder="상세한 사유를 입력하세요" name="field_appr_cancel_reason"></textarea>
    </div>
    <div class="text-end">
        <button class="btn btn-danger">반려 확정</button>
    </div>
</div>

<%-- <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<div class="card p-4 shadow-sm" style="max-width: 500px; margin: 30px auto;">
    <h5 class="mb-3">반려 사유 선택</h5>

    <div class="mb-3">
        <label for="cancelReasonSelect" class="form-label">사유 선택</label>
        <select id="cancelReasonSelect" class="form-select">
            <option value="">사유를 선택 해주세요</option>
            <c:forEach var="canceltype" items="${cancelTypeList}">
                <option value="${canceltype.field_appr_cancel_type_id}">
                    ${canceltype.field_appr_cancel_type}
                </option>
            </c:forEach>
        </select>
    </div>

    <div class="mb-5">
        <label for="cancelDetail" class="form-label">상세 내용</label>
        <textarea id="cancelDetail" class="form-control" rows="4" placeholder="상세한 반려 사유를 입력하세요"></textarea>
    </div>

    <div class="text-end">
        <button class="btn btn-secondary back-btn">뒤로가기</button>
    	<button class="btn btn-danger">반려 확정</button>
    </div>
</div> --%>