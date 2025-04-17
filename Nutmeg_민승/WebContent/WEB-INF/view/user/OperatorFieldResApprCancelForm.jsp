<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<div>
    <div class="mb-3">
        <label class="form-label">반려 사유를 적어주세요</label>
    </div>
    <div class="mb-3">
        <label class="form-label">상세 사유</label>
        <textarea class="form-control" rows="4" placeholder="상세한 사유를 입력하세요" name="field_pay_cancel_reason"></textarea>
    </div>
    <input type="hidden" name="field_res_id" value="${field_res_id}" />
    <div class="text-end">
        <button type="button" class="btn btn-danger">반려 확정</button>
    </div>
</div>