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
	<h1 style="text-align: center;">가격표 보기</h1>
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
				<input type="text" name="p_distance" value="" /> KM
			</th>
		</tr>
		<tr>
			<th>구간 별 가격</th>
			<th>구간</th>
			<th><input type="text" name="p_section" value="" placeholder="예시) 1 ~ 5 "/></th>
			<th>가격</th>
			<th><input type="text" name="p_price" value="" placeholder="가격을 입력해주십시오"/></th>
		</tr>
		<tr>
			<th colspan="5" style="text-align: center;">
				<input type="button" id="writepickupinfo" value="픽업 정보 입력 완료" />
			</th>
		</tr>
		<tr>
			<th>이용권 가격</th>
			<th colspan="2">
				<input type='radio' name="t_type" value="오전권" />오전권
				<input type='radio' name="t_type" value="오후권" />오후권
				<input type='radio' name="t_type" value="종일권" />종일권
			</th>
			<th colspan="2"><input type='text' name="t_price"	placeholder="가격을 입력해주십시오" value="" /></th>
		</tr>
		<tr>
			<th colspan="5" style="text-align: center;">
				<input type="button" id="writeticketprice" value="예약권 정보 입력 완료" />
			</th>
		</tr>
	</table>
	
	<table>
		<tr>
			<th colspan="5"><input type="button" id="pickuppricedelete" onclick = "pickuppricedelete()" value="픽업 가격표 삭제"/></th>
		</tr>
		<tr>
			<tbody id="pickuplist">

			</tbody>
			
	</table>
	
	<table>
		<tr>
			<th colspan="5"><input type="button" id="ticketpricedelete" onclick = "ticketpricedelete()" value="예약권 가격표 삭제"/></th>
		</tr>
		<tr>
			<tbody id="ticketlist">

			</tbody>
	</table>
	
</body>
<script>
pickuplistCall();

ticketlistCall();

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
		content += '<th><input type="checkbox" value="'+item.p_num+'"/></th>';
		content += '<th>'+item.p_distance+" KM"+'</th>';
		content += '<th>'+item.p_section+" KM"+'</th>';
		content += '<th>'+item.p_price+" 원"+'</th>';
		content += '</tr>';
		
	});
	
	$('#pickuplist').empty();
	$('#pickuplist').append(content);
}



function ticketlistCall(){
	var com_num = '${com_num}';
	console.log("com_num : " + com_num);
	
	$.ajax({
		type : 'get',
		url : 'ticketlistCall',
		data : {
			'com_num' : com_num
		},
		dataType : 'json',
		success : function(data){
			console.log(data)
				drawticketlist(data.ticketlist);
			
		},
		error : function(e) {
			console.log(e);
		}
	});
};

console.log("ticketlistCall : " + ticketlistCall);

function drawticketlist(ticketlist){
	console.log("drawList : " + ticketlist);
	var content = '';
	ticketlist.forEach(function(item, t_num){
		
		content += '<tr>';
		content += '<th><input type="checkbox" value="'+item.t_num+'"/></th>';
		content += '<th>'+item.t_type+'</th>';
		content += '<th>'+item.t_price+" 원"+'</th>';
		content += '</tr>';
		
	});
	$('#ticketlist').empty();
	$('#ticketlist').append(content);
}


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
			pickuplistCall();

		},
		error:function(e){
			console.log(e);
		}
	});
});

$('#writeticketprice').on('click',function(){
	var $com_num = $('input[name="com_num"]');
	var $t_type = $('input[name="t_type"]');
	var $t_price = $('input[name="t_price"]');
			 
	console.log("업체 번호 : " + $com_num.val());
	console.log("예약권 종류 : " + $t_type.val());
	console.log("예약권 가격 : " + $t_price.val());

	
	var param = {};
	param.com_num = $com_num.val();
	param.t_type = $t_type.val();
	param.t_price = $t_price.val();
	
	console.log("예약권 정보 파라메터" + param);

	$.ajax({
		type:'post',
		url:'writeticketprice',
		data:param,
		dataType:'JSON',
		success:function(data){
			console.log(data);
			console.log("예약권 종류 등록")
			ticketlistCall();

		},
		error:function(e){
			console.log(e);
		}
	});
});

function pickuppricedelete(){
	var chkArr = [];
	$('input[type = "checkbox"]:checked').each(function(p_num,item){
		var val = $(item).val();
		if(val != 'on'){
			chkArr.push(val);
		}
	});
	
	console.log("chkArr : " + chkArr);
	
	$.ajax({
		type:'get',
		url:'pickuppricedelete',
		data:{'pickuppricedeleteList':chkArr},
		datatype:'JSON',
		success:function(data){
			console.log(data);
			console.log("픽업 가격표 삭제")
			pickuplistCall();

		},
		error:function(e){
			console.log(e);
		}
	});
}

function ticketpricedelete(){
	var chkArr = [];
	$('input[type = "checkbox"]:checked').each(function(t_num,item){
		var val = $(item).val();
		if(val != 'on'){
			chkArr.push(val);
		}
	});
	
	console.log("chkArr : " + chkArr);
	
	$.ajax({
		type:'get',
		url:'ticketpricedelete',
		data:{'ticketpricedeleteList':chkArr},
		datatype:'JSON',
		success:function(data){
			console.log(data);
			console.log("예약권 가격표 삭제")
			ticketlistCall();

		},
		error:function(e){
			console.log(e);
		}
	});
}
 
$(".logo").on('click',function(){
	
	location.href='./';
	
});
 
</script>
</html>