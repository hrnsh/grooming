<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
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
    
    form {
      text-align: center;
      margin-top: 20px;
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

   input[type="button"] {
       margin: 10px;
      padding: 5px 10px;
      background-color: rgb(224, 224, 224);
      border: none;
      cursor: pointer;
    }

   .profButtonBox {
      display: flex;
      margin-top: 10px;
    }
    
     .profButton{
    	cursor: pointer;
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
      width:450px;
      height:500px;
      margin: 20px;
      border-collapse: collapse;
      justify-content: space-around;
      
    }

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
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
		<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120 />
		</div>
		<h1>동물 등록</h1>
		
		</nav>
	<main>
	<div class="profButtonBox">
		<button	onclick="location.href='profile?user_id=${sessionScope.loginId}'"	class="profButton">내 프로필</button>
		<button	onclick="location.href='pfNoteList?user_id=${sessionScope.loginId}'"	class="profButton">쪽지함</button>
		<button	onclick="location.href='pfWrite?user_id=${sessionScope.loginId}'"	class="profButton">내가 쓴 글</button>
		<button	onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'" class="profButton">신고 내역</button>
	</div>
			
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
	
	<div style = "width : 600px; height : 600px; overflow : auto">
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
	</main>
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