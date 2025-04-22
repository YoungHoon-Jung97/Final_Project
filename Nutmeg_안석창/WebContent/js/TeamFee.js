/*
	TeamFee.js
*/

// 모달 제어
function openModal(modalId)
{
	document.getElementById(modalId).style.display = 'block';
	$("header, .floatingButton-wrapper, .filter-panel").addClass("blur-background");
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
function initializeEventListeners()
{
	// 회비 모으기 버튼
	var collectFeeBtn = document.getElementById('collectFeeBtn');
	
	if (collectFeeBtn)
	{
		collectFeeBtn.addEventListener('click', function()
		{
			openModal('feeCollectionModal');
		});
	}
	
	var monthFeeBtn = document.getElementById('monthFeeBtn');
	
	if (monthFeeBtn)
	{
		monthFeeBtn.addEventListener('click', function()
		{
			openModal('monthFeeModal');
		});
	}
	
	// 모달 닫기 버튼
	document.querySelectorAll('.modal-close').forEach(button =>
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
	
	// 탭 전환 - 이벤트 위임 방식으로 변경
	var tabMenu = document.querySelector('.tab-menu');
	
	if (tabMenu)
	{
		tabMenu.addEventListener('click', function(event)
		{
			var tabItem = event.target.closest('.tab-item');
			
			if (tabItem)
			{
				var tabId = tabItem.getAttribute('data-tab');
				
				switchTab(tabId);
			}
		});
	}
	
	// 처음 로드 시 전체 탭 활성화
	switchTab('all');
}

// DOM이 완전히 로드된 후 초기화 함수 호출
document.addEventListener('DOMContentLoaded', initializeEventListeners);

// 모달이 닫힐 때마다 이벤트 리스너 재초기화
function closeModal(modalId)
{
	document.getElementById(modalId).style.display = 'none';
	$("header, .floatingButton-wrapper, .filter-panel").removeClass("blur-background");
	
	// 모달이 닫힌 후 이벤트 리스너 재초기화
	initializeEventListeners();
}