<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 작성</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Summernote Editor CSS/JS -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
    <style>
        .form-container {
            max-width: 900px;
            margin: 30px auto;
        }
        .form-header {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .form-title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-description {
            color: #6c757d;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-footer {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
        }
        .btn-submit {
            background-color: #4a6fdc;
            color: white;
        }
        .btn-submit:hover {
            background-color: #3558b6;
            color: white;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
        .btn-cancel:hover {
            background-color: #5a6268;
            color: white;
        }
        .note-editor {
            margin-bottom: 20px;
        }
    </style>
    <script type="text/javascript">
        $(function() {
            // Summernote 에디터 초기화
            $('#notice_content').summernote({
                height: 300,
                minHeight: 200,
                maxHeight: 500,
                focus: true,
                lang: 'ko-KR',
                placeholder: '내용을 입력해주세요.',
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture']],
                    ['view', ['fullscreen', 'codeview', 'help']]
                ],
                callbacks: {
                    onImageUpload: function(files) {
                        // 이미지 업로드 기능 (필요시 구현)
                        uploadSummernoteImageFile(files[0], this);
                    }
                }
            });
            
            // 취소 버튼 클릭 시 이벤트
            $("#cancelBtn").click(function() {
                if(confirm("작성을 취소하시겠습니까? 작성된 내용은 저장되지 않습니다.")) {
                    location.href = "NoticeList.action";
                }
            });
            
            // 폼 제출 시 유효성 검사
            $("#noticeForm").submit(function(e) {
                if($("#notice_title").val().trim() === "") {
                    alert("제목을 입력해주세요.");
                    $("#notice_title").focus();
                    e.preventDefault();
                    return false;
                }
                
                if($("#notice_content").summernote('isEmpty')) {
                    alert("내용을 입력해주세요.");
                    $("#notice_content").summernote('focus');
                    e.preventDefault();
                    return false;
                }
                
                return true;
            });
            
            // 파일 선택 시 파일명 표시
            $(".custom-file-input").on("change", function() {
                var fileName = $(this).val().split("\\").pop();
                $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
            });
        });
        
        // 이미지 업로드 함수 (필요시 구현)
        function uploadSummernoteImageFile(file, editor) {
            var formData = new FormData();
            formData.append("file", file);
            
            $.ajax({
                data: formData,
                type: "POST",
                url: "UploadSummernoteImageFile.action",
                contentType: false,
                processData: false,
                success: function(data) {
                    $(editor).summernote('insertImage', data.url);
                }
            });
        }
    </script>
</head>
<body>
    <!-- 템플릿 헤더 포함 -->
    <c:import url="/WEB-INF/view/Template.jsp"></c:import>
    
    <!-- 공지사항 작성 폼 컨테이너 -->
    <div class="form-container">
        <div class="form-header">
            <div class="form-title">공지사항 작성</div>
            <div class="form-description">동호회 회원들에게 전달할 공지사항을 작성합니다.</div>
        </div>
        
        <form id="noticeForm" action="NoticeInsert.action" method="post" enctype="multipart/form-data">
            <!-- 제목 입력 -->
            <div class="form-group">
                <label for="notice_title" class="form-label">제목</label>
                <input type="text" class="form-control" id="notice_title" name="notice_title" placeholder="제목을 입력하세요" required>
            </div>
            
            <!-- 공지 고정 여부 -->
            <div class="form-group form-check">
                <input type="checkbox" class="form-check-input" id="is_fixed" name="is_fixed" value="Y">
                <label class="form-check-label" for="is_fixed">상단 고정 공지</label>
            </div>
            
            <!-- 내용 입력 (Summernote 에디터) -->
            <div class="form-group">
                <label for="notice_content" class="form-label">내용</label>
                <textarea class="form-control" id="notice_content" name="notice_content"></textarea>
            </div>
            
            <!-- 파일 첨부 -->
            <div class="form-group">
                <label for="uploadFile" class="form-label">첨부파일</label>
                <div class="input-group">
                    <input type="file" class="form-control" id="uploadFile" name="uploadFile" multiple>
                </div>
                <div class="form-text text-muted">
                    최대 5개까지 첨부 가능합니다. (파일당 최대 10MB)
                </div>
            </div>
            
            <!-- 버튼 영역 -->
            <div class="form-footer">
                <button type="button" class="btn btn-cancel" id="cancelBtn">
                    <i class="bi bi-x-circle"></i> 취소
                </button>
                <button type="submit" class="btn btn-submit">
                    <i class="bi bi-check2-circle"></i> 등록
                </button>
            </div>
        </form>
    </div>
</body>
</html>