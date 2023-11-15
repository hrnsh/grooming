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
main {
      margin-top: 50px;
    }

nav {
    height: 200px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-right: 45%;
}

    .logo {
	margin-left: 50px;
	right: 0px;
}

.del{
padding: 10px;
      margin: 5px;
      cursor: pointer;
      border: none;
background-color:  rgb(94, 94, 94);
color: white;

}

    .logo img {
      width: 150px;
      height: 120px;
      cursor: pointer;
    }

   h1 {
      margin: 0;
    }

    table {
      width: 500px;
      height: 200;
      margin: 20px auto;
      border-collapse: collapse;
    }

    th, td {
      border: 1px solid #ddd;
      padding: 8px;
      text-align: left;
    }

    tr:hover {
      background-color: #f5f5f5;
    }

    form {
      text-align: center;
      margin-top: 20px;
      margin-left: 30px;
    }

    input[type="submit"],
    input[type="button"],
    input[type="checkbox"] {
      padding: 10px;
      margin: 5px;
      cursor: pointer;
      border: none;
    }

    #allchecker {
      cursor: pointer;
    }

    #updatelist {
      max-height: 700px;
      overflow: auto;
    }

    #userstatedeleter,
    #animalprofiledelete {
      margin-top: 20px;
    }

table, th, td {
	margin: 10px;
	border-bottom: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
	height: 80px;
	/* margin-left: 100px; */
}

/* table {
	float: left;
} */

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

.profButtonBox{
	width: 20px;
	position: absolute;
	top: 10px;
	display:flex;
	left: 50px;
	flex-direction: column;
}

.profButtonBox {
      display: flex;
      margin-top: 10px;
    }
    
    .profButton{
    	cursor: pointer;
    }
    
</style>
</head>
<body>

<nav class="nav">
	<div class="logo">
		<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120 />
	</div>
	<h1 style="text-align: center;">프로필 수정</h1>
</nav>
	

	<main>
	<div class="profButtonBox">
				<button	onclick="location.href='profile?user_id=${sessionScope.loginId}'"	class="profButton">내 프로필</button>
				<button onclick="location.href='pfNoteList?user_id=${sessionScope.loginId}'" class="profButton">쪽지함</button>
				<button onclick="location.href='pfWrite?user_id=${sessionScope.loginId}'" class="profButton">내가 쓴 글</button>
				<button	onclick="location.href='pfReportList?user_id=${sessionScope.loginId}'" class="profButton">신고 내역</button>
	</div>
	
		<form action="profileupdate" method="post">
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
			<tr>
				<th colspan="3" style="text-align: center;"><input class="del" type="button" id="userstatedeleter" value="회원 탈퇴"/><input type="submit" value="수정 완료" /></th>
				
			</tr>
		</table>
	</form>
	
	
	
	
	<div>
	<input type="button" class="del" id="animalprofiledelete" onclick = "del()" value="삭제"/>
	<input type="button" onclick="location.href='animalregisterForm?user_id=${sessionScope.loginId}'" class="button" value="동물 등록"/>
	<div style = "width : 600px; height : 600px; overflow : auto">
	<table>
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
	</div>
	
		</main>
	
	
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