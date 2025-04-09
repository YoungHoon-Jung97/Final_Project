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
<title>팀 정보</title>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Team.css">
<script type="text/javascript">
	// 전체 선택 체크박스 기능
	document.getElementById('select-all').addEventListener('change', function() {
	    const isChecked = this.checked;
	    document.querySelectorAll('.select-item').forEach(checkbox => {
	        checkbox.checked = isChecked;
	    });
	});
	
	// 모달 관련 기능
	const approveModal = document.getElementById('approveModal');
	const rejectModal = document.getElementById('rejectModal');
	
	// 승인 모달 열기
	document.getElementById('approve-selected').addEventListener('click', function() {
	    const selectedCount = document.querySelectorAll('.select-item:checked').length;
	    if (selectedCount === 0) {
	        alert('승인할 항목을 선택해주세요.');
	        return;
	    }
	    approveModal.style.display = 'block';
	});
	
	// 거절 모달 열기
	document.getElementById('reject-selected').addEventListener('click', function() {
	    const selectedCount = document.querySelectorAll('.select-item:checked').length;
	    if (selectedCount === 0) {
	        alert('거절할 항목을 선택해주세요.');
	        return;
	    }
	    rejectModal.style.display = 'block';
	});
	
	// 개별 승인 버튼
	document.querySelectorAll('.approve-btn').forEach(button => {
	    button.addEventListener('click', function() {
	        // 해당 항목만 체크하고 모달 열기
	        document.querySelectorAll('.select-item').forEach(checkbox => {
	            checkbox.checked = false;
	        });
	        const row = this.closest('tr');
	        row.querySelector('.select-item').checked = true;
	        approveModal.style.display = 'block';
	    });
	});
	
	// 개별 거절 버튼
	document.querySelectorAll('.reject-btn').forEach(button => {
	    button.addEventListener('click', function() {
	        // 해당 항목만 체크하고 모달 열기
	        document.querySelectorAll('.select-item').forEach(checkbox => {
	            checkbox.checked = false;
	        });
	        const row = this.closest('tr');
	        row.querySelector('.select-item').checked = true;
	        rejectModal.style.display = 'block';
	    });
	});
	
	// 모달 닫기
	document.querySelectorAll('.close, .cancel-modal').forEach(element => {
	    element.addEventListener('click', function() {
	        approveModal.style.display = 'none';
	        rejectModal.style.display = 'none';
	    });
	});
	
	// 모달 외부 클릭 시 닫기
	window.addEventListener('click', function(event) {
	    if (event.target === approveModal) {
	        approveModal.style.display = 'none';
	    }
	    if (event.target === rejectModal) {
	        rejectModal.style.display = 'none';
	    }
	});
	
	// 승인 처리
	document.getElementById('confirm-approve').addEventListener('click', function() {
	    const selectedItems = document.querySelectorAll('.select-item:checked');
	    selectedItems.forEach(checkbox => {
	        const row = checkbox.closest('tr');
	        const statusCell = row.cells[6];
	        const actionCell = row.cells[7];
	        
	        statusCell.textContent = '승인됨';
	        actionCell.innerHTML = '<button class="btn-secondary btn-small" disabled>승인됨</button>';
	    });
	    
	    approveModal.style.display = 'none';
	    alert('선택한 항목이 승인되었습니다.');
	});
	
	// 거절 처리
	document.getElementById('confirm-reject').addEventListener('click', function() {
	    const selectedItems = document.querySelectorAll('.select-item:checked');
	    const rejectReason = document.getElementById('reject-reason').value;
	    
	    selectedItems.forEach(checkbox => {
	        const row = checkbox.closest('tr');
	        const statusCell = row.cells[6];
	        const actionCell = row.cells[7];
	        
	        statusCell.textContent = '거절됨';
	        actionCell.innerHTML = '<button class="btn-secondary btn-small" disabled>거절됨</button>';
	        
	        // 거절 사유가 있으면 처리할 수 있음 (여기서는 생략)
	    });
	    
	    rejectModal.style.display = 'none';
	    document.getElementById('reject-reason').value = '';
	    alert('선택한 항목이 거절되었습니다.');
	});
	
	// CSV 내보내기
	document.getElementById('export-csv').addEventListener('click', function() {
	    // 실제 구현에서는 서버에 요청하거나 클라이언트에서 데이터를 변환하여 다운로드
	    alert('CSV 파일이 다운로드됩니다.');
	});

</script>
<style type="text/css">
/*팀 메뉴 넘어갔을 때 표시*/
.teampage-link:first-child a {
	color: #ff4500;
	border-bottom: 2px solid #ff4500;
}

/* =============================================*/

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }
        
        body {
            background-color: #f5f5f5;
            padding: 20px;
        }
             
        
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 24px;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #f8f8f8;
            font-weight: bold;
        }
        
        tr:hover {
            background-color: #f1f1f1;
        }
        
        .checkbox-cell {
            text-align: center;
            width: 50px;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }
        
        .btn-primary {
            background-color: #4CAF50;
            color: white;
        }
        
        .btn-danger {
            background-color: #f44336;
            color: white;
        }
        
        .btn-secondary {
            background-color: #e7e7e7;
            color: #333;
        }
        
        .pagination {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        
        .pagination a {
            color: black;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color .3s;
            border: 1px solid #ddd;
            margin: 0 4px;
        }
        
        .pagination a.active {
            background-color: #4CAF50;
            color: white;
            border: 1px solid #4CAF50;
        }
        
        .pagination a:hover:not(.active) {
            background-color: #ddd;
        }
        
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4);
        }
        
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 400px;
            border-radius: 5px;
        }
        
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        
        .close:hover {
            color: black;
        }
        
        .modal-buttons {
            display: flex;
            justify-content: flex-end;
            margin-top: 20px;
        }
        
        .modal-buttons button {
            margin-left: 10px;
        }
 

