/*
	TeamFee.js
*/

// 모달 제어
function openModal(modalId)
{
	document.getElementById(modalId).style.display = 'block';
}

function closeModal(modalId)
{
	document.getElementById(modalId).style.display = 'none';
}

// 탭 전환
function switchTab(tabId)
{
	// 모든 탭 내용 숨김
	document.querySelectorAll('.tab-content').forEach(tab =>
	{
		tab.style.display = 'none';
    });
	
	// 선택한 탭 보이기
	document.getElementById(tabId + 'Tab').style.display = 'block';
	document.getElementById(tabId + 'Tab').style.textAlign = 'center';
	
	// 탭 메뉴 활성화 상태 변경
	document.querySelectorAll('.tab-item').forEach(item =>
	{
		item.classList.remove('active');
	});
	
	// 선택한 탭 메뉴 활성화
	document.querySelector(`.tab-item[data-tab="${tabId}"]`).classList.add('active');
}

// 이벤트 리스너 등록
document.addEventListener('DOMContentLoaded', function()
{
	// 회비 모으기 버튼
	document.getElementById('collectFeeBtn').addEventListener('click', function()
	{
		openModal('feeCollectionModal');
	});
	
	document.getElementById('monthFeeBtn').addEventListener('click', function()
	{
		openModal('monthFeeModal');
	});
	
	// 모달 닫기 버튼
	document.querySelectorAll('.close, .modal-close').forEach(button =>
	{
		button.addEventListener('click', function()
		{
			var modal = this.closest('.modal');
			
			closeModal(modal.id);
		});
	});
	
	// 모달 외부 클릭 시 닫기
	window.addEventListener('click', function(event)
	{
		document.querySelectorAll('.modal').forEach(modal =>
		{
			if (event.target == modal)
				closeModal(modal.id);
		});
	});
	
	// 탭 전환
	document.querySelectorAll('.tab-item').forEach(tab =>
	{
		tab.addEventListener('click', function()
		{
			var tabId = this.getAttribute('data-tab');
			
			switchTab(tabId);
		});
	});
	
	// 처음 로드 시 전체 탭 활성화 (이미 기본값으로 설정되어 있지만 명시적으로 추가)
	switchTab('all');
});