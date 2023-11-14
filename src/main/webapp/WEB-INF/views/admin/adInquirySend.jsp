<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>문의 하기</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>

textarea{
	width: 490px;
	height: 250px;
	resize: none;
	font-size: 16px;
	padding: 10px;
}

.sendBox{
	position: relative;
	width: 600px;
	height: 500px;
	border: 1px solid black;
	border-radius: 50px;
	text-align: center;
	top: 10%;
	left: 30%;
}

.sendBtn{
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
	cursor: pointer;
}

.sendBtn{
	position: relative;
	left: 40%;
	top:10px;
}

input[type=file]::file-selector-button {
	  width: 100px;
	  height: 30px;
	  background: #fff;
	  border: 1px solid rgb(77,77,77);
	  border-radius: 10px;
	  cursor: pointer;
}

.fileBtn{
	position: relative;
  	right: 23%;
  	top:10px;
}

form{
	width: 500px;
	position: relative;
	left: 40px;
	top: 30px;	
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
	</nav>
	<main>
		<div class="sendBox">
			<h2 style="margin-top:20px;">문의 하기</h2>
			<form action="sendInquiry" method="post" enctype="multipart/form-data">
				<table>
					<tr>
						<td style="height:40px;">제목 : <input type="text" name="subject" style="width: 400px;"/></td>
					</tr>
					<tr>
						<td colspan="3">
							<textarea name="content" placeholder="내용을 입력해 주세요."></textarea>
						</td>
					</tr>
				</table> 
				<input type="file" name="photo" class="fileBtn"/> <br/>
				<input type="submit" value="보내기" class="sendBtn" />
			</form>
		</div>
	</main>
</body>
<script>
var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("로그인이 필요합니다. 로그인 후 이 페이지를 이용하실 수 있습니다.");
    location.href = "./"; 
}
</script>
</html>