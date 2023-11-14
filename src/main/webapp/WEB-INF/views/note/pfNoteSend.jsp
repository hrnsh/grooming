<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title> 보낸 쪽지</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="resources/css/profileCommon.css" type="text/css">
<style>

h1{
	position: absolute;
	right: 600px;
	top: 80px;
	font-size: 40px;
}

.arrowBtn{
	position: absolute;
	border: none;
	background-color: white;
	font-size: 40px;
	right: 830px;
	top: 105px;
}

.detailBox{
	width: 800px;
	height: 400px;
	border: 1px solid black;
	border-radius: 50px;
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
	left: 45px;
}

.subject{
	width: 350px;
}

.content {
	border: 1px solid black;
	height: 250px;
	font-size: 16px;
}


.delBtn{
	position: relative;
	left: 80%;
	top: 10%;
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
	cursor: pointer;
}

#delNoteSend{
	display: none; 
	width:300px; 
	height:150px; 
	background: rgb(237, 237, 237); 
	border:1px solid gray; 
	text-align:center;
	position:absolute; 
	left:80%; 
	top:40%; 
	margin-left:-200px; 
}

.modalBtnNo, .modalBtnYes{
	height: 35px;
	width: 80px;
	color: white;
	border: none;
	border-radius: 10px;
}

.modalBtnNo{
	background-color: gray;
}

.modalBtnYes{
	background-color: rgb(94, 94, 94);
}

button{
	cursor: pointer;
}


</style>
</head>
<body>
	<nav>
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<button onclick="location.href='./pfNoteList?user_id=${sessionScope.loginId}'" class="arrowBtn"> ← </button>
		<h1>보낸 쪽지</h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='./pfNormal?user_id=${sessionScope.loginId}'" class="profButton">내 프로필</button>
			<button onclick="location.href='./pfNoteList?user_id=${sessionScope.loginId}'" class="profButton">쪽지함</button>
			<button onclick="location.href='./pfWrite?user_id=${sessionScope.loginId}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='./pfReportList?user_id=${sessionScope.loginId}'" class="profButton">신고 내역</button>
		</div>
		<div class="detailBox">
			<table>
				<tr class="topRow">
					<td class="subject">${sentDetail.note_subject}</td>
					<td>|&nbsp;&nbsp;&nbsp;${sentDetail.note_date}</td>
					<td>|&nbsp;&nbsp;&nbsp;${sentDetail.receiver}</td>
				</tr>
				<tr>
					<td colspan="3" class="content">${sentDetail.note_content}</td>
				</tr>
			</table>
			<button onclick="delNoteSend()" class="delBtn">삭제하기</button>
		</div>
		<!-- 모달 -->
		<div id="delNoteSend">
			<div style="margin:30px 0; font-size:24px;">삭제 하시겠습니까?</div>
			<button onclick="delNo()" class="modalBtnNo">아니요</button>
			<button onclick="location.href='./delNoteSend?idx='+${sentDetail.note_num}+''" class="modalBtnYes">예</button>	
		</div>
	</main>
</body>
<script>

var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("페이지에 권한이 없습니다.");
    location.href = "./"; 
}

function delNoteSend(){
	document.getElementById('delNoteSend').style.display = 'block';
}

function delNo(){
	document.getElementById('delNoteSend').style.display = 'none';
}


</script>
</html>