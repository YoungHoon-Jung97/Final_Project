<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	Integer user_code_id = (Integer) session.getAttribute("user_code_id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userInserForm.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/insertForm.css">
<style type="text/css">
	#ssn1 {
    	width: 200px;
    	flex: none;
	}
	
	.result {
    display: none;
    color: red;  /* 가시성을 위해 색상 지정 */
    font-size:small;
    margin-top: 5px;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 우편번호 API -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">

	$(document).ready(function(){
		
		var user_code_id = "<%= user_code_id != null ? user_code_id.toString() : "" %>";
		
		
		if (!user_code_id) {
			alert("로그인이 필요합니다.");
			//로그인 안되어 있으면 로그인 창으로 보냄
			location.href = "MainPage.action"; 
		}

		$('#user_code_id').val(user_code_id);
		
		$('#email').on('input',function(){
			
			$('#emailCheck').css('display','none');
			$('#submitBtn').prop('disabled',true);
			
		});
		
		$('#AccountNo').on('input',function(){
			
			$('#AccountNoCheck').css('display','none');
			$('#submitBtn').prop('disabled',true);
			
		});
		
		
		
		
	});
	
	function checkEmail(){
		var email = $('#email').val();

		$.ajax({
			
			url:'CheckEmailOperator.action',
			type:'get',
			data:{email:email},
			dataType:'text',
			success:function(result){
			
				if(result == "이미 사용중인 이메일 입니다."){
					
					$('#emailCheck').text(result);
					$('#emailCheck').css({'display': 'inline', 'color': 'red'})
					$('#submitBtn').prop('disabled',true);
				}
				else{
					
					$('#emailCheck').text(result);
					$('#emailCheck').css({'display': 'inline', 'color': 'green'})
					$('#submitBtn').prop('disabled', false);
				}
	
			},
			error:function(){
				$('#emailCheck').text("이메일을 입력하세요").css({'display': 'inline', 'color': 'red'});
	            $('#submitBtn').prop('disabled', true);  
				 
			}
			
		});
	}
	
	function checkAccountNo(){
		var accountNo = $('#accountNo').val();
		
		$.ajax({
			
			url:'CheckAccountNo.action',
			type:'get',
			data:{accountNo : accountNo},
			dataType:'text',
			success:function(result){
				if(result == "이미 사용중인 계좌번호 입니다."){
					
					$('#accountNoCheck').text(result);
					$('#accountNoCheck').css({'display': 'inline', 'color': 'red'})
					$('#submitBtn').prop('disabled',true);
				}
				else{
					
					$('#accountNoCheck').text(result);
					$('#accountNoCheck').css({'display': 'inline', 'color': 'green'})
					$('#submitBtn').prop('disabled', false);
				}
			},
			error:function(){
				$('#accountNoCheck').text("계좌 번호를 입력 하세요").css({'display':'inline','color':'red'});
				$('#submitBtn').prop('disabled',true);
			}
			
		});
		
	}
	
	
	
</script>


</head>
<body>

	<div class="content">
		<form id="inserForm" class="form form--join" method="post" action="OperatorInsert.action">
			<h2 class="form__title">구단 운영자 가입</h2>
		
			<!-- 기본 정보 섹션 -->
			<div class="form__section">
				<h3 class="form__section-title">구단 대표 정보 입력</h3>

				<!-- 사용자 이메일 입력(아이디)-->
				<div class="form__group">
					<div class="form__field">
						<label for="email" class="form__label required">이메일</label>
						<div class="form__input--wrapper">
							<input type="email" class="form__input" id="email" name="Operator_email"
								placeholder="예: example@google.com" maxlength="100" required />
							<button type="button" class="btn btn--check" onclick="checkEmail()">중복확인</button>
						</div>
					</div>
					<p id="emailCheck" class="result"></p>
				</div>


				<!-- 이름 입력-->
				<div class="form__group">
					<div class="form__field">
						<label for="name" class="form__label required">이름</label> 
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="name" placeholder="이름을 입력하세요."
							maxlength="10" name="operator_name" required />
						</div>
					</div>
					<p class="form__error name--error"></p>
				</div>

				<!-- 은행 입력 -->
				
				<div>
			        <label for="bank" class="form__label required">은행명</label>
			        <div class="form__selection">
				        <select id="bank" name="bank_id" class="required form__input"  required>
				            <option value="">은행을 선택하세요</option>
				            <c:forEach var="bank" items="${bankList}">
				                <option value="${bank.bank_id}">${bank.bank_name}</option>
				            </c:forEach>
				        </select>
			        </div>
			    </div>
				
				<div class="form__group">
					<div class="form__field">
						<label for="accountNo" class="form__label required" >계좌번호</label>
						<div class="form__input--wrapper">
							<input type="text" class="form__input" id="accountNo"
								placeholder="계좌번호" maxlength="20" name="operator_account_no" required />
							<button type="button" class="btn btn--check" onclick="checkAccountNo()">중복확인</button>
						</div>
					</div>
					<p id="accountNoCheck" class="result"></p>
				</div>
				
				<div class="form__group">
					<div class="form__field">
						<label for="tel" class="form__label">예금주</label> 
						<div class="form__input--wrapper">
							<input type="tel" class="form__input" id="tel" placeholder="전화번호"
							name="operator_account_holder" />
						</div>
					</div>
				</div>

				<!-- 전화번호 입력 -->
				<div class="form__group">
					<div class="form__field">
						<label for="tel" class="form__label">대표번호(전화번호)</label> 
						<div class="form__input--wrapper">
							<input type="tel" class="form__input" id="tel" placeholder="전화번호"
							name="operator_tel" />
						</div>
					</div>
				</div>
				<input type="hidden" id="user_code_id" name="user_code_id" value="">

			<!-- 버튼 그룹 -->
			<div class="form__actions">
				<button id="submitBtn" type="submit" class="btn btn--submit" >구단 운영자 가입</button>
				<button type="reset" class="btn btn--reset">취소</button>
				<button type="button" class="btn btn--back">뒤로가기</button>
			</div>

		</form>
		<!-- .form--join-->
	</div>
	<!-- .content -->
</body>
</html>