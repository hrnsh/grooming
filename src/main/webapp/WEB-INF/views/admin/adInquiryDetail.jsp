<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title> 일반 문의 관리</title>
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
	height: 400px;
	border: 1px solid black;
	border-radius: 50px;
	position: relative;
	left: 50px;
	bottom: 140px;
}

th, td{
	border: none;
	border-collapse: collapse;
	padding: 5px 10px;
}

.topRow{
	height: 50px;
	border-bottom: 1px solid black;
	text-align: center;
}

table{
	border-collapse: collapse;
	width: 700px;
	table-layout: fixed;
	border: none;
	position: relative;
	left: 50px;
}

.replyBtn{
	position: absolute;
	left: 70%;
	top: 50%;
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
}

button{
	cursor: pointer;
}

.handleBox{
	position: relative;
	width: 800px;
	height: 200px;
	top: 80px;
	border: 1px solid black;
	border-radius: 50px;
}


</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img  onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="arrowBtn"> ← </button>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
		<div class="detailBox">
			<table>
				<tr class="topRow">
					<td colspan="4" style="text-align:left;">${newIqDetail.inq_subject}</td>
				</tr>
				<tr>
					<td colspan="2"></td>
					<td>${newIqDetail.inq_date}</td>
					<td>|&nbsp;&nbsp;&nbsp;${newIqDetail.user_id}</td>
					<td>
						<c:choose>
							<c:when test="${newIqDetail.inq_state==0}">|&nbsp;&nbsp;&nbsp;미완료</c:when>
							<c:when test="${newIqDetail.inq_state==1}">|&nbsp;&nbsp;&nbsp;처리중</c:when>
							<c:when test="${newIqDetail.inq_state==2}">|&nbsp;&nbsp;&nbsp;완료</c:when>
						</c:choose>
					</td>
				</tr>
				<tr>	
					<td colspan="3" style="height:300px;">${newIqDetail.inq_content}</td>
					<c:if test="${photo!=null}">
						<td colspan="2" style="text-align:center;">
							<img src="/photo/${photo.newFileName}" width="200" alt="${photo.oriFileName}"/>
						</td>	
					</c:if>
				</tr>
			</table>
			<!--상태가 '2' 이면 처리내역 출력 -->
			<c:if test="${newIqDetail.inq_state==2}">
				<div class="handleBox">
					<span style="left: 70px; top:20px; position: relative; font-size:20px;">처리 내역</span>
						<div style="width:90%; height:120px; position:relative; top: 25px;overflow:scroll;">
						<table style="border: 1px solid black; width: 92%;">
							<tr>
								<td style="width: 80px;">처리 일자</td>
								<td>${newIqDetail.inqhis_date}</td>
							</tr>
							<tr>
								<td>담당자</td>
								<td>${newIqDetail.ad_id}</td>
							</tr>
							<tr>
								<td>제목</td>
								<td>${newIqDetail.inqhis_subject}</td>
							</tr>
							<tr>
								<td style="vertical-align: top;">처리 내용</td>
								<td>${newIqDetail.inqhis_content}</td>
							</tr>
						</table>
						</div>
					</div>
			</c:if>
		</div>
		<c:if test="${newIqDetail.inq_state==1}">
			<button onclick="location.href='adInquiryAnswer?inq_num=${newIqDetail.inq_num}'" class="replyBtn">답장</button>
		</c:if>
	</main>
</body>
<script>

var ad_id="${sessionScope.ad_id}";
if (!ad_id) {
    alert("관리자 권한이 필요한 페이지 입니다.");
    location.href = "./"; 
}

</script>
</html>