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
    <title>동호회 공지사항</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .notice-container {
            max-width: 1000px;
            margin: 30px auto;
        }
        .notice-header {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .notice-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .notice-description {
            color: #6c757d;
        }
        .notice-table {
            margin-top: 20px;
        }
        .notice-table th {
            background-color: #f1f3f5;
            font-weight: 600;
        }
        .notice-footer {
            margin-top: 20px;
            display: flex;
            justify-content: space-between;
        }
        .fixed-notice {
            background-color: #fff8e6;
        }
        .pagination {
            margin-top: 20px;
            justify-content: center;
        }
        .search-container {
            margin: 20px 0;
        }
        .btn-write {
            background-color: #4a6fdc;
            color: white;
        }
        .btn-write:hover {
            background-color: #3558b6;
            color: white;
        }
        .notice-badge {
            font-size: 0.8rem;
            padding: 0.25em 0.6em;
            margin-right: 5px;
        }
    </style>
    <script type="text/javascript">
        $(function() {
            // 공지사항 상세보기 페이지로 이동
            $(".notice-row").click(function() {
                let noticeId = $(this).data("id");
                location.href = "NoticeDetail.action?notice_id=" + noticeId;
            });
            
            // 글쓰기 버튼 클릭 시 이벤트
            $("#writeBtn").click(function() {
                location.href = "NoticeInsertForm.action";
            });
            
            // 검색 기능
            $("#searchBtn").click(function() {
                let keyword = $("#keyword").val();
                let searchType = $("#searchType").val();
                
                if (keyword.trim() === "") {
                    alert("검색어를 입력해주세요.");
                    return;
                }
                
                location.href = "NoticeList.action?searchType=" + searchType + "&keyword=" + encodeURIComponent(keyword);
            });
        });
    </script>
</head>
<body>
    <!-- 템플릿 헤더 포함 -->
    <c:import url="/WEB-INF/view/Template.jsp"></c:import>
    
    <!-- 공지사항 컨테이너 -->
    <div class="notice-container">
        <div class="notice-header">
            <div class="notice-title">공지사항</div>
            <div class="notice-description">동호회 회원들에게 전달되는 중요한 공지사항입니다.</div>
        </div>
        
        <!-- 검색 기능 -->
        <div class="search-container">
            <div class="row">
                <div class="col-md-8 offset-md-2">
                    <div class="input-group">
                        <select class="form-select" id="searchType" style="max-width: 130px;">
                            <option value="title">제목</option>
                            <option value="content">내용</option>
                            <option value="writer">작성자</option>
                        </select>
                        <input type="text" class="form-control" id="keyword" placeholder="검색어를 입력하세요">
                        <button class="btn btn-outline-secondary" type="button" id="searchBtn">
                            <i class="bi bi-search"></i> 검색
                        </button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 공지사항 목록 테이블 -->
        <div class="notice-table">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th width="8%">번호</th>
                        <th width="50%">제목</th>
                        <th width="15%">작성자</th>
                        <th width="15%">작성일</th>
                        <th width="12%">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- 고정 공지사항 -->
                    <c:forEach var="fixed" items="${fixedNotices}">
                        <tr class="notice-row fixed-notice" data-id="${fixed.notice_id}">
                            <td>
                                <span class="badge bg-danger notice-badge">공지</span>
                            </td>
                            <td>
                                ${fixed.notice_title}
                                <c:if test="${fixed.has_file == 'Y'}">
                                    <i class="bi bi-paperclip"></i>
                                </c:if>
                                <c:if test="${fixed.is_new == 'Y'}">
                                    <span class="badge bg-success notice-badge">NEW</span>
                                </c:if>
                            </td>
                            <td>${fixed.user_name}</td>
                            <td>
                                <fmt:formatDate value="${fixed.created_at}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td>${fixed.view_count}</td>
                        </tr>
                    </c:forEach>
                    
                    <!-- 일반 공지사항 -->
                    <c:forEach var="notice" items="${noticeList}" varStatus="status">
                        <tr class="notice-row" data-id="${notice.notice_id}">
                            <td>${notice.rnum}</td>
                            <td>
                                ${notice.notice_title}
                                <c:if test="${notice.has_file == 'Y'}">
                                    <i class="bi bi-paperclip"></i>
                                </c:if>
                                <c:if test="${notice.is_new == 'Y'}">
                                    <span class="badge bg-success notice-badge">NEW</span>
                                </c:if>
                            </td>
                            <td>${notice.user_name}</td>
                            <td>
                                <fmt:formatDate value="${notice.created_at}" pattern="yyyy-MM-dd"/>
                            </td>
                            <td>${notice.view_count}</td>
                        </tr>
                    </c:forEach>
                    
                    <!-- 게시글이 없을 경우 -->
                    <c:if test="${empty noticeList && empty fixedNotices}">
                        <tr>
                            <td colspan="5" class="text-center">등록된 공지사항이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        
        <!-- 페이징 처리 -->
        <div class="pagination-container">
            <ul class="pagination">
                <c:if test="${paging.prev}">
                    <li class="page-item">
                        <a class="page-link" href="NoticeList.action?page=${paging.startPage-1}&searchType=${searchType}&keyword=${keyword}">
                            <i class="bi bi-chevron-left"></i>
                        </a>
                    </li>
                </c:if>
                
                <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="num">
                    <li class="page-item ${paging.page == num ? 'active' : ''}">
                        <a class="page-link" href="NoticeList.action?page=${num}&searchType=${searchType}&keyword=${keyword}">${num}</a>
                    </li>
                </c:forEach>
                
                <c:if test="${paging.next && paging.endPage > 0}">
                    <li class="page-item">
                        <a class="page-link" href="NoticeList.action?page=${paging.endPage+1}&searchType=${searchType}&keyword=${keyword}">
                            <i class="bi bi-chevron-right"></i>
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
        
        <!-- 하단 버튼 -->
        <div class="notice-footer">
            <div></div>
            <!-- 관리자만 글쓰기 버튼이 보이도록 설정 -->
            <c:if test="${userRole == 'ADMIN' || userRole == 'MANAGER'}">
                <button type="button" class="btn btn-write" id="writeBtn">
                    <i class="bi bi-pencil-square"></i> 글쓰기
                </button>
            </c:if>
        </div>
    </div>
</body>
</html>