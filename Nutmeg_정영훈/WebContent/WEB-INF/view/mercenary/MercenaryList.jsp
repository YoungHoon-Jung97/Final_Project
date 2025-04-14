<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
   String cp = request.getContextPath();
%>
<!-- 디버깅 -->
<c:if test="${not empty mercenaryList}">
    <script>
        console.log("mercenaryList 존재: ${mercenaryList.size()}개");
    </script>
</c:if>
<c:if test="${empty mercenaryList}">
    <script>
        console.log("mercenaryList가 비어있거나 null입니다");
    </script>
</c:if>


<!-- 리스트 출력 -->
<c:choose>
    <c:when test="${not empty mercenaryList}">
        <c:forEach var="mercenary" items="${mercenaryList}">
            <div class="table-row">
                <div class="table-cell">${mercenary.user_nick_name}</div>
                <div class="table-cell">${mercenary.position_name}</div>
                <div class="table-cell">${mercenary.region_name}</div>
                <div class="table-cell">${mercenary.city_name}</div>
                <div class="table-cell">
                    <form action="hireMercenary.action" method="POST">
                        <input type="hidden" name="mercenary_id" value="${mercenary.mercenary_id}">
                        <button type="submit" class="btn-hire">고용</button>
                    </form>
                </div>
            </div>
        </c:forEach>
    </c:when>
    <c:otherwise>
    <div class="table-row">
        <div class="table-cell" style="grid-column: span 5; text-align: center;">해당 지역에 등록된 용병이 없습니다.</div>
    </div>
</c:otherwise>
</c:choose>
 