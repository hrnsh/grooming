<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

.arrowBtn{
	position: relative;
	border: none;
	background-color: white;
	font-size: 40px;
	right: 120;
    top: 20px;
}

.tableBox{
	width: 500px;
	height: 450px;
	position: relative;
	left: 10px;
	bottom: 20px;
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="arrowBtn"> ← </button>
		<h1>프로필 상세보기</h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
		<div class="tableBox">
		<table>
			<tr>
				<th>ID</th>
				<th>${admin.ad_id}</th>
			</tr>
			<tr>
				<th>이름</th>
				<th>${admin.ad_name}</th>
			</tr>
			<tr>
				<th>e-mail</th>
				<th>${admin.ad_email}</th>
			</tr>
			<tr>
				<th>전화번호</th>
				<th>${admin.ad_phone}</th>
			</tr>
			<tr>
				<th>직급</th>
				<th>${admin.ad_position}</th>
			</tr>
		</table>
		</div>
		<!-- <select id="positionsearch" name="positionsearch">
			<option value="Boss">사장</option>
			<option value="headofdepartment">부장</option>
			<option value="Teamleader">팀장</option>
			<option value="AssistantManager">대리</option>
			<option value="Employee">사원</option>
		</select>
	<div style = "width : 45%; height : 500px; overflow : auto">
	<table width = "45%" border = "0" cellspacing = "0" cellpadding = "0" >
		<tr>
			<th>ID</th>
			<th>이름</th>
			<th>직급</th>
		</tr>
		<tbody id="adminlist">

		</tbody>
	</table>
	</div> -->
	</main>
</body>
<script>
adminlistCall();

	
	function adminlistCall(){
		$.ajax({
			type : 'get',
			url : 'adminlistCall',
			data : {},
			dataType : 'json',
			success : function(data) {
				console.log(data);
				
					console.log("어드민 리스트 : "+ data.adminlist);
					drawList(data.adminlist);
				
			},
			error : function(e) {
				console.log(e);
			}
		});
	}
	
	function drawList(adminlist) {
		console.log("drawList : " + adminlist);
		var content = '';
		adminlist.forEach(function(item, ad_id) {
					content += '<tr>';
					content += '<th>'+item.ad_id+'</th>';
					content += '<th>'+item.ad_name+'</th>';
					content += '<th>'+item.ad_position+'</th>';
					content += '<th><button id="adpfdetail" onclick='+'"location.href='+"'adpfdetail?ad_id="+item.ad_id+"'"+'">상세보기</button></th>';
					content += '<tr>';
				});
		$('#adminlist').empty();
		$('#adminlist').append(content);
	}
	
	console.log(adminlistCall);

	$(".logo").on('click',function(){
		
		location.href='./adProfile?ad_id=${sessionScope.ad_id}';
		
	});
	
</script>
</html>


