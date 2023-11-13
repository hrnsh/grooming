<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
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
	<input type="button" value="프로필 수정" onclick="location.href='profileUpdateForm?user_id=${sessionScope.loginId}'"/>
	<div class="buttonBox">
		<button	onclick="location.href='profile?user_id=${sessionScope.loginId}'"	class="button">내 프로필</button>
		<button	onclick="location.href='pfNoteList?user_id=${sessionScope.loginId}'"	class="button">쪽지함</button>
		<button	onclick="location.href='pfWrite?user_id=${sessionScope.loginId}'"	class="button">내가 쓴 글</button>
		<button	onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'" class="button">신고 내역</button>
	</div>
	
		<button onclick="location.href='nomalLogout'" class="logoutBtn">로그아웃</button>
			
	<table>
		<tr>
			<th>ID</th>
			<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${member.user_id}"/></th>
		</tr>
		<tr>
			<th>PW</th>
			<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${member.pw}"/></th>
		</tr>
		<tr>
			<th>이름</th>
			<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${member.name}"/></th>
		</tr>
		<tr>
			<th>e-mail</th>
			<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${member.email}"/></th>
		</tr>
		<tr>
			<th>전화번호</th>
			<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${member.phone}"/></th>
		</tr>
		<tr>
			<th>상태</th>
			<th><input style="border: none; background: transparent;" type="text" name="user_id" readonly="readonly" value="${member.state}"/></th>
		</tr>
	</table>
	
	
	<div style = "width : 60%; height : 495px; overflow : auto">
	<table width = "60%" border = "0" cellspacing = "0" cellpadding = "0" >
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
	
		<table>
		<tr>
		<tbody id="comlist">
		
		</tbody>
		</tr>
		</table>
		
	<button name="stateupdater" onclick="location.href='comregisterForm?user_id=${sessionScope.loginId}'">업체 등록</button>
		
	<%-- <button name="comupdater" id = "comupdater" onclick="location.href='pickupinfoForm?com_num=${item.com_num}'">업체 수정</button> --%>
	
</body>
<script>	
listCall();
comlistCall();

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
		console.log("drawList : " + list);
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
	
	function comlistCall(){
			var user_id = '${sessionScope.loginId}';
			console.log("profile user_id : " + user_id);
			
			$.ajax({
				type : 'get',
				url : 'comlistCall',
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
						drawList2(data);
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		};
		
		console.log("comlistCall : " + comlistCall);

		function drawList2(comlist) {
			console.log("drawList2 : " + comlist.comlist);
			var content = '';
			comlist.comlist.forEach(function(item, comlist) {
						content += '<tr>';
						content += '<th>'+"번호"+'</th>';
						content += '<th colspan="2">'+item.com_num+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"아이디"+'</th>';
						content += '<th colspan="2">'+item.user_id+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"업체 명"+'</th>';
						content += '<th colspan="2">'+item.com_name+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"영업 시간"+'</th>';
						content += '<th colspan="2">'+item.com_time+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"수용 가능 수"+'</th>';
						content += '<th colspan="2">'+item.accept+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"픽업 여부"+'</th>';
						content += '<th>'+item.pickup+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"총 이용자 수"+'</th>';
						content += '<th colspan="2">'+item.user_total+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"평균 별점"+'</th>';
						content += '<th colspan="2">'+item.avg_star+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th>'+"주소"+'</th>';
						content += '<th colspan="2">'+item.address+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th><button id="pickupbutton" onclick='+'"location.href='+"'pickupinfoForm?com_num="+item.com_num+"'"+'">가격표 보기</button></th>';
						content += '</tr>';
					});
				$('#comlist').empty();
				$('#comlist').append(content);
				
		}
		
		$(".logo").on('click',function(){
			
			location.href='./';
			
		});
		
</script>
</html>