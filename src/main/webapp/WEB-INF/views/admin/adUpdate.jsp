<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 프로필 수정</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="resources/css/adminProfileCommon.css" type="text/css">

<style>

.nav {
    height: 150px;
    display: flex;
    justify-content: space-between;
    margin-top: 40px;
}

.logo {
    position: relative;
    left: 50px;
}

h1{
	position: relative;
	right: 40%;
	top: 50px;
	font-size: 35px;
}

table, th, td {
	margin: 10px;
	border-bottom: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
	height: 70px;
}

table{
	width: 100%;
	border: 1px solid black;
	table-layout:fixed;
    border-radius: 30px;
  	border-style: hidden;
  	box-shadow: 0 0 0 1px #000;
}

form{
	width: 500px;
	left: 30px;
	position: relative;
}

.arrowBtn{
	position: relative;
	border: none;
	background-color: white;
	font-size: 40px;
	right: 120;
    top: 20px;
}

.contentTh{
	text-align: left;
}

input[type="text"]{
	width: 250px;
	height: 30px;
}

input[type="submit"]{
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
	position: relative;
	left: 85%;
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="arrowBtn"> ← </button>
		<h1>프로필 수정</h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
	
		<form action="adprofileupdate" method="post">
		
			<table>
				<tr>
					<th style="width:150px;">ID</th>
					<th colspan="2" class="contentTh"><input type="text" name="ad_id" readonly="readonly" value="${adminProfile.ad_id}" /></th>
				</tr>
				<tr>
					<th>PW</th>
					<th colspan="2" class="contentTh"><input type="text" name="ad_pw" value="${adminProfile.ad_pw}" /></th>
				</tr>
				<tr>
					<th>이름</th>
					<th colspan="2" class="contentTh">${adminProfile.ad_name}</th>
				</tr>
				<tr>
					<th>e-mail</th>
					<th colspan="2" class="contentTh">${adminProfile.ad_email}</th>
				</tr>
				<tr>
					<th>전화번호</th>
					<th colspan="2" class="contentTh"><input type="text" name="ad_phone" value="${adminProfile.ad_phone}" /></th>
				</tr>
				<tr>
					<th>직급</th>
					<th colspan="2" class="contentTh">${adminProfile.ad_position}</th>
				</tr>
			</table>
			
			<input type="submit" value="수정 완료" />
			
		</form>
	</main>
</body>
<script>
$(".logo").on('click',function(){
	
	location.href='./adProfile?ad_id=${sessionScope.ad_id}';
	
});

</script>
</html>