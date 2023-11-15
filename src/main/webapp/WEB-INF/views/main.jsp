<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta charset="UTF-8">
<title> 돌봐주개 </title>
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

.profileBox {
	width: 300px;
	height: 150px;
	background-color: rgb(255, 232, 230);
	margin-right: 50px;
	border-radius: 50px;
	position: relative;
}

.btnBox{
	width: 300px;
	height: 70px;
	background-color: rgb(243, 208, 204);
	position: absolute;
	display: flex;
	justify-content: space-around;
	top: 80px;
	right:0px;
}

.profileBtn{
	height: 40px;
	width: 80px;
	top: 15px;
	border: none;
	background-color: rgb(243, 208, 204);
	position: relative;
}

.logBtn{
	border: none;
	height: 50px;
	width: 150px;
	background-color: rgb(255, 232, 230);
	padding: 14px 32px;
	border-radius: 500px;
	color: black;
	font-weight: 700;
	font-size: inherit;
	position: absolute;
	top: 30px;
	left: 70px;
}

.adLogBtn{
	border: none;
	height: 30px;
	width: 200px;
	background-color: rgb(255, 232, 230);
	border-radius: 500px;
	color: black;
	font-weight: 700;
	font-size: inherit;
	position: absolute;
	top: 110px;
	color: rgb(158, 158, 158);
}

.logoutBox {
	width: 300px;
	height: 70px;
	background-color: rgb(255, 232, 230);
	position: absolute;
	display: flex;
	justify-content: space-around;
	border-radius: 50px;
}

.logoutNotiBtn{
	border: none;
	width: 70px;
	height: 30px;
	background-color: rgb(255, 232, 230);
	position: relative;
	top: 30px;
}

.name{
	position: relative;
	top: 35px;
	left: 25px;
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
	top: 115px;
}
button{
	cursor: pointer;
}
.button {
	height: 50px;
	width: 150px;
	background-color: rgba(220, 212, 212, 0.49);
	padding: 14px 32px;
	border-radius: 500px;
	border: none;
	color: black;
	font-weight: 700;
	font-size: inherit;
}

.button:hover{
	transform: scale(1.05);
	background-color: rgb(243, 208, 204);
}

.iconAll{
	width: 60%;
	display: flex;
	justify-content: space-around;
	position: absolute;
	top: 0px;
}

.rankBox{
	width: 600px;
	height: 150px;
	background-color: rgba(220, 212, 212, 0.49);
	position: absolute;
	top: 200px;
	border-radius: 30px;
}

.company{
	width: 350px;
	height: 150px;
}

.compName{
	margin-left: 20px;
}

footer {
	height: 400px;
	align-items: center;
	background-color: rgba(220, 212, 212, 0.49);
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
	color: black;
	text-align: center;
	line-height: 400px;
}

.stars {
    font-size: 24px; 
    color: gold;
}


table{
	width: 600px;
	height: 100px;
	border-spacing: 20px;
	border-collapse: seperate;
	table-layout:fixed;
}

a{
	text-decoration: none;
	color: black;
}

a:visited {
  color : black;
}

</style>
</head>
<body>
	<nav>
		<div class="logo">
			<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<div class="profileBox">
			<div class="logoutBox">
					<c:choose>
						<c:when test="${not empty sessionScope.loginId}">
							<div class="name">${sessionScope.loginId} 님</div>
							<button onclick="location.href='./logout'" class="logoutNotiBtn">로그아웃</button>
							<div class="btnBox">
								<button onclick="location.href='./profile?user_id=${sessionScope.loginId}'" class="profileBtn" id="profileBtn">프로필</button>
								<button onclick="location.href='./pfNoteList?user_id=${sessionScope.loginId}'" class="profileBtn">쪽지함</button>
								<button onclick="location.href='./pfWrite?user_id=${sessionScope.loginId}'" class="profileBtn">내가 쓴 글</button>
							</div>
						</c:when>
						<c:otherwise>
							<button onclick="location.href='./login'" class="logBtn" id="loginBtn">LOGIN</button>
							<button onclick="location.href='./adLogin'" class="adLogBtn" id="loginBtn">admin login</button>
						</c:otherwise>
					</c:choose>
			</div>
		</div>
	</nav>
	<main>
		<div class="iconAll">
			<img src="resources/img/mapIcon.jpg" alt="mapIcon" width=100 height=100/>
			<img src="resources/img/calendarIcon.jpg" alt="calendarIcon" width=100 height=100/>
			<img src="resources/img/boardIcon.jpg" alt="boardIcon" width=100 height=100/>
			<img src="resources/img/faqIcon.jpg" alt="faqIcon" width=100 height=100/>
		</div>
		<div class="buttonAll">
			<button onclick="location.href='./locationSearch'" class="button">위치 탐색</button>
			<button onclick="location.href='./revList'" class="button">예약 관리</button>
			<button onclick="location.href='./boardMain'" class="button">게시판</button>
			<button onclick="location.href='./adInquirySend?user_id=${sessionScope.loginId}'" class="button">문의하기</button>
		</div>
		<div class="rankBox">
			<table>
				<c:forEach items="${rank}" var="info">
					<tr>
						<td style="overflow:hidden; text-overflow:ellipsis; white-space:nowrap;"> <a href="location.href='./locationSearch?user_id=${member.id}'">${info.com_name}</a></td>
						<td> 누적 이용자 수 : ${info.user_total}</td>
						<td>
							별점 :
							<c:choose>
								<c:when test="${info.avg_star<=1}">☆☆☆☆☆</c:when>
								<c:when test="${info.avg_star<=1}">★☆☆☆☆</c:when>
								<c:when test="${info.avg_star<=2}">★★☆☆☆</c:when>
								<c:when test="${info.avg_star<=3}">★★★☆☆</c:when>
								<c:when test="${info.avg_star<=4}">★★★★☆</c:when>
								<c:when test="${info.avg_star<=5}">★★★★★</c:when>
							</c:choose>
						</td>
					</tr>
				</c:forEach>
			</table>
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