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
				<button	onclick="location.href='profile?user_id=${sessionScope.loginId}'"	class="button">내 프로필</button>
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
					onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'"
					class="button">신고 내역</button>
			</th>
		</tr>
	</table>
	
		<form action="profileupdate" method="post">
		
		<input type="submit" value="수정 완료" />
	
		<table>
			<tr>
				<th>ID</th>
				<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${member.user_id}" /></th>
			</tr>
			<tr>
				<th>PW</th>
				<th><input type="text" name="pw" value="${member.pw}" /></th>
			</tr>
			<tr>
				<th>이름</th>
				<th><input style="border: none; background: transparent;" type="text" name="name" readonly="readonly" value="${member.name}"/></th>
			</tr>
			<tr>
				<th>e-mail</th>
				<th><input style="border: none; background: transparent;" type="email" name="email" readonly="readonly" value="${member.email}"/></th>
			</tr>
			<tr>
				<th>전화번호</th>
				<th><input type="text" name="phone" value="${member.phone}"/></th>
			</tr>
			<tr>
				<th>상태</th>
				<th><input style="border: none; background: transparent;" type="text" name="state" readonly="readonly" value="${member.state}"/></th>
			</tr>
		</table>
	</form>
	
	<input type="button" id="userstatedeleter" value="회원 탈퇴"/>
	
	<input type="button" id="animalprofiledelete" onclick = "del()" value="삭제"/>
	
	<button	onclick="location.href='animalregisterForm?user_id=${sessionScope.loginId}'" class="button">동물 등록</button>
	
	<div style = "width : 50%; height : 700px; overflow : auto">
	<table width = "100%" border = "0" cellspacing = "0" cellpadding = "0" >
		<tr>
			<th><input type="checkbox" id = "allchecker"/></th>
			<th>번호</th>
			<th>이름</th>
			<th>성별</th>
			<th>나이</th>
			<th>종</th>
			<th>특이사항</th>
		</tr>
		<tbody id="updatelist">

		</tbody>
	</table>
	</div>
	
</body>
<script>
updatelistCall();

console.log("updatelistCall : " + updatelistCall);

$('#userstatedeleter').on('click',function(){
	var user_id = '${sessionScope.loginId}';
	console.log("탈퇴 회원 아이디 : " + user_id);
	
	$.ajax({
		type:'post',
		url:'userstatedeleter',
		data:{'user_id' : user_id},
		dataType:'JSON',
		success:function(data){
			console.log(data);
		},
		error:function(e){
			console.log(e);
		}
	});
});


$('#allchecker').on('click',function(){
	var $chk = $('input[type = "checkbox"]');
	console.log($chk);
	
	if($(this).is(":checked")){
		$chk.prop("checked",true);
	}else{
		$chk.prop("checked",false);
	}
});

function del(){
	var chkArr = [];
	$('input[type = "checkbox"]:checked').each(function(a_num,item){
		var val = $(item).val();
		if(val != 'on'){
			chkArr.push(val);
		}
	});
	
	console.log("chkArr : " + chkArr);
	
	$.ajax({
		type:'get',
		url:'animalprofiledelete',
		data:{'animaldeleteList':chkArr},
		datatype:'JSON',
		success:function(data){
			console.log(data);
			if(data.delete_count>0){
				console.log("data!! : " + data)
				updatelistCall();
			}
		},
		error:function(e){
			console.log(e);
		}
	});
}


	function updatelistCall(){
	var user_id = '${sessionScope.loginId}';

	$.ajax({
		type : 'get',
		url : 'updatelistCall',
		data : {
			'user_id' : user_id
			},
		dataType : 'json',
		success : function(data) {
			console.log(data);
			drawList(data.updatelist);
		},
		error : function(e) {
			console.log(e);
		}
	});
};

console.log("updatelistCall : " + updatelist);

function drawList(updatelist) {
	console.log("drawList : " + updatelist);
	var content = '';
	updatelist.forEach(function(item, a_num) {
				content += '<tr>';				
				content += '<th><input type="checkbox" value="'+item.a_num+'"/></th>';
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
				content += '<tr>';
			});
	$('#updatelist').empty();
	$('#updatelist').append(content);
}

$(".logo").on('click',function(){
	
	location.href='./';
	
});

</script>
</html>