</style>

</head>
<body>
<c:import url="/WEB-INF/view/Template.jsp"></c:import>
	<div class="container-fluid container">
		<div class="main">
			<div class="main-content">
				<ul class="tean-menu">
					<li class="teampage-link"><a href="MyTeam.action">팀 정보</a></li>
					<li class="teampage-link"><a href="MyTeamSchedule.action">팀 매치</a></li>
					<li class="teampage-link"><a href="MyTeamFee.action">팀 가계부</a></li>
					<li class="teampage-link"><a href="MyTeamBoard.action">팀 게시판</a></li>
				</ul>
				<!-- .tean-menu -->

				<div class="">
			        <h1>동호회 신청 수락 관리</h1>
			        <table>
			            <thead>
			                <tr>
			                    <th class="checkbox-cell"><input type="checkbox" id="select-all"></th>
			                    <th>이름</th>
			                    <th>신청 동호회</th>
			                    <th>소개</th>
			                    <th>가입 이유</th>
			                    <th>신청일</th>
			                    <th>작업</th>
			                </tr>
			            </thead>
			            <tbody>
			                <tr>
			                    <td class="checkbox-cell"><input type="checkbox" class="select-item"></td>
			                    <td>김철수</td>
			                    <td>등산 동호회</td>
			                    <td>30대 직장인입니다</td>
			                    <td>취미로 등산을 즐깁니다</td>
			                    <td>2025-04-05</td>
			                    <td>
			                        <button class="btn-primary btn-small approve-btn" data-id="1">승인</button>
			                        <button class="btn-danger btn-small reject-btn" data-id="1">거절</button>
			                    </td>
			                </tr>
			                <tr>
			                    <td class="checkbox-cell"><input type="checkbox" class="select-item"></td>
			                    <td>이영희</td>
			                    <td>독서 동호회</td>
			                    <td>책 읽는 것을 좋아합니다</td>
			                    <td>다양한 책을 함께 읽고 싶어요</td>
			                    <td>2025-04-06</td>
			                    <td>
			                        <button class="btn-primary btn-small approve-btn" data-id="2">승인</button>
			                        <button class="btn-danger btn-small reject-btn" data-id="2">거절</button>
			                    </td>
			                </tr>
			                <tr>
			                    <td class="checkbox-cell"><input type="checkbox" class="select-item"></td>
			                    <td>박지민</td>
			                    <td>사진 동호회</td>
			                    <td>사진 찍는 것이 취미입니다</td>
			                    <td>함께 사진 여행 가고 싶어요</td>
			                    <td>2025-04-07</td>
			                    <td>
			                        <button class="btn-primary btn-small approve-btn" data-id="3">승인</button>
			                        <button class="btn-danger btn-small reject-btn" data-id="3">거절</button>
			                    </td>
			                </tr>
			                <tr>
			                    <td class="checkbox-cell"><input type="checkbox" class="select-item"></td>
			                    <td>정민수</td>
			                    <td>축구 동호회</td>
			                    <td>축구를 좋아하는 학생입니다</td>
			                    <td>주말에 함께 축구하고 싶습니다</td>
			                    <td>2025-04-08</td>
			                    <td>
			                        <button class="btn-secondary btn-small" disabled>승인됨</button>
			                    </td>
			                </tr>
			                <tr>
			                    <td class="checkbox-cell"><input type="checkbox" class="select-item"></td>
			                    <td>한지연</td>
			                    <td>요리 동호회</td>
			                    <td>요리에 관심이 많습니다</td>
			                    <td>다양한 요리 배우고 싶어요</td>
			                    <td>2025-04-08</td>
			                    <td>
			                        <button class="btn-secondary btn-small" disabled>거절됨</button>
			                    </td>
			                </tr>
			            </tbody>
			        </table>
			        
			        <div class="action-buttons">
			            <div>
			                <button class="btn btn-primary" id="approve-selected">선택 승인</button>
			                <button class="btn btn-danger" id="reject-selected">선택 거절</button>
			            </div>
			        </div>
			        
			        <div class="pagination">
			            <a href="#">&laquo;</a>
			            <a href="#" class="active">1</a>
			            <a href="#">2</a>
			            <a href="#">3</a>
			            <a href="#">4</a>
			            <a href="#">5</a>
			            <a href="#">&raquo;</a>
			        </div>
			    </div>
				<!-- container -->
			</div>
			<!-- .main-content  -->
		</div>
		<!-- .main  -->
	</div>
	
	<div id="approveModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>신청 승인</h3>
            <p>선택한 신청을 승인하시겠습니까?</p>
            <div class="modal-buttons">
                <button class="btn btn-secondary cancel-modal">취소</button>
                <button class="btn btn-primary" id="confirm-approve">승인</button>
            </div>
        </div>
    </div>
    
    <div id="rejectModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>신청 거절</h3>
            <p>선택한 신청을 거절하시겠습니까?</p>
            <div>
                <label for="reject-reason">거절 사유 (선택사항):</label>
                <textarea id="reject-reason" rows="3" style="width: 100%; margin-top: 10px; padding: 8px;"></textarea>
            </div>
            <div class="modal-buttons">
                <button class="btn btn-secondary cancel-modal">취소</button>
                <button class="btn btn-danger" id="confirm-reject">거절</button>
            </div>
        </div>
    </div>


</body>
</html>
