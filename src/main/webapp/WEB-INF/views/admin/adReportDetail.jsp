<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="resources/css/adminProfileCommon.css" type="text/css">

<style>

main{
	height: 650px;
}

.nav {
	height: 150px;
	display: flex;
	justify-content: space-between;
	margin-top: 40px;
}

.logo {
	position: relative;
	left: 50px;
	top: 10px;
}

.arrowBtn{
	position: absolute;
	border: none;
	background-color: white;
	font-size: 40px;
	right: 1000px;
	top: 70px;
}

.detailBox{
	width: 800px;
	height: 300px;
	border: 1px solid black;
	border-radius: 50px;
	position: relative;
	left: 50px;
	bottom: 140px;
}

th, td{
	border: none;
	border-collapse: collapse;
	padding: 8px 10px;
}

.topRow{
	height: 50px;
	border-bottom: 1px solid black;
	text-align: center;
	margin-top: 30px;
}

table{
	border-collapse: collapse;
	width: 700px;
	border: none;
	position: relative;
	left: 50px;
}

.replyBtn{
	position: absolute;
	left: 70%;
	top: 40%;
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
}

.targetBtn{
	height: 20px;
	width: 50px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 5px;
	color: white;
}

button{
	cursor: pointer;
}

.handleBox{
	position: relative;
	width: 800px;
	height: 230px;
	top: 80px;
	border: 1px solid black;
	border-radius: 50px;
}




</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="arrowBtn"> ← </button>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adReservationManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 예약 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
		<div class="detailBox">
			<span style="left: 70px; top:20px; position: relative; font-size:20px; border-bottom:1px solid black;">신고 내역</span>
			<div style="width:90%; height:80%; position:relative; top: 30px;overflow:scroll;">
			<table>
				<tr>
					<td style="width: 70px;">신고자</td>
					<td colspan="3">${reportDetail.user_id}</td>
				</tr>
				<tr>
					<td>신고 일자</td>
					<td>${reportDetail.report_date}</td>
				</tr>	
				<tr>
					<td>신고 분류</td>
					<td>
						<c:choose>
							<c:when test="${reportDetail.report_type==0}">게시글</c:when>
							<c:when test="${reportDetail.report_type==1}">리뷰</c:when>
							<c:when test="${reportDetail.report_type==2}">댓글</c:when>
							<c:when test="${reportDetail.report_type==3}">예약</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>처리 상태</td>
					<td>
						<c:choose>
							<c:when test="${reportDetail.report_state==0}">미완료</c:when>
							<c:when test="${reportDetail.report_state==1}">처리중</c:when>
							<c:when test="${reportDetail.report_state==2}">완료</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>
					<td>신고 내용</td>
					<td>${reportDetail.report_content}</td>
				</tr>
				<tr>
					<td>신고 대상</td>
					<td><button onclick="reportTarget()" class="targetBtn">보기</button></td>
				</tr>
			</table>
			</div>
			<!--상태가 '2' 이면 처리내역 출력 -->
			<c:if test="${reportDetail.report_state==2}">
				<div class="handleBox">
					<span style="left: 70px; top:20px; position: relative; font-size:20px; border-bottom:1px solid black;">처리 내역</span>
						<div style="width:90%; height:140px; position:relative; top: 35px;overflow:scroll;">
						<table style="width: 92%;">
							<tr>
								<td style="width: 70px;">처리 일자</td>
								<td colspan="3">${reportDetail.rephis_date}</td>
							</tr>
							<tr>
								<td>담당자</td>
								<td>${reportDetail.ad_id}</td>
							</tr>
							<tr>
								<td style="vertical-align: top;">처리 내용</td>
								<td>${reportDetail.rephis_content}</td>
							</tr>
						</table>
						</div>
					</div>
			</c:if>
		</div>
		<c:if test="${reportDetail.report_state==1}">
			<button onclick="location.href='adReportAnswer?report_num=${reportDetail.report_num}'" class="replyBtn">답장</button>
		</c:if>
	</main>
</body>
<script>

var ad_id="${sessionScope.ad_id}";
if (!ad_id) {
    alert("관리자 권한이 필요한 페이지 입니다.");
    location.href = "./"; 
}

function reportTarget(){
	
	
}

</script>
</html>