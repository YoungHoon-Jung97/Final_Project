<%@ page contentType="text/html; charset=UTF-8"%>
<%
   request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>용병 지원</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Template.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/Mercenary.css">
</head>
<body>
   <div class="container">
      <!-- 네비게이션 타이틀 -->
      <div class="navbar-title">넛맥</div>

      <!-- 브레드크럼 -->
      <div class="breadcrumb">
         <a href="#">홈</a> > <a href="#">매칭</a> > 용병 지원
      </div>

      <!-- 용병 지원 컨테이너 -->
      <div class="table-container">
         <div class="table-row header">
            <div class="table-cell">용병 지원</div>
         </div>

         <div class="table-row">
            <div class="table-cell">
               <form class="apply-form" method="POST" action="applyMercenary.do">
                  <!-- 이름 입력 -->
                  <div class="form-group">
                     <label for="name">이름</label> <input type="text" id="name"
                        name="name" required>
                  </div>

                  <!-- 소속 동호회 입력 -->
                  <div class="form-group">
                     <label for="club">소속 동호회</label>
                     <div class="search-bar">
                        <input type="text" id="club" name="club" placeholder="동호회 선택"
                           readonly required>
                        <button type="button" id="clubSearchBtn">검색</button>
                     </div>
                     <div class="filter-container">
                        <input type="radio" id="club_none" name="clubOption"
                           value="none"> <label for="club_none">없음</label>
                     </div>
                  </div>

                  <!-- 포지션 선택 -->
                  <div class="form-group">
                     <label for="position">포지션</label>
                     <div class="filter-container">
                        <select id="position" name="position" required>
                           <option value="">선택하세요</option>
                           <option value="FW">FW</option>
                           <option value="MF">MF</option>
                           <option value="DF">DF</option>
                           <option value="GK">GK</option>
                        </select>
                     </div>
                  </div>

                  <!-- 선호시간 선택 -->
                  <div class="form-group">
                     <label for="time">선호시간</label>
                     <div class="filter-container">
                        <select id="time" name="time" required>
                           <option value="">선택하세요</option>
                           <option value="1시">1시</option>
                           <option value="2시">2시</option>
                           <option value="3시">3시</option>
                           <option value="4시">4시</option>
                           <option value="5시">5시</option>
                           <option value="6시">6시</option>
                           <option value="7시">7시</option>
                           <option value="8시">8시</option>
                           <option value="9시">9시</option>
                           <option value="10시">10시</option>
                           <option value="11시">11시</option>
                           <option value="12시">12시</option>
                           <option value="13시">13시</option>
                           <option value="14시">14시</option>
                           <option value="15시">15시</option>
                           <option value="16시">16시</option>
                           <option value="17시">17시</option>
                           <option value="18시">18시</option>
                           <option value="19시">19시</option>
                           <option value="20시">20시</option>
                           <option value="21시">21시</option>
                           <option value="22시">22시</option>
                           <option value="23시">23시</option>
                           <option value="24시">24시</option>
                        </select>
                     </div>
                  </div>

                  <!-- 지원하기 버튼 -->
                  <div class="search-bar">
                     <button type="submit">지원하기</button>
                  </div>
               </form>
            </div>
         </div>
      </div>

      <!-- 스크롤 업 버튼 -->
      <div class="scroll-up">↑</div>
   </div>

   <!-- 동호회 검색 모달 -->
   <div id="clubModal" class="modal">
      <div class="modal-content">
         <span class="close-modal" id="closeModal">&times;</span>
         <h2>동호회 검색</h2>
         <input type="text" id="clubSearchInput" placeholder="동호회 검색어 입력">
         <div class="club-list" id="clubList">
            <!-- 예시 동호회 목록 -->
            <div class="club-item">동호회 A</div>
            <div class="club-item">동호회 B</div>
            <div class="club-item">동호회 C</div>
            <div class="club-item">동호회 D</div>
         </div>
      </div>
   </div>

   <!-- JavaScript for 모달 기능 -->
   <script>
      // 모달 관련 변수 설정
      var clubModal = document.getElementById('clubModal');
      var clubSearchBtn = document.getElementById('clubSearchBtn');
      var closeModal = document.getElementById('closeModal');
      var clubList = document.getElementById('clubList');
      var clubInput = document.getElementById('club');
      var clubNoneRadio = document.getElementById('club_none');

      // "검색" 버튼 클릭 시 모달 열기
      clubSearchBtn.addEventListener('click', function()
      {
         clubModal.style.display = 'block';
      });

      // 모달 닫기 버튼 클릭 시
      closeModal.addEventListener('click', function()
      {
         clubModal.style.display = 'none';
      });

      // 모달 바깥 클릭 시 모달 닫기
      window.addEventListener('click', function(e)
      {
         if (e.target == clubModal)
         {
            clubModal.style.display = 'none';
         }
      });

      // 동호회 목록에서 항목 클릭 시 해당 동호회 이름을 입력창에 설정하고 모달 닫기
      var clubItems = document.getElementsByClassName('club-item');
      for (var i = 0; i < clubItems.length; i++)
      {
         clubItems[i].addEventListener('click', function()
         {
            clubInput.value = this.textContent;
            clubModal.style.display = 'none';
            // "없음" 라디오버튼 해제
            clubNoneRadio.checked = false;
         });
      }

      // "없음" 라디오 버튼 선택 시 입력창 비우기
      clubNoneRadio.addEventListener('change', function()
      {
         if (this.checked)
         {
            clubInput.value = '';
         }
      });

      // 스크롤 업 버튼 기능
      document.querySelector('.scroll-up').addEventListener('click',
            function()
            {
               window.scrollTo(
               {
                  top : 0,
                  behavior : 'smooth'
               });
            });
   </script>
</body>
</html>