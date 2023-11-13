<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
table, th, td {
	margin: 10px;
	border-bottom: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
	height: 80px;
}

table {
	float: left;
}

button {
	float: left;
	display: flex;
	align-items: left;
}

::-webkit-scrollbar {
	display: none;
}

.profile {
	width: 30%;
	height: 300px;
	float: left;
	border: solid;
	padding: 10px;
}

.animalprofile {
	width: 30%;
	height: 300px;
	float: left;
	border: solid;
	float: left;
}
</style>
</head>
<body>
	<div class="logo">
		<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120 />
	</div>
	<h1 style="text-align: center;">프로필 수정</h1>
	<table>
		<tr>
			<th>
				<button	onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'"	class="button">내 프로필</button>
			</th>
		</tr>
		<tr>
			<th>
				<button	onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'"	class="button">내가 쓴 글</button>
			</th>
		</tr>
		<tr>
			<th>
				<button	onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'"	class="button">회원 관리</button>
			</th>
		</tr>
		<tr>
			<th>
				<button onclick="location.href='adReservationManage?ad_id=${sessionScope.ad_id}'" class="button">회원 예약 관리</button>
			</th>
		</tr>
		<tr>
			<th>
				<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="button">일반 문의 관리</button>
			</th>
		</tr>
		<tr>
			<th>
				<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="button">일반 문의 관리</button>
			</th>
		</tr>
	</table>
	
	<form action="adprofileupdate" method="post">
	
		<table>
			<tr>
				<th>ID</th>
				<th><input type="text" name="ad_id" readonly="readonly" value="${adminProfile.ad_id}" /></th>
			</tr>
			<tr>
				<th>PW</th>
				<th><input type="text" name="ad_pw" value="${adminProfile.ad_pw}" /></th>
			</tr>
			<tr>
				<th>이름</th>
				<th>${adminProfile.ad_name}</th>
			</tr>
			<tr>
				<th>e-mail</th>
				<th>${adminProfile.ad_email}</th>
			</tr>
			<tr>
				<th>전화번호</th>
				<th><input type="text" name="ad_phone" value="${adminProfile.ad_phone}" /></th>
			</tr>
			<tr>
				<th>직급</th>
				<th>${adminProfile.ad_position}</th>
			</tr>
		</table>
		
		<input type="submit" value="수정 완료" />
		
	</form>
	
</body>
<script>
$(".logo").on('click',function(){
	
	location.href='./';
	
});

</script>
</html>