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
<link rel="stylesheet" href="resources/css/profileCommon.css" type="text/css">

<style>

.logo {
	margin-left: 50px;
	right: 0px;
}

body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

   nav {
	height: 200px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}


    .logo img {
      cursor: pointer;
    }

    h1 {
      margin: 0;
    }

    .logoutBtn {
      margin: 10px;
      padding: 5px 10px;
      background-color: rgb(94, 94, 94);
      color: white;
      border: none;
      cursor: pointer;
    }
    
    .profileupdate {
      margin: 10px;
      padding: 5px 10px;
      background-color: rgb(224, 224, 224);
      border: none;
      cursor: pointer;
    }
    
    .comreg {
      margin: 10px;
      padding: 5px 10px;
      background-color: rgb(224, 224, 224);
      border: none;
      cursor: pointer;
    }

    main {
      padding: 20px;
    }

  /*  input[type="button"] {
      padding: 5px 10px;
      background-color: #4CAF50;
      color: white;
      border: none;
      cursor: pointer;
    } */

   .profButtonBox {
      display: flex;
      margin-top: 10px;
    }
    
    .comtable {
      width: 900px;
      height: 800px;
      margin: 20px;
      border-collapse: collapse;
      justify-content: space-around;
    }
    
    .profButtonBox{
	width: 20px;
	position: absolute;
	top: 10px;
	display:flex;
	left: 50px;
	flex-direction: column;
}
    
    .main2{
	height: 900px;
	background-size: 175%;
	background-position: 46% 4%;
	display: flex;
	align-items: center;
	justify-content: center;
	position: relative;	
}

table {
    margin-top: 20px;
    width:450px;
    height:500px;
    float: left;
    margin-right: 20px;
    border-collapse: collapse;
    table-layout: fixed;
    border-radius: 10px;
    border-style: hidden;
    box-shadow: 0 0 0 1px #000;
}

    /* table {
      width:450px;
      height:500px;
      margin: 20px;
      border-collapse: collapse;
      justify-content: space-around;
      
    } */

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
      height:50px;
      
    }

   tr:nth-child(even) {
      background-color: #f2f2f2;
    }

	::-webkit-scrollbar {
  		display: none;
	}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width="150" height="120"/>
		</div>
		<h1> 환영합니다 ${sessionScope.loginId}님 </h1>
	</nav>
	
	<button onclick="location.href='nomalLogout'" class="logoutBtn">로그아웃</button>
	<button onclick="location.href='profileUpdateForm?user_id=${sessionScope.loginId}'" class = "profileupdate">프로필 수정</button>
	<button onclick="location.href='comregisterForm?user_id=${sessionScope.loginId}'" class = "comreg" name="stateupdater" >업체 등록</button>
	
	<main>
	<div class="profButtonBox">
		<button	onclick="location.href='profile?user_id=${sessionScope.loginId}'"	class="profButton">내 프로필</button>
		<button	onclick="location.href='pfNoteList?user_id=${sessionScope.loginId}'"	class="profButton">쪽지함</button>
		<button	onclick="location.href='pfWrite?user_id=${sessionScope.loginId}'"	class="profButton">내가 쓴 글</button>
		<button	onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'" class="profButton">신고 내역</button>
	</div>
	
		
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
	
	
	<div style = "width : 500px; height : 500px; overflow : auto">
	<table>
		<tr>
			<!-- <th>번호</th> -->
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
	
	</main>
	<main class = "main2">
	<table class = "comtable">
		<tr>
		<tbody id="comlist">
		
		</tbody>
	</table>
	</main>	
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
					/* content += '<th>'+item.a_num+'</th>'; */
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
						content += '<th>'+"가격"+'</th>';
						content += '<th colspan="2">'+item.price+'</th>';
						content += '</tr>';
						content += '<tr>';
						content += '<th colspan = "2"><button id="pickupbutton" onclick='+'"location.href='+"'pickupinfoForm?com_num="+item.com_num+"'"+'">가격표 보기</button></th>';
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