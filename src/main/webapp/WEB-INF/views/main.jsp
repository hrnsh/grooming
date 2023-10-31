<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
nav {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.logo {
	margin-left: 50px;
}

.loginBox {
	width: 300px;
	height: 150px;
	background-color: rgb(221, 215, 214);
	margin-right: 50px;
	border-radius: 50px;
	position: relative;
}

.logButton{
	border: none;
	height: 50px;
	width: 150px;
	background-color: rgb(221, 215, 214);
	padding: 14px 32px;
	border-radius: 500px;
	color: black;
	font-weight: 700;
	font-size: inherit;
	position: absolute;
	top: 20px;
	left: 70px;
}

main {
	height: 400px;
	background-size: 175%;
	background-position: 46% 4%;
	display: flex;
	justify-content: center;
	align-items: center;
	position: relative;
}

.buttonAll {
	width: 60%;
	display: flex;
	justify-content: space-around;
	position: absolute;
	top: 100px;
}

.button {
	height: 50px;
	width: 150px;
	background-color: rgb(221, 215, 214);
	padding: 14px 32px;
	border-radius: 500px;
	border: none;
	color: black;
	font-weight: 700;
	font-size: inherit;
}

.button:hover{
	transform: scale(1.05);
}

.rankBox{
	width: 500px;
	height: 150px;
	background-color: rgb(221, 215, 214);
	position: absolute;
	top: 200px;
	border-radius: 30px;
}

footer {
	height: 400px;
	align-items: center;
	background-color: rgb(221, 215, 214);
	background-position: 50%;
}

.image {
	width: 70%;
	height: 400px;
	display: flex;
	justify-content: center;
	position: relative;
	left: 200px;
}

.image::before {
	content: "";
	background: url("resources/img/dogs.jpg") center no-repeat;
	background-size: cover;
	position: absolute;
	opacity: 0.3;
	top: 0px;
	left: 0px;
	right: 0px; bottom : 0px;
	justify-content: center;
	display: flex;
	bottom: 0px;
}

.image h2 {
	color: #464646;
	text-align: center;
	line-height: 400px;
	position: relative;
}

</style>
</head>
<body>
	<nav>
		<div class="logo">
			<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<div class="loginBox">
			<button onclick="location.href='login'" class="logButton"> LOGIN </button>
		</div>
	</nav>
	<main>
		<div class="buttonAll">
			<button onclick="location.href='locationSearch'" class="button">위치 탐색</button>
			<button onclick="location.href='reserve'" class="button">예약 관리</button>
			<button onclick="location.href='boardMain'" class="button">게시판</button>
			<button onclick="location.href='adFaqList'" class="button">FAQ</button>
		</div>
		<div class="rankBox">
			<div class="company1">
				<div>업체 1</div>
				<div>누적 이용자 수 : </div>
				<div>별점 : </div>
			</div>
			<div class="company2">
				<div>업체 2</div>
				<div>누적 이용자 수 : </div>
				<div>별점 : </div>
			</div>
			<div class="company3">
				<div>업체 3</div>
				<div>누적 이용자 수 : </div>
				<div>별점 : </div>
			</div>
		</div>
	</main>
	<footer>
		<div class="image">
			<h2>내 근처의 위탁소가 궁금할 땐, '돌봐주개'</h2>
		</div>
	</footer>
</body>
<script>

</script>
</html>