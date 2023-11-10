<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 관리</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
</head>
<body>
	<table>
		<thead>
			<tr>
				<th class="user_id">회원ID</th>
				<th class="user_name">이름</th>
				<th class="user_state">상태</th>
			</tr>
		</thead>
		<tbody id="adUserManageList">

		</tbody>
	</table>
</body>
<script>
adUserManageListCall()

function adUserManageListCall(){	
	var loginId = "${sessionScope.loginId}";
	console.log("여기");
	$.ajax({
		type:'post',
		url:'adUserManageList',
		data:{'loginId':loginId}, 
		dataType:'JSON',
		success: function(data){
			console.log("초기 리스트"+data)
			drawAdUserManageList(data);	
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawAdUserManageList(adUserManageList){
	console.log(adUserManageList);
	$('#adUserManageList').empty();
	var content='';
	adUserManageList.list.forEach(function(item, idx){ 
		content+='<tr>';
		content+='<td><a href="adUserManageDetail?idx='+item.user_id+'">'+item.user_id+'</a></td>';
		content+='<td>'+item.name+'</td>';
		content+='<td>'+item.state+'</td>';
		content+='</tr>';
	});
	$('#adUserManageList').append(content);
}
</script>
</html>