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
	border: 1px solid black;
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
	<h1 style="text-align: center;">업체 수정</h1>
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

	<table style="text-align: left;">
		<tr>
			<th>유저 ID</th>
			<th colspan="4"><input style="border: none; background: transparent;" readonly="readonly" type="text" 
				name="user_id" value="${sessionScope.loginId}" /></th>
		</tr>
		<tr>
			<th>업체 번호</th>
			<th colspan="4"><input style="border: none; background: transparent;" readonly="readonly" type="text" name="com_num" value="${com_num}" /></th>
		</tr>
		<tr>
			<th>픽업 가능 거리 (업체 기준 반경)</th>
			<th colspan="4">
				<input id='Pdistance' onkeyup='printPdistance()' type="text" name="p_distance" value="" />
			</th>
		</tr>
		<tr>
			<th rowspan="4">구간 별 가격</th>
		</tr>
		<tr>
			<th colspan="2">구간</th>
			<th><input id='PdistanceResult' type="text" readonly="readonly" name="p_distance" value="" /></th>
			<th><input type="text" name="p_section" value="" /></th>
			<th><input type="text" name="p_price" value="" /></th>
		</tr>
		<tr>
			<th colspan="2">구간 2</th>
			<th><input id='PdistanceResult' type="text" readonly="readonly" name="p_distance" value="" /></th>
			<th><input type="text" name="p_section" value="" /></th>
			<th><input type="text" name="p_price" value="" /></th>
		</tr>
		<tr>
			<th colspan="2">구간 3</th>
			<th><input id='PdistanceResult' type="text" readonly="readonly" name="p_distance" value="" /></th>
			<th><input type="text" name="p_section" value="" /></th>
			<th><input type="text" name="p_price" value="" /></th>
		</tr>
		<tr>
			<th colspan="5" style="text-align: center;">
				<input type="button" id="writepickupinfo" value="픽업 정보 입력 완료" />
			</th>
		</tr>
	</table>
</body>
<script>
$('#writepickupinfo').on('click',function(){
	var $com_num = $('input[name="com_num"]');
	var $p_distance = $('input[name="p_distance"]');
	var $p_section = $('input[name="p_section"]');
	var $p_price = $('input[name="p_price"]');
			 
	console.log("업체 번호 : " + $com_num.val());
	console.log("업체 픽업 가능 거리 : " + $p_distance.val());

	
	var param = {};
	param.com_num = $com_num.val();
	param.p_distance = $p_distance.val();
	param.p_section = $p_section.val();
	param.p_price = $p_price.val();
	
	console.log("픽업 거리 정보 파라메터" + param);

	$.ajax({
		type:'post',
		url:'writepickupdistance',
		data:param,
		dataType:'JSON',
		success:function(data){
			console.log(data);
			console.log("픽업 정보 등록")
		},
		error:function(e){
			console.log(e);
		}
	});
});


/* 
 pickuplistCall();
 
 console.log("listCall : " + pickuplistCall);

function pickuplistCall(){
	var com_num = '${com_num}';
	console.log("com_num : " + com_num);
	
	$.ajax({
		type : 'get',
		url : 'pickuplistCall',
		data : {
			'com_num' : com_num
		},
		dataType : 'json',
		success : function(data){
			console.log(data)
				drawpickupList(data.pickuplist);
			
		},
		error : function(e) {
			console.log(e);
		}
	});
};

console.log("pickuplistCall : " + pickuplistCall);

function drawpickupList(pickuplist){
	console.log("drawList : " + pickuplist);
	var content = '';
	
	pickuplist.forEach(function(item, p_num){
		content += '<tr>';
		content += '<th>'+item.p_num+'</th>';
		content += '<th>'+item.com_num+'</th>';
		content += '<th>'+item.p_distance+'</th>';
		content += '<th>'+item.p_section+'</th>';
		content += '<th>'+item.p_price+'</th>';
		content += '<th>';
	});
	$('#pickuplist').empty();
	$('#pickuplist').append(content);
} */
	


	
		
</script>
</html>