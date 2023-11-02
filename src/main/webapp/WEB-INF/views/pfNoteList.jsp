<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<style>
nav {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.logo {
	margin-left: 50px;
}

table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}

table{
	width: 500px;
}

</style>
</head>
<body>
	<nav>
		<div class="logo">
			<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
	</nav>
	<h1>내가 쓴 쪽지</h1>
	<table>
		<thead>
			<tr>
				<th><input type="checkbox" id="all"/></th>
				<th>제목</th>
				<th>날짜</th>
				<th>받는 사람</th>
				<th>읽음</th>
			</tr>
		</thead>
		<tbody id="sentList">
			
		</tbody>
	</table>
	<button onclick="del()">삭제</button>
</body>
<script>
listCall();

function listCall(){
	$.ajax({
		type:'get',
		url:'listCall',
		data:{},
		dataType:'JSON',
		success: function(data){
			console.log(data)
			drawList(data.sentList);
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawList(sentList){
	console.log(sentList); // 여기까진 나옴
	var content='';
	sentList.forEach(function(item,note_num){ // 오류
		content+='<tr>';
		content+='<td><input type="checkbox"/></td>';
		content+='<td>'+item.note_subject+'</td>';
		var date = new Date(item.note_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.receiver+'</td>';
		content+='<td>'+item.note_state+'</td>';
		content+='</tr>';
	});
	$('#sentList').empty();
	$('#sentList').append(content);
}

</script>
</html>