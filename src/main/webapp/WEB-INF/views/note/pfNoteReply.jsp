<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지 답장</title>
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
	right: 900px;
	top: 115px;
}

.detailBox{
	width: 800px;
	height: 400px;
	border: 1px solid black;
	border-radius: 50px;
	padding-top: 15px;
}

th, td{
	border: none;
	border-collapse: collapse;
	padding: 10px 10px;
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
	height: 10px;
}

.sendBtn{
	position: relative;
	left: 80%;
	top: 20%;
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

.receiverTxt{
	width: 300px;
}

textarea{
	width: 100%;
	height: 250px;
	resize: none;
	font-size: 16px;
	padding: 10px;
}

</style>
</head>
<body>
		<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<button onclick="location.href='./pfNoteList?user_id=${sessionScope.loginId}'" class="arrowBtn"> ← </button>
		<h1>쪽지 답장 하기</h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='./pfNormal?user_id=${sessionScope.loginId}'" class="profButton">내 프로필</button>
			<button onclick="location.href='./pfNoteList?user_id=${sessionScope.loginId}'" class="profButton">쪽지함</button>
			<button onclick="location.href='./pfWrite?user_id=${sessionScope.loginId}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='./pfReportList?user_id=${sessionScope.loginId}'" class="profButton">신고 내역</button>
		</div>
		<div class="detailBox">
			<form action="sendNote" method="post">
			<table>
				<tr class="topRow">
					<td class="subject">제목 : <input type="text" class="subjectTxt" name="subject"/></td>
					<td class="receiverTxt">|&nbsp;&nbsp;&nbsp; 받는 사람 : <input type="text" value="${noteReply.sender}" name="receiver" readonly/></td>
				</tr>
				<tr>
					<td colspan="3" class="content"><textarea name="content" placeholder="내용을 입력해 주세요."></textarea></td>
				</tr>
			</table>
			<input type="submit" value="보내기" class="sendBtn"/>
			</form>
		</div>
	</main>
</body>
<script>
var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("페이지에 권한이 없습니다.");
    location.href = "./"; 
}

</script>
</html>