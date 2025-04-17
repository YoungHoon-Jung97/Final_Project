<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 상세보기</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .detail-container {
            max-width: 900px;
            margin: 30px auto;
        }
        .detail-header {
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
        .detail-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .detail-info {
            display: flex;
            justify-content: space-between;
            color: #6c757d;
            font-size: 14px;
        }
        .detail-content {
            min-height: 300px;
            margin: 30px 0;
            line-height: 1.8;
        }
        .detail-attachments {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .detail-footer {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            border-top: 1px solid #dee2e6;
            padding-top: 20px;
        }
        .btn-list {
            background-color: #6c757d;
            color: white;
        }
        .btn-list:hover {
            background-color: #5a6268;
            color: white;
        }
        .btn-edit, .btn-delete {
            background-color: #4a6fdc;
            color: white;
        }
        .btn-edit:hover, .btn-delete:hover {
            background-color: #3558b6;
            color: white;
        }
        .btn-delete {
            background-color: #dc3545;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
        .nav-item {
            width: 50%;
            text-align: center;
        }
        .nav-prev, .nav-next {
            padding: 10px;
            border: 1px solid #dee2e6;
            display: block;
            color: #212529;
            text-decoration: none;
        }
        .nav-prev:hover, .nav-next:hover {
            background-color: #f8f9fa;
        }
        .nav-title {
            width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            display: inline-block;
        }
    </style>
    <script type="text/javascript">
        $(function() {
            // 목록 버튼 클릭
            $("#listBtn").click(function() {
                location.href = "NoticeList.action";
            });
            
            // 수정 버튼 클릭
            $("#editBtn").click(function() {
                location.href = "NoticeUpdateForm.action?notice_id=${notice.notice_id}";
            });
            
            // 삭제 버튼 클릭
            $("#deleteBtn").click(function() {
                if(confirm("정말 삭제하시겠습니까?")) {
                    location.href = "NoticeDelete.action?notice_id=${notice.notice_id}";
                }
            });
        });
    </script>
</head>
<body>
    <!-- 템플릿 헤더 포함 -->
    <c:import url="/WEB-INF/view/Template.jsp"></c:import>
    
    <!-- 공지사항 상세 컨테이너 -->
    <div class="detail-container">
        <div class="detail-header">
            <div class="detail-title">
                <c:if test="${notice.is_fixed == 'Y'}">
                    <span class="badge bg-danger">공지</span>
                </c:if>
                ${notice.notice_title}
            </div>
            <div class="detail-info">
                <div>
                    <span><i class="bi bi-person"></i> ${notice.user_name}</span>
                    <span class="ms-3"><i class="bi bi-calendar3"></i> <fmt:formatDate value="${notice.created_at}" pattern="yyyy-MM-dd HH:mm"/></span>
                </div>
                <div>
                    <span><i class="bi bi-eye"></i> 조회 ${notice.view_count}</span>
                </div>
            </div>
        </div>
        
        <!-- 공지사항 내용 -->
        <div class="detail-content">
            ${notice.notice_content}
        </div>
        
        <!-- 첨부파일 영역 -->
        <c:if test="${not empty fileList}">
            <div class="detail-attachments">
                <div class="mb-2"><i class="bi bi-paperclip"></i> 첨부파일</div>
                <ul class="list-group">
                    <c:forEach var="file" items="${fileList}">
                        <li class="list-group-item">
                            <a href="FileDownload.action?file_id=${file.file_id}">
                                <i class="bi bi-file-earmark"></i> ${file.original_file_name} (${file.file_size}KB)
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
        
        <!-- 이전글/다음글 네비게이션 -->
        <div class="mt-4">
            <ul class="nav">
                <li class="nav-item">
                    <c:if test="${not empty prevNotice}">
                        <a class="nav-prev" href="NoticeDetail.action?notice_id=${prevNotice.notice_id}">
                            <i class="bi bi-chevron-left"></i> 이전글
                            <div class="nav-title">${prevNotice.notice_title}</div>
                        </a>
                    </c:if>
                    <c:if test="${empty prevNotice}">
                        <div class="nav-prev text-muted">
                            <i class="bi bi-chevron-left"></i> 이전글이 없습니다
                        </div>
                    </c:if>
                </li>
                <li class="nav-item">
                    <c:if test="${not empty nextNotice}">
                        <a class="nav-next" href="NoticeDetail.action?notice_id=${nextNotice.notice_id}">
                            다음글 <i class="bi bi-chevron-right"></i>
                            <div class="nav-title">${nextNotice.notice_title}</div>
                        </a>
                    </c:if>
                    <c:if test="${empty nextNotice}">
                        <div class="nav-next text-muted">
                            다음글이 없습니다 <i class="bi bi-chevron-right"></i>
                        </div>
                    </c:if>
                </li>
            </ul>
        </div>
        
        <!-- 버튼 영역 -->
        <div class="detail-footer">
            <button type="button" class="btn btn-list" id="listBtn">
                <i class="bi bi-list"></i> 목록
            </button>
            <div>
                <!-- 관리자나 작성자만 수정/삭제 버튼이 보이도록 설정 -->
                <c:if test="${userRole == 'ADMIN' || userRole == 'MANAGER' || notice.user_id == userId}">
                    <button type="button" class="btn btn-edit" id="editBtn">
                        <i class="bi bi-pencil-square"></i> 수정
                    </button>
                    <button type="button" class="btn btn-delete" id="deleteBtn">
                        <i class="bi bi-trash"></i> 삭제
                    </button>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>