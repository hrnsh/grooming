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
	<jsp:include page="loginBox.jsp" />
	<table>
		<tr>
			<th>
				<button
					onclick="location.href='profile?user_id=${sessionScope.loginId}'"
					class="button">내 프로필</button>
			</th>
		</tr>
		<tr>
			<th>
				<button
					onclick="location.href='pfNoteList?user_id=${sessionScope.loginId}'"
					class="button">쪽지함</button>
			</th>
		</tr>
		<tr>
			<th>
				<button
					onclick="location.href='pfWrite?user_id=${sessionScope.loginId}'"
					class="button">내가 쓴 글</button>
			</th>
		</tr>
		<tr>
			<th>
				<button
					onclick="location.href='pfNotiList?user_id=${sessionScope.loginId}'"
					class="button">알림함</button>
			</th>
		</tr>
		<tr>
			<th>
				<button
					onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'"
					class="button">신고 내역</button>
			</th>
		</tr>
	</table>
	<table>
		<tr>
			<th>ID</th>
			<th>${member.user_id}</th>
		</tr>
		<tr>
			<th>PW</th>
			<th>${member.pw}</th>
		</tr>
		<tr>
			<th>이름</th>
			<th>${member.name}</th>
		</tr>
		<tr>
			<th>e-mail</th>
			<th>${member.email}</th>
		</tr>
		<tr>
			<th>전화번호</th>
			<th>${member.phone}</th>
		</tr>
		<tr>
			<th>상태</th>
			<th>${member.state}</th>
		</tr>
	</table>
	
	<table>
		<tr>
			<th><input type="button" id="listCall" value="동물 리스트" /></th>
			<th>이름</th>
			<th>성별</th>
			<th>나이</th>
			<th>종</th>
			<th>특이사항</th>
		</tr>
		<tbody id="list">

		</tbody>
	</table>
</body>
<script>	
console.log("listCall : " + listCall);
	
	$('#listCall').on('click', function() {
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
	});
	
	console.log("listCall2 : " + listCall);

	
	function drawList(list) {
		console.log("drawList : " + list);
		var content = '';
		list	.forEach(function(item, a_num) {
					content += '<tr>';
					content += '<th>'+item.a_num+'</th>';
					content += '<th>'+item.a_name+'</th>';
					content += '<th>'+item.a_gender+'</th>';
					content += '<th>'+item.a_age+'</th>';
					content += '<th>' + item.a_kind + '</th>';
					content += '<th>'+item.a_spec+'</th>';
					content += '<tr>';
				});
		$('#list').empty();
		$('#list').append(content);
	}
	
</script>
</html>