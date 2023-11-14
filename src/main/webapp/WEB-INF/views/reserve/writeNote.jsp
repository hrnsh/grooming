<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
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

.writeBox{
	width: 800px;
	height: 400px;
	border: 1px solid black;
	border-radius: 50px;
	position: relative;
	left: 25%;
	top: 50px;
	padding: 10px;
}
th, td{
	border: none;
	border-collapse: collapse;
	padding: 5px 10px;
	text-align: left;
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

#confirm_modal{
	display: none; 
	width:300px; 
	height:150px; 
	background: rgb(237, 237, 237); 
	border:1px solid gray; 
	text-align:center;
	position:absolute; 
	left:80%; 
	margin-left:-200px; 
	bottom: 70%;
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

#modalCheckBtn{
	height: 35px;
	width: 80px;
	color: white;
	border: none;
	border-radius: 10px;
	background-color: rgb(94, 94, 94);
}
</style>
</head>
<body>

	<nav class="nav">
		<div class="logo">
			<img  onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<c:forEach items="${rev}" var="rev">
		<button id="detailGO" onclick="location.href='reserveDetail?idx=${rev.r_num}'" class="arrowBtn"> ← </button>
		</c:forEach>
		<h1> 쪽지 작성 </h1>
	</nav>
	<main>
		<div class="writeBox">
		<form id="writeForm" action="revNote">
		<c:forEach items="${rev}" var="rev">
			<table>
				<tr>
					<td style="width:70px;">제목</td>
					<td style="display:none;"><input type="text" name="r_num" value="${rev.r_num}"/></td>
					<td><input type="text" name="subject" id="subject" style="width: 300px;"/></td>
				</tr>
				<tr class="topRow">
					<td>받는 사람</td>
					<td><input type="text" readonly name="receiver" value="${rev.com_id}"/></td>
				</tr>
				<tr>
					<td colspan="2" class="content"><textarea name="content" placeholder="내용을 입력해 주세요."></textarea></td>
				</tr>
			</table>
			<input type="button" value="보내기" class="sendBtn" onclick="openModal()"/>
		</c:forEach>
		</form>
		</div>

		<!-- 모달 -->
		<div id="send_modal">
			<div style="margin:30px 0; font-size:22px;">전송 하시겠습니까?</div>
			<button id="sendNo" class="modalBtnNo">아니요</button>
			<button id="sendYes" class="modalBtnYes">예</button>	
		</div>
		<!-- 모달 -->
		<div id="confirm_modal">
			<div style="margin:30px 0; font-size:22px;">제목, 내용을 입력해 주세요.</div>
			<button id="modalCheckBtn">확인</button>
		</div>
	</main>
</body>
<script>

var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("로그인이 필요한 서비스 입니다.");
    location.href = "./"; 
}


function openModal(){
	var modal = document.getElementById('send_modal');
	var yesBtn = document.getElementById('sendYes');
	var noBtn = document.getElementById('sendNo');	
	var confirm_modal = document.getElementById('confirm_modal');
	var modalCheckBtn = document.getElementById('modalCheckBtn');
	
	if($('textarea').val()==''){
		confirm_modal.style.display="block";
		modalCheckBtn.onclick=function(){
			confirm_modal.style.display="none";
		}
	}else{
		modal.style.display="block";
		
		noBtn.onclick = function() {
	        modal.style.display = "none";
	    }
		
		yesBtn.onclick = function(){
			document.getElementById('writeForm').submit();
			console.log($('input[name="subject"]').val());
			console.log('form 전송 성공!');
			alert('전송이 완료 되었습니다!');
		}
	}
	
}
</script>
</html>