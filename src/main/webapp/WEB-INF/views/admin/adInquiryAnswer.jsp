<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>일반 문의 답장</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="resources/css/adminProfileCommon.css" type="text/css">
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<style>

h1{
	position: absolute;
	right: 600px;
	top: 110px;
	font-size: 35px;
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
	right: 750px;
	top: 130px;
}

.detailBox{
	width: 800px;
	height: 400px;
	border: 1px solid black;
	border-radius: 50px;
	position: relative;
	left: 50px;
	bottom: 20px;
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

button{
	cursor: pointer;
}

.sendBtn{
	position: relative;
	left: 80%;
	top: 15px;
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
}

.subjectTxt{
	width: 300px;
	height: 80%;
}

textarea{
	width: 100%;
	height: 250px;
	resize: none;
	font-size: 16px;
	padding: 10px;
}

#send_modal{
	display: none; 
	width:300px; 
	height:150px; 
	background: rgb(237, 237, 237); 
	border:1px solid gray; 
	text-align:center;
	position:absolute; 
	left:80%; 
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

</style>
</head>
<body>
	<%
        // 현재 날짜와 시간을 가져오기
        Date currentDate = new Date();

        // 날짜를 원하는 형식으로 포맷팅
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = dateFormat.format(currentDate);
    %>

	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<button onclick="location.href='adInquiryDetail?inq_num=${inquiryAnswer.inq_num}'" class="arrowBtn"> ← </button>
		<h1> 답장하기 </h1>
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
		<form id="answerForm" action="inqAnswerSend" method="post">
			<table>
				<tr class="topRow">
					<td style="width: 300px;">제목 : <input type="text" class="subjectTxt" name="subject"/></td>
					<td style="width: 100px;">|&nbsp;&nbsp;&nbsp; <%= formattedDate %></td>
					<td style="width: 100px;">|&nbsp;&nbsp;&nbsp; ${inquiryAnswer.user_id}</td>
					<td style="display:none;"><input type="text" name="inq_num" value="${inquiryAnswer.inq_num}"/></td>
				</tr>
				<tr>
					<td colspan="3" class="content"><textarea name="content" placeholder="내용을 입력해 주세요."></textarea></td>
				</tr>
			</table>
			<input type="button" value="보내기" class="sendBtn" onclick="openModal()"/>
		</form>
		</div>
		<!-- 모달 -->
		<div id="send_modal">
			<div style="margin:30px 0; font-size:22px;">전송 하시겠습니까?</div>
			<button id="sendNo" class="modalBtnNo">아니요</button>
			<button id="sendYes" class="modalBtnYes">예</button>	
		</div>
	</main>
</body>
<script>
var ad_id="${sessionScope.ad_id}";
if (!ad_id) {
    alert("관리자 권한이 필요한 페이지 입니다.");
    location.href = "./"; 
}

function openModal(){
	var modal = document.getElementById('send_modal');
	var yesBtn = document.getElementById('sendYes');
	var noBtn = document.getElementById('sendNo');
	modal.style.display = 'block';
	
	noBtn.onclick = function() {
        modal.style.display = "none";
    }
	
	yesBtn.onclick = function(){
		document.getElementById('answerForm').submit();
		alert('전송이 완료 되었습니다!');
	}
}

</script>
</html>