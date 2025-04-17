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
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/TeamTemplate.css?after">

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
    // 투표 목록 로드
    loadVotes();
    
    // 신규 투표 생성 모달 열기
    $('#createVoteBtn').on('click', function() {
        $('#createVoteModal').css('display', 'flex');
    });
    
    // 옵션 추가 버튼
    $('#addOptionBtn').on('click', function() {
        const optionsContainer = $('#voteOptionsContainer');
        const newOption = `
            <div class="option-input-group">
                <input type="text" class="form-control vote-option-input" placeholder="투표 항목">
                <button type="button" class="btn btn-danger btn-remove-option">삭제</button>
            </div>
        `;
        optionsContainer.append(newOption);
    });
    
    // 옵션 삭제 버튼 (동적 이벤트 바인딩)
    $('#voteOptionsContainer').on('click', '.btn-remove-option', function() {
        $(this).closest('.option-input-group').remove();
    });
    
    // 투표 생성 폼 제출
    $('#createVoteForm').on('submit', function(e) {
        e.preventDefault();
        
        const title = $('#voteTitle').val();
        const description = $('#voteDescription').val();
        const matchId = $('#relatedMatch').val();
        const endDate = $('#voteEndDate').val();
        
        // 옵션들 수집
        const options = [];
        $('.vote-option-input').each(function() {
            const value = $(this).val().trim();
            if (value) {
                options.push(value);
            }
        });
        
        if (!title || options.length < 2) {
            alert('제목과 최소 2개 이상의 옵션을 입력해주세요.');
            return;
        }
        
        // AJAX로 폼 제출
        $.ajax({
            url: '<%=cp%>/CreateVote.action',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                title: title,
                description: description,
                matchId: matchId,
                endDate: endDate,
                options: options
            }),
            success: function(response) {
                alert('투표가 생성되었습니다.');
                closeCreateModal();
                loadVotes(); // 투표 목록 다시 로드
            },
            error: function(xhr, status, error) {
                alert('투표 생성에 실패했습니다: ' + error);
            }
        });
    });
    
    // 투표 항목 선택 이벤트
    $(document).on('click', '.vote-option', function() {
        const voteId = $(this).closest('.vote-item').data('vote-id');
        const optionId = $(this).data('option-id');
        
        // 이미 선택된 옵션 해제
        $(this).siblings('.vote-option').removeClass('selected');
        
        // 현재 옵션 선택
        $(this).addClass('selected');
    });
    
    // 투표 제출 버튼 클릭
    $(document).on('click', '.btn-submit-vote', function() {
        const voteItem = $(this).closest('.vote-item');
        const voteId = voteItem.data('vote-id');
        const selectedOption = voteItem.find('.vote-option.selected');
        
        if (selectedOption.length === 0) {
            alert('투표 항목을 선택해주세요.');
            return;
        }
        
        const optionId = selectedOption.data('option-id');
        
        // AJAX로 투표 제출
        $.ajax({
            url: '<%=cp%>/SubmitVote.action',
            type: 'POST',
            data: {
                voteId: voteId,
                optionId: optionId
            },
            success: function(response) {
                alert('투표가 완료되었습니다.');
                loadVotes(); // 투표 목록 다시 로드
            },
            error: function(xhr, status, error) {
                alert('투표에 실패했습니다: ' + error);
            }
        });
    });
    
    // 결과 보기 버튼 클릭
    $(document).on('click', '.btn-view-results', function() {
        const voteId = $(this).closest('.vote-item').data('vote-id');
        
        // 결과 섹션 토글
        const resultsSection = $(this).closest('.vote-item').find('.vote-results');
        
        if (resultsSection.is(':visible')) {
            resultsSection.slideUp();
            $(this).text('결과 보기');
        } else {
            // AJAX로 최신 결과 로드
            $.ajax({
                url: '<%=cp%>/GetVoteResults.action',
                type: 'GET',
                data: { voteId: voteId },
                success: function(response) {
                    // 결과 데이터로 UI 업데이트
                    updateVoteResults(voteId, response);
                    resultsSection.slideDown();
                    $(this).text('결과 숨기기');
                }.bind(this),
                error: function(xhr, status, error) {
                    alert('결과를 불러오는데 실패했습니다: ' + error);
                }
            });
        }
    });
    
    // 관련 경기 목록 로드
    loadMatchOptions();
});

// 투표 목록 로드 함수
function loadVotes() {
    $.ajax({
        url: '<%=cp%>/GetVotes.action',
        type: 'GET',
        dataType: 'json',
        success: function(votes) {
            renderVotes(votes);
        },
        error: function(xhr, status, error) {
            console.error('투표 목록을 불러오는데 실패했습니다:', error);
            $('#voteList').html('<div class="alert alert-danger">투표 목록을 불러오는데 실패했습니다.</div>');
        }
    });
}

// 투표 목록 렌더링 함수
function renderVotes(votes) {
    const voteListContainer = $('#voteList');
    voteListContainer.empty();
    
    if (!votes || votes.length === 0) {
        voteListContainer.html('<div class="text-center p-5">등록된 투표가 없습니다.</div>');
        return;
    }
    
    votes.forEach(vote => {
        const now = new Date();
        const endDate = new Date(vote.endDate);
        const isActive = endDate > now;
        
        let voteHtml = `
            <div class="vote-item" data-vote-id="${vote.id}">
                <div class="vote-header">
                    <div class="vote-title">${vote.title}</div>
                    <div class="vote-status ${isActive ? 'active' : 'ended'}">${isActive ? '진행중' : '마감됨'}</div>
                </div>
                <div class="vote-info">
                    ${vote.description || ''}
                    ${vote.relatedMatch ? `<div>관련 경기: ${vote.relatedMatch}</div>` : ''}
                    <div>마감일: ${formatDate(vote.endDate)}</div>
                </div>
                <div class="vote-options">
        `;
        
        vote.options.forEach(option => {
            voteHtml += `
                <div class="vote-option" data-option-id="${option.id}">
                    <div class="vote-option-name">${option.name}</div>
                </div>
            `;
        });
        
        voteHtml += `
                </div>
                <div class="vote-actions">
                    ${isActive ? '<button class="btn btn-primary btn-submit-vote">투표하기</button>' : ''}
                    <button class="btn btn-outline-secondary btn-view-results">결과 보기</button>
                </div>
                <div class="vote-results" style="display: none;">
                    <h5>투표 결과</h5>
                    <div class="vote-results-content"></div>
                    <div class="participant-list">
                        <h6>참여자 목록</h6>
                        <div class="participant-items"></div>
                    </div>
                </div>
            </div>
        `;
        
        voteListContainer.append(voteHtml);
    });
}

// 투표 결과 업데이트 함수
function updateVoteResults(voteId, results) {
    const voteItem = $(`.vote-item[data-vote-id="${voteId}"]`);
    const resultsContent = voteItem.find('.vote-results-content');
    const participantItems = voteItem.find('.participant-items');
    
    resultsContent.empty();
    participantItems.empty();
    
    if (!results || !results.options) {
        resultsContent.html('<div class="alert alert-info">아직 투표 결과가 없습니다.</div>');
        return;
    }
    
    const totalVotes = results.totalVotes || 0;
    
    // 옵션별 결과 표시
    results.options.forEach(option => {
        const percent = totalVotes > 0 ? Math.round((option.votes / totalVotes) * 100) : 0;
        const resultHtml = `
            <div class="mb-3">
                <div class="d-flex justify-content-between mb-1">
                    <span>${option.name}</span>
                    <span>${percent}%</span>
                </div>
                <div class="progress vote-progress">
                    <div class="progress-bar bg-success" role="progressbar" style="width: ${percent}%" 
                         aria-valuenow="${percent}" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <div class="vote-count">${option.votes}명 선택</div>
            </div>
        `;
        resultsContent.append(resultHtml);
    });
    
    // 참여자 목록 표시
    if (results.participants && results.participants.length > 0) {
        results.participants.forEach(participant => {
            participantItems.append(`<div class="participant-item">${participant.name}</div>`);
        });
    } else {
        participantItems.html('<div class="text-muted">아직 참여자가 없습니다.</div>');
    }
}

// 관련 경기 옵션 로드
function loadMatchOptions() {
    $.ajax({
        url: '<%=cp%>/MatchList.action',
        type: 'GET',
        dataType: 'json',
        success: function(matches) {
            const selectEl = $('#relatedMatch');
            selectEl.empty();
            selectEl.append('<option value="">관련 경기 선택 (선택사항)</option>');
            
            if (matches && matches.length > 0) {
                matches.forEach(match => {
                    const matchDate = new Date(match.match_date);
                    const formattedDate = formatDate(matchDate);
                    const optionText = `${formattedDate} - ${match.home_team_name} vs ${match.away_team_name || '상대팀 미정'}`;
                    selectEl.append(`<option value="${match.field_res_id}">${optionText}</option>`);
                });
            }
        },
        error: function(xhr, status, error) {
            console.error('경기 목록을 불러오는데 실패했습니다:', error);
        }
    });
}

// 날짜 포맷팅 함수
function formatDate(dateStr) {
    const date = new Date(dateStr);
    return `${date.getFullYear()}년 ${date.getMonth() + 1}월 ${date.getDate()}일`;
}

// 모달 닫기 함수
function closeCreateModal() {
    $('#createVoteModal').css('display', 'none');
    $('#createVoteForm')[0].reset();
    $('#voteOptionsContainer').html(`
        <div class="option-input-group">
            <input type="text" class="form-control vote-option-input" placeholder="투표 항목">
            <button type="button" class="btn btn-danger btn-remove-option">삭제</button>
        </div>
        <div class="option-input-group">
            <input type="text" class="form-control vote-option-input" placeholder="투표 항목">
            <button type="button" class="btn btn-danger btn-remove-option">삭제</button>
        </div>
    `);
}
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
                    <!-- 투표 항목들이 동적으로 추가됩니다 -->
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
            <button class="close-modal" onclick="closeCreateModal()">&times;</button>
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
                        <!-- 경기 목록이 동적으로 로드됩니다 -->
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
                <button type="button" class="btn btn-secondary" onclick="closeCreateModal()">취소</button>
                <button type="submit" class="btn btn-primary">투표 생성</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>