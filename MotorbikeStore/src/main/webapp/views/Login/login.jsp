<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Login With Us</title>

	<link
		href="<c:url value='template/web/loginPage/fonts/material-icon/css/material-design-iconic-font.min.css' />"
		rel="stylesheet" type="text/css" media="all" />
	<!-- Font Icon -->
	<link href="<c:url value='template/web/loginPage/css/style.css' />"
		rel="stylesheet" type="text/css" media="all" />
	<link
		href="<c:url value='template/web/loginPage/images/favicon.png' />"
		rel="shortcut icon" type="image/png" />



</head>
<body>
	<input type="hidden" id="status"
		value="<%=request.getAttribute("status")%>">

	<div class="main">

		<section class="sign-in">
			<div class="container">
				<div class="signin-content">
					<div class="signin-image">
						<figure>
							<img src="template/web/loginPage/images/signin-image.png" alt="sign up image">
						</figure>
						<a href="regist" class="signup-image-link">Create an
							account</a>
					</div>

					<div class="signin-form">
						<h2 class="form-title">WELCOME TO SIGN UP</h2>
						<form method="" action="" class="register-form" id="login-form">
							<div class="form-group">
								<label for="email"><i
									class="zmdi zmdi-account material-icons-name"></i></label> <input
									type="text" name="email" id="email"
									placeholder="Your Email"/> <!-- tb khung nhap trong -->
							</div>
							<div class="form-group">
								<label for="password"><i class="zmdi zmdi-lock"></i></label> <input
									type="password" name="password" id="password"
									placeholder="Password"  />
							</div>
							<div class="form-group">
								<input type="checkbox" name="remember-me" id="remember-me"
									class="agree-term" /> <label for="remember-me"
									class="label-agree-term"><span><span></span></span>Remember
									me</label>
<!-- 							</div>
							<div class="form-group">
								 <button for="remember-me" class="label-agree-term">Forgot password</button>
							</div>	 -->
							
							</div>
							<div class="form-group form-button">
								<input type="submit" name="signin" id="signin"
									class="form-submit" value="Login"  />
									<a class="navbar-brand" href="web-main-page"></a>
							</div>
						</form>
						<div class="social-login">
							<span class="social-label">Or</span>
							<ul class="socials">
								<li><a href="#"><i
										class="display-flex-center zmdi zmdi-facebook"></i></a></li>
								<li><a href="#"><i
										class="display-flex-center zmdi zmdi-twitter"></i></a></li>
								<li><a href="#"><i
										class="display-flex-center zmdi zmdi-google"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>

	</div>





	<!-- JS -->
	<script src="template/web/loginPage/vendor/jquery/jquery.min.js"></script>
	<script src="template/web/loginPage/js/main.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

	<link rel="stysheet" href="alert/dist/sweetalert.css">
	<script type="text/javascript">
		var status = document.getElementById("status").value;
		if (status == "failed") {
			swal("Oh No", "Please check your Email and Password again!", "error");
		}
	</script>
</body>

</html>