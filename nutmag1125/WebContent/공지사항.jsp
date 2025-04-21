<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    request.setCharacterEncoding("UTF-8");
    String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>팀 투표</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/TeamMain.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/modal.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:nth-child(2) a {
    color: #a8d5ba;
    border-bottom: 2px solid #a8d5ba;
}

.container1 {
    width: 100%;
    background-color: white;
    height: 100%;
}

.vote-container {
    margin-top: 30px;
    margin-bottom: 40px;
}

.vote-list {
    margin-top: 20px;
}

.vote-item {
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
    background-color: #f9f9f9;
}

.vote-header {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    border-bottom: 1px solid #eee;
    padding-bottom: 10px;
}

.vote-title {
    font-size: 18px;
    font-weight: bold;
}

.vote-status {
    padding: 5px 10px;
    border-radius: 4px;
    font-size: 14px;
}

.vote-status.active {
    background-color: #e3f2fd;
    color: #1976d2;
}

.vote-status.ended {
    background-color: #e0e0e0;
    color: #616161;
}

.vote-info {
    margin-bottom: 15px;
    color: #666;
    font-size: 14px;
}

.vote-options {
    margin-bottom: 20px;
}

.vote-option {
    padding: 10px;
    margin-bottom: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    background-color: white;
    cursor: pointer;
    transition: all 0.2s;
}

.vote-option:hover {
    background-color: #f1f1f1;
}

.vote-option.selected {
    background-color: #e8f5e9;
    border-color: #a8d5ba;
}

.vote-option-name {
    font-weight: bold;
}

.vote-progress {
    height: 8px;
    margin-top: 5px;
    margin-bottom: 5px;
}

.vote-count {
    font-size: 13px;
    color: #777;
    text-align: right;
}

.vote-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.vote-results {
    margin-top: 20px;
}

.participant-list {
    margin-top: 15px;
}

.participant-item {
    display: inline-block;
    padding: 5px 10px;
    margin-right: 5px;
    margin-bottom: 5px;
    background-color: #f1f1f1;
    border-radius: 4px;
    font-size: 14px;
}

/* 신규 투표 모달 */
.modal-form-group {
    margin-bottom: 15px;
}

.option-input-group {
    display: flex;
    margin-bottom: 10px;
}

.option-input-group input {
    flex-grow: 1;
    margin-right: 10px;
}

.btn-add-option {
    margin-bottom: 15px;
}
</style>

<script>
$(document).ready(function() {
    // 투표 옵션 선택 처리
    $('.vote-option').click(function() {
        $(this).siblings('.vote-option').removeClass('selected');
        $(this).addClass('selected');
    });
    
    // 결과 보기 버튼 클릭 처리
    $('.btn-view-results').click(function() {
        const resultsSection = $(this).closest('.vote-item').find('.vote-results');
        
        if (resultsSection.is(':visible')) {
            resultsSection.slideUp();
            $(this).text('결과 보기');
        } else {
            resultsSection.slideDown();
            $(this).text('결과 숨기기');
        }
    });
    
    // 신규 투표 모달 열기
    $('#createVoteBtn').click(function() {
        $('#createVoteModal').css('display', 'flex');
    });
    
    // 모달 닫기
    $('.close-modal').click(function() {
        $('#createVoteModal').css('display', 'none');
    });
    
    // 옵션 추가 버튼
    $('#addOptionBtn').click(function() {
        const optionsContainer = $('#voteOptionsContainer');
        const newOption = `
            <div class="option-input-group">
                <input type="text" class="form-control vote-option-input" placeholder="투표 항목">
                <button type="button" class="btn btn-danger btn-remove-option">삭제</button>
            </div>
        `;
        optionsContainer.append(newOption);
    });
    
    // 옵션 삭제 버튼
    $(document).on('click', '.btn-remove-option', function() {
        $(this).closest('.option-input-group').remove();
    });
});
</script>
</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>

<div class="container-fluid container1">
    <div class="main">
        <div class="main-content">
            <ul class="team-menu">
                <li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
                <li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
                <li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
                <li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
            </ul>
            
            <div class="header-container">
                <h1>팀 투표</h1>
            </div>
            
            <!-- 투표 컨테이너 -->
            <div class="vote-container">
                <div class="d-flex justify-content-between align-items-center">
                    <h4>투표 목록</h4>
                    <button id="createVoteBtn" class="btn btn-success">+ 새 투표 만들기</button>
                </div>
                
                <!-- 투표 목록 -->
                <div id="voteList" class="vote-list">
                    <!-- 첫 번째 투표 (진행중) -->
                    <div class="vote-item" data-vote-id="vote1">
                        <div class="vote-header">
                            <div class="vote-title">다음 주 연습 일정 투표</div>
                            <div class="vote-status active">진행중</div>
                        </div>
                        <div class="vote-info">
                            참석 가능한 날짜에 투표해주세요.
                            <div>관련 경기: 2025년 4월 20일 참나무 vs 상대팀 미정</div>
                            <div>마감일: 2025년 4월 18일</div>
                        </div>
                        <div class="vote-options">
                            <div class="vote-option" data-option-id="opt1">
                                <div class="vote-option-name">4월 15일 (월) 저녁 7시</div>
                            </div>
                            <div class="vote-option" data-option-id="opt2">
                                <div class="vote-option-name">4월 17일 (수) 저녁 8시</div>
                            </div>
                            <div class="vote-option" data-option-id="opt3">
                                <div class="vote-option-name">4월 19일 (금) 저녁 7시</div>
                            </div>
                        </div>
                        <div class="vote-actions">
                            <button class="btn btn-primary btn-submit-vote">투표하기</button>
                            <button class="btn btn-outline-secondary btn-view-results">결과 보기</button>
                        </div>
                        <div class="vote-results" style="display: none;">
                            <h5>투표 결과</h5>
                            <div class="vote-results-content">
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>4월 15일 (월) 저녁 7시</span>
                                        <span>25%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 25%" 
                                             aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">3명 선택</div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>4월 17일 (수) 저녁 8시</span>
                                        <span>50%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 50%" 
                                             aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">6명 선택</div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>4월 19일 (금) 저녁 7시</span>
                                        <span>25%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 25%" 
                                             aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">3명 선택</div>
                                </div>
                            </div>
                            <div class="participant-list">
                                <h6>참여자 목록</h6>
                                <div class="participant-items">
                                    <div class="participant-item">김철수</div>
                                    <div class="participant-item">이영희</div>
                                    <div class="participant-item">박민수</div>
                                    <div class="participant-item">최지영</div>
                                    <div class="participant-item">정대한</div>
                                    <div class="participant-item">송미라</div>
                                    <div class="participant-item">윤성호</div>
                                    <div class="participant-item">고은지</div>
                                    <div class="participant-item">장민석</div>
                                    <div class="participant-item">임지원</div>
                                    <div class="participant-item">한승현</div>
                                    <div class="participant-item">강준호</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 두 번째 투표 (마감됨) -->
                    <div class="vote-item" data-vote-id="vote2">
                        <div class="vote-header">
                            <div class="vote-title">유니폼 색상 선택</div>
                            <div class="vote-status ended">마감됨</div>
                        </div>
                        <div class="vote-info">
                            새 시즌 유니폼 색상을 투표해주세요.
                            <div>마감일: 2025년 4월 10일</div>
                        </div>
                        <div class="vote-options">
                            <div class="vote-option" data-option-id="opt4">
                                <div class="vote-option-name">파란색</div>
                            </div>
                            <div class="vote-option selected" data-option-id="opt5">
                                <div class="vote-option-name">빨간색</div>
                            </div>
                            <div class="vote-option" data-option-id="opt6">
                                <div class="vote-option-name">검은색</div>
                            </div>
                        </div>
                        <div class="vote-actions">
                            <button class="btn btn-outline-secondary btn-view-results">결과 보기</button>
                        </div>
                        <div class="vote-results" style="display: none;">
                            <h5>투표 결과</h5>
                            <div class="vote-results-content">
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>파란색</span>
                                        <span>33%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 33%" 
                                             aria-valuenow="33" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">4명 선택</div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>빨간색</span>
                                        <span>42%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 42%" 
                                             aria-valuenow="42" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">5명 선택</div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>검은색</span>
                                        <span>25%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 25%" 
                                             aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">3명 선택</div>
                                </div>
                            </div>
                            <div class="participant-list">
                                <h6>참여자 목록</h6>
                                <div class="participant-items">
                                    <div class="participant-item">김철수</div>
                                    <div class="participant-item">이영희</div>
                                    <div class="participant-item">박민수</div>
                                    <div class="participant-item">최지영</div>
                                    <div class="participant-item">정대한</div>
                                    <div class="participant-item">송미라</div>
                                    <div class="participant-item">윤성호</div>
                                    <div class="participant-item">고은지</div>
                                    <div class="participant-item">장민석</div>
                                    <div class="participant-item">임지원</div>
                                    <div class="participant-item">한승현</div>
                                    <div class="participant-item">강준호</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 세 번째 투표 (진행중) -->
                    <div class="vote-item" data-vote-id="vote3">
                        <div class="vote-header">
                            <div class="vote-title">5월 친선경기 참가 여부</div>
                            <div class="vote-status active">진행중</div>
                        </div>
                        <div class="vote-info">
                            5월 1일(일) 강남구 대회에 참가 여부를 투표해주세요.
                            <div>마감일: 2025년 4월 25일</div>
                        </div>
                        <div class="vote-options">
                            <div class="vote-option" data-option-id="opt7">
                                <div class="vote-option-name">참가 찬성</div>
                            </div>
                            <div class="vote-option" data-option-id="opt8">
                                <div class="vote-option-name">참가 반대</div>
                            </div>
                            <div class="vote-option" data-option-id="opt9">
                                <div class="vote-option-name">기권/미정</div>
                            </div>
                        </div>
                        <div class="vote-actions">
                            <button class="btn btn-primary btn-submit-vote">투표하기</button>
                            <button class="btn btn-outline-secondary btn-view-results">결과 보기</button>
                        </div>
                        <div class="vote-results" style="display: none;">
                            <h5>투표 결과</h5>
                            <div class="vote-results-content">
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>참가 찬성</span>
                                        <span>60%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 60%" 
                                             aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">6명 선택</div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>참가 반대</span>
                                        <span>20%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 20%" 
                                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">2명 선택</div>
                                </div>
                                <div class="mb-3">
                                    <div class="d-flex justify-content-between mb-1">
                                        <span>기권/미정</span>
                                        <span>20%</span>
                                    </div>
                                    <div class="progress vote-progress">
                                        <div class="progress-bar bg-success" role="progressbar" style="width: 20%" 
                                             aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                                    </div>
                                    <div class="vote-count">2명 선택</div>
                                </div>
                            </div>
                            <div class="participant-list">
                                <h6>참여자 목록</h6>
                                <div class="participant-items">
                                    <div class="participant-item">김철수</div>
                                    <div class="participant-item">이영희</div>
                                    <div class="participant-item">박민수</div>
                                    <div class="participant-item">최지영</div>
                                    <div class="participant-item">정대한</div>
                                    <div class="participant-item">송미라</div>
                                    <div class="participant-item">윤성호</div>
                                    <div class="participant-item">고은지</div>
                                    <div class="participant-item">장민석</div>
                                    <div class="participant-item">임지원</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 투표 생성 모달 -->
<div id="createVoteModal" class="modal">
    <div class="modal-content" style="max-width: 600px;">
        <div class="modal-header">
            <h3 class="modal-title">새 투표 만들기</h3>
            <button class="close-modal">&times;</button>
        </div>
        <form id="createVoteForm">
            <div class="modal-body">
                <div class="modal-form-group">
                    <label for="voteTitle" class="form-label">투표 제목</label>
                    <input type="text" class="form-control" id="voteTitle" placeholder="투표 제목" required>
                </div>
                <div class="modal-form-group">
                    <label for="voteDescription" class="form-label">설명 (선택사항)</label>
                    <textarea class="form-control" id="voteDescription" rows="2" placeholder="투표에 대한 설명"></textarea>
                </div>
                <div class="modal-form-group">
                    <label for="relatedMatch" class="form-label">관련 경기 (선택사항)</label>
                    <select class="form-select" id="relatedMatch">
                        <option value="">관련 경기 선택</option>
                        <option value="match1">2025년 4월 20일 - 참나무 vs 상대팀 미정</option>
                        <option value="match2">2025년 5월 5일 - 참나무 vs 정글러</option>
                        <option value="match3">2025년 5월 15일 - 참나무 vs 레드팀</option>
                    </select>
                </div>
                <div class="modal-form-group">
                    <label for="voteEndDate" class="form-label">마감일</label>
                    <input type="date" class="form-control" id="voteEndDate" required>
                </div>
                <div class="modal-form-group">
                    <label class="form-label">투표 항목</label>
                    <div id="voteOptionsContainer">
                        <div class="option-input-group">
                            <input type="text" class="form-control vote-option-input" placeholder="투표 항목">
                            <button type="button" class="btn btn-danger btn-remove-option">삭제</button>
                        </div>
                        <div class="option-input-group">
                            <input type="text" class="form-control vote-option-input" placeholder="투표 항목">
                            <button type="button" class="btn btn-danger btn-remove-option">삭제</button>
                        </div>
                    </div>
                    <button type="button" id="addOptionBtn" class="btn btn-outline-secondary btn-add-option">+ 항목 추가</button>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary close-modal">취소</button>
                <button type="submit" class="btn btn-primary">투표 생성</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>