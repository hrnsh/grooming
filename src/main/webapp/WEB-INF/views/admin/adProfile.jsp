<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 프로필</title>
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
	right: 50px;
	top: 50px;
	font-size: 35px;
}

.logoutBtn {
    margin-top: 30px;
    height: 40px;
    width: 100px;
    background-color: rgb(224, 224, 224);
    border-radius:10px;
    border: 1px solid rgb(224, 224, 224);
    position: relative;
    right: 50px;
    top: 20px;
}

#adpfdetail{
    background-color: rgb(224, 224, 224);
    border-radius:10px;
    border: 1px solid rgb(224, 224, 224);
}

.button {
    width: 100%;
    border: 1px solid rgb(224, 224, 224);
	border-radius:10px;
}

table {
    margin-top: 20px;
    float: left;
    margin-right: 20px;
    border-collapse: collapse;
    table-layout:fixed;
    border-radius: 10px;
  	border-style: hidden;
  	box-shadow: 0 0 0 1px #000;
}

th, td {
    border: 1px solid rgb(163, 161, 161);
    padding: 8px;
    text-align: center;
}

#adminlist, #adminSearchList {
    overflow-y: auto;
    max-height: 500px;
}

#positionSearchOption {
    margin-top: 20px;
}

.firstBox{
	left: 75px;
	width: 350px;
	height: 500px;
	position: relative;
	top: 20px;
	
}

.secondBox{
	width: 350px;
	height: 500px;
	position: relative;
	left: 80px;
	bottom: 10px;
	padding-top: 20px;
	
}

.thirdBox{
	width: 350px;
	height: 500px;
	position: relative;
	left: 130px;
	bottom: 40px;
}

.option{
	position: relative;
	left: 195px;
	top: 10px;
	width: 50px;
}


</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<h1>내 프로필</h1>
		<button onclick="location.href='adLogout'" class="logoutBtn">로그아웃</button>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
		<div class="firstBox">
			<table style="width: 300px;">
				<tr>
					<th style="width: 70px;">ID</th>
					<th>${admin.ad_id}</th>
				</tr>
				<tr>
					<th>PW</th>
					<th>${admin.ad_pw}</th>
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
				<tr>
					<th colspan="2"><button onclick="location.href='adminprofileUpdateForm?ad_id=${sessionScope.ad_id}'" class = "button">프로필 수정</button></th>
				</tr>
			</table>
		</div>

		<div class="secondBox">
			<div style="font-size:18; top: 10px; position:relative;">관리자 목록</div>
			<table style="width: 350px;">
				<tr>
					<th style="width: 70px;">ID</th>
					<th>이름</th>
					<th>직급</th>
					<th>상세보기</th>
				</tr>
				<tbody id="adminlist">
		
				</tbody>
			</table>
		</div>
		
		<div class="thirdBox">
			<div style="font-size:18; position:relative; top:50px;">직급별 관리자 보기</div>
			<div class="option">
			<select id="positionSearchOption">
				<option value="사장">사장</option>
				<option value="부장">부장</option>
				<option value="팀장">팀장</option>
				<option value="대리">대리</option>
				<option value="사원">사원</option>
			</select>
			</div>
			<table style="width: 350px;">
				<tr>
					<th style="width: 70px;">ID</th>
					<th>이름</th>
					<th>직급</th>
					<th>상세보기</th>
				</tr>
				<tbody id="adminSearchList">
		
				</tbody>
			</table>
		</div>
		
	</main>
</body>
<script>
$(".logo").on('click',function(){
	
	location.href='./adProfile?ad_id=${sessionScope.ad_id}';
	
});

adminlistCall();

adminSearchListCall();

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
	
	var position = null;
	
	
	
	$('#positionSearchOption').change(function() {
		console.log($(this).val());
		position = $(this).val();
		console.log("position : " + position);
		adminSearchListCall();

	});
	
	

	function adminSearchListCall() {
		var ad_position = position;
		
		console.log("ad_position!!! : " + ad_position);
		
		$.ajax({
			type:'get',
			url:'adminSearchList',
			data:{'positionSearchOption':$('#positionSearchOption').val()},
				dataType:'JSON',
				success:function(data){
					console.log("어드민 검색 리스트 : "+ data.adminSearchList);
					drawadminSearchList(data);

				},
				error:function(e){
					console.log(e)
				}
			});
		}
	
	function drawadminSearchList(adminSearchList) {
		console.log("!!!adminSearchList : "+adminSearchList.adminSearchList);
		
		var content='';
		
		adminSearchList.adminSearchList.forEach(function(item, positionSearchOption){
			content += '<tr>';
			content += '<th>'+item.ad_id+'</th>';
			content += '<th>'+item.ad_name+'</th>';
			content += '<th>'+item.ad_position+'</th>';
			content += '<th><button id="adpfdetail" onclick='+'"location.href='+"'adpfdetail?ad_id="+item.ad_id+"'"+'">상세보기</button></th>';
			content += '<tr>';
	
		});
		
		$('#adminSearchList').empty();
		$('#adminSearchList').append(content);
	
	}
	

	
	
	
</script>
</html>


