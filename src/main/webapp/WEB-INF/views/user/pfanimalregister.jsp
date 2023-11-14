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
	<h1 style="text-align: center;">동물 등록</h1>
	<table>
		<tr>
			<th>
				<button	onclick="location.href='profile?user_id=${sessionScope.loginId}'"	class="button">내 프로필</button>
			</th>
		</tr>
		<tr>
			<th>
				<button	onclick="location.href='pfNoteList?user_id=${sessionScope.loginId}'"	class="button">쪽지함</button>
			</th>
		</tr>
		<tr>
			<th>
				<button onclick="location.href='pfWrite?user_id=${sessionScope.loginId}'" class="button">내가 쓴 글</button>
			</th>
		</tr>
		<tr>
			<th>
				<button	onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'" class="button">신고 내역</button>
			</th>
		</tr>
	</table>
	
		<form name="animalsub" action="animalregister" method="post">
		<input type="button" value="등록 완료" id="btnChk"/>
	
		<table>
			<tr>
				<th>유저 ID</th>
				<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${sessionScope.loginId}" /></th>
			</tr>
			<tr>
				<th>이름</th>
				<th><input type="text" name="a_name" value=""/></th>
			</tr>
			<tr>
				<th>성별</th>
				<th>
					<input type="radio" name="a_gender" value="남자"/>남자
					<input type="radio" name="a_gender" value="여자"/>여자
				</th>
			</tr>
			<tr>
				<th>나이</th>
				<th><input type="text" id="a_age" name="a_age" value=""/></th>
			</tr>
			<tr>
				<th>종</th>
				<th>
					<input type="radio" name="a_kind"  value="개"/>개
					<input type="radio" name="a_kind" value="고양이"/>고양이
					<input type="radio" name="a_kind" value="새"/>새
				</th>
			</tr>
			<tr>
				<th>특이사항</th>
				<th><input type="text" name="a_spec" value=""/></th>
			</tr>
		</table>
	</form>
	
	<div style = "width : 75%; height : 500px; overflow : auto">
	<table>
		<tr>
			<th>번호</th>
			<th>이름</th>
			<th>성별</th>
			<th>나이</th>
			<th>종</th>
			<th>특이사항</th>
		</tr>
		<tbody id="list">

		</tbody>
	</table>
	</div>
</body>
<script>
listCall();

console.log("listCall : " + listCall);
	
	function listCall(){
		var user_id = '${sessionScope.loginId}';
		console.log("profile user_id : " + user_id);

		$.ajax({
			type : 'get',
			url : 'listCall',
			data : {
				'user_id' : user_id
			},
			dataType : 'json',
			success : function(data) {
				console.log(data);
				if (!data.login) {
					alert('로그인이 필요한 서비스 입니다.');
					location.href = './';
				} else {
					drawList(data.list);
				}
			},
			error : function(e) {
				console.log(e);
			}
		});
	};
	
	console.log("listCall2 : " + listCall);

	
	function drawList(list) {
		console.log("drawList : " + list.list);
		var content = '';
		list.forEach(function(item, a_num) {
					content += '<tr>';
					content += '<th>'+item.a_num+'</th>';
					content += '<th>'+item.a_name+'</th>';
					content += '<th>'+item.a_gender+'</th>';
					content += '<th>'+item.a_age+'</th>';
					content += '<th>';
					if(item.a_kind=="개"){
						content += '<img src="resources/img/profiledog.png"/>';
					}else if(item.a_kind=="고양이"){
						content += '<img src="resources/img/profilecat.png"/>';
					}else{
						content += '<img src="resources/img/profilebird.png"/>';
					}
					content += '</th>';					
					content += '<th>'+item.a_spec+'</th>';
					content += '</tr>';
				});
		$('#list').empty();
		$('#list').append(content);
	}
	
	$('#btnChk').click(function(){
		if ($("#a_age").val() == "") {	
			alert("이름을 정확히 입력해주세요");
			location.href='profileUpdateForm?user_id=${sessionScope.loginId}';
			}else{
				document.animalsub.submit();
				}
		});
	
	$(".logo").on('click',function(){
		
		location.href='./';
		
	});

</script>
</html>