<%@ page pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
	
	String msg = (String) session.getAttribute("msg");
	String lang = (String) session.getAttribute("lang");
	
	if (msg == null)
		msg = request.getParameter("msg");

	if (lang == null)
		lang = request.getParameter("lang");
	
	session.removeAttribute("msg");
	session.removeAttribute("lang");
	
	System.out.println("-------------------------------------");
	System.out.println("DEBUG: msg = " + msg);
	System.out.println("DEBUG: lang = " + lang);
	
	String referer = request.getHeader("Referer");
	
	if (referer != null && !referer.contains("Login"))
		session.setAttribute("prevPage", referer);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
<link rel="stylesheet" type="text/css" href="<%=cp %>/css/util/Login.css?after">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%=cp %>/js/util.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
	
	var msg = "<%= msg %>";
	var lang = "<%= lang %>";
	
</script>
<script type="text/javascript" src="<%=cp %>/js/Login.js?after"></script>

</head>
<body>
<button id="backButton" class="back-btn uil uil-arrow-left" onclick="location.href='<%=cp %>/MainPage.action'"></button>

<div class="section">
	<div class="container">
		<div class="row full-height justify-content-center">
			<div class="col-12 text-center align-self-center py-5">
				<div class="section pb-5 pt-5 pt-sm-2 text-center">
					<h5 class="mb-0 pb-3">
						<span class="ko">한국어</span>
						<span>English</span>
					</h5>
					
					<input type="checkbox" class="lang-toggle" name="langToggle" id="langToggle">
					<label for="langToggle"></label>
					
					<div class="card-3d-wrap mx-auto">
						<div class="card-3d-wrapper">
							<!-- 앞면: 한국어 로그인 폼 -->
							<div class="card-front">
								<div class="center-wrap">
									<div class="section text-center">
										<h4 class="mb-4 pb-3">로그인</h4>
										
										<form action="LoginCheck.action" method="post" id="loginFormKo">
											<input type="hidden" name="lang" value="ko">
											
											<div class="form-group">
												<input type="email" class="form-style" name="logEmailKo" id="logEmailKo" placeholder="이메일">
												
												<i class="input-icon1 uil uil-at"></i>
												
												<div class="input-icon2 email-icon-btn clear-btn delete-email">
													<i class="uil uil-times-circle"></i>
												</div>
											</div>
											
											<div class="form-group mt-2">
												<input type="password" class="form-control login form-style" name="logPwKo" id="logPwKo" placeholder="비밀번호">
												
												<i class="input-icon1 uil uil-lock-alt"></i>
												
												<div class="input-icon3 pw-icon-btn clear-btn delete-pw">
													<i class="uil uil-times-circle"></i>
												</div>
												
												<div class="input-icon4 pw-icon-btn eyes">
													<i class="uil uil-eye"></i>
												</div>
											</div>
											
											<span class="input-wrap check save-email-ko">
												<input type="checkbox" class="save-email" name="saveEmailKo" id="saveEmailKo">
												
												<i class="input-icon5 uil uil-square"></i>
												
												<label for="saveEmailKo" class="label-hold">이메일 저장</label>
											</span>
											
											<div class="submit-button">
												<button type="button" class="btn mt-4 login-button" onclick="Submit()" disabled>
													<span class="submit-button-text">로그인</span>
												</button>
											</div>
											
											<p class="mb-0 mt-4 text-center">
												<a href="UserSignupForm.action" class="link">회원가입</a>
												<span class="boundary1">|</span>
												<a href="ForgotEmail.action" class="link">이메일 찾기</a>
												<span class="boundary2">|</span>
												<a href="ForgotPassword.action" class="link">비밀번호 찾기</a>
											</p>
										</form>
									</div> <!-- section text-center end -->
								</div> <!-- center-wrap end -->
							</div> <!-- card-front end -->
							
							<!-- 뒷면: 영어 로그인 폼 -->
							<div class="card-back">
								<div class="center-wrap">
									<div class="section text-center">
										<h4 class="mb-4 pb-3">Log In</h4>
										
										<form action="LoginCheck.action" method="post" id="loginFormEn">
											<input type="hidden" name="lang" value="en">
											
											<div class="form-group">
												<input type="email" class="form-style" name="logEmailEn" id="logEmailEn" placeholder="Email">
												
												<i class="input-icon1 uil uil-at"></i>
												
												<div class="input-icon2 email-icon-btn clear-btn delete-email">
													<i class="uil uil-times-circle"></i>
												</div>
											</div>
											
											<div class="form-group mt-2">
												<input type="password" class="form-style" name="logPwEn" id="logPwEn" placeholder="Password">
												
												<i class="input-icon1 uil uil-lock-alt"></i>
												
												<div class="input-icon3 pw-icon-btn clear-btn delete-pw">
													<i class="uil uil-times-circle"></i>
												</div>
												
												<div class="input-icon4 pw-icon-btn eyes">
													<i class="uil uil-eye"></i>
												</div>
											</div>
											
											<span class="input-wrap check save-email-en">
												<input type="checkbox" class="save-email" name="saveEmailEn" id="saveEmailEn">
												
												<i class="input-icon5 uil uil-square"></i>
												
												<label for="saveEmailEn" class="label-hold">Save Email</label>
											</span>
											
											<div class="submit-button">
												<button type="button" class="btn mt-4 login-button" onclick="Submit()" disabled>
													<span class="submit-button-text">Log In</span>
												</button>
											</div>
											
											<p class="mb-0 mt-4 text-center margin-p">
												<a href="UserSignupForm.action" class="link">Sign up</a>
												<span class="boundary1">|</span>
												<a href="ForgotEmail.action" class="link">Find Email</a>
												<span class="boundary3">|</span>
												<a href="ForgotPassword.action" class="link">Find Password</a>
											</p>
										</form>
									</div> <!-- section text-center end -->
								</div> <!-- center-wrap end -->
							</div> <!-- card-back end -->
						</div> <!-- card-3d-wrapper end -->
					</div> <!-- card-3d-wrap mx-auto end -->
				</div> <!-- section pb-5 pt-5 pt-sm-2 text-center end -->
			</div> <!-- col-12 text-center align-self-center py-5 end -->
		</div> <!-- row full-height justify-content-center end -->
	</div> <!-- container end -->
</div> <!-- section end -->

<button id="adminBtn" onclick="location.href='AdminLogin.action'">🦄</button>
</body>
</html>