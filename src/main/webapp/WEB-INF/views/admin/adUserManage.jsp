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
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<!-- 페이징 처리를 위한 라이브러리 -->
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/adminProfileCommon.css" type="text/css">

<style>
.nav {
	height: 150px;
	display: flex;
	justify-content: space-between;
	margin-top: 40px;
}

.logo {
	position: relative;
	right: 335px;
}

h1{
	position: relative;
	right: 230px;
	top: 50px;
}

table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}

table{	
	width: 500px;
	height: 450px;
	position: relative;
	left: 50px;
	top: 50px;
	text-align:center;
	border-radius: 10px;
  	border-style: hidden;
  	box-shadow: 0 0 0 1px #000;
}

.listBox{
	position: relative;
	height: 550px;
	left: 2%;
	width: 600px;
	bottom: 50px;
}

#paging {
	position: relative;
	top: 100px;
	right: 50%;
}

.btn{
	position: relative;
	left: 80%;
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
}

.modal{
  position: fixed;
  top:0; left: 0; bottom: 0; right: 0;
  background: rgba(0, 0, 0, 0.8);
}

.modal-content{
	width: 600px;
	height: 550px;
	left: 30%;
	top: 15%;
	border: 1px solid rgb(94, 94, 94);
	align-items:center;
}

form{
	height: 600px;
	width: 600px;
}

.close{
	font-size: 40px;
	right: 10px;
	position: relative;
}

textarea{
	resize: none;
	width: 100%;
	height: 100px;
	border: none;
}

input[type="submit"]{
	height: 35px;
	width: 80px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<h1>회원 관리</h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
		<div class="listBox">
	<table>
		<thead>
			<tr>
				<th class="user_id" style="text-align:center;">회원ID</th>
				<th class="user_name" style="text-align:center;">이름</th>
				<th style="text-align:center;">
				<select id="user_state" name="user_state">
				<option value="전체">전체</option>
				<option value="0">일반</option>
				<option value="2">업체</option>
				<option value="1">승인요청</option>
				<option value="3">정지</option>
				</select>
				</th>
			</tr>
		</thead>
		<tbody id="adUserManageList">

		</tbody>
	</table>
	
			<div id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공-->
				<div class="container">									
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>					
				</div>
			</div>
			<form action="adUserManageResult">
				<input type="submit" value="처리내역" class="btn"/>
			</form>
	</div>
			
	<!-- detail 모달 -->		
	<div id="myModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>			
			<form action="saveManage">
				<table>
					<tr>
						<th style="width:100px;">ID</th>
						<td id="user_id"></td>
						<th style="text-align:center;">관리자</th>
					</tr>
					<tr>
						<th>이름</th>
						<td id="name"></td>
						<td id="ad_id"></td>
					</tr>
					<tr>
						<th>상태</th>
						<td id="state"></td>
						<td>
							<select id="state" name="state">
							<option value="0">일반</option>
							<option value="2">업체</option>
							<option value="3">정지</option>							
							</select>
						</td>
					</tr>
					<tr>
						<th>사업자 등록증</th>
						<td colspan="2" style="text-align:left;" id="photo">사업자 등록증 이미지 링크</td>
					</tr>
					<tr>
						<th colspan="3" style="text-align:left;">사유</th>
					</tr>
					<tr>
						<td colspan="3"><textarea name="m_content" placeholder="사유를 입력해 주세요."></textarea></td>
					</tr>
					<tr>
						<th>처리내역</th>
						<td colspan="2" style="text-align:left;">
							<select id="m_type" name="m_type">
								<option value="승인요청">승인요청</option>
								<option value="정지">정지</option>
								<option value="정지해제">정지해제</option>							
							</select>
						</td>
					</tr>
					<tr>
						<td colspan="3"><textarea name="m_complet" placeholder="내용을 입력해 주세요."></textarea></td>
					</tr>
					<tr>
						<td colspan="3"><input type="submit" onclick="saveManage()"
							value="수정" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	</main>
</body> 
<script>

var showPage = 1;
adUserManageListCall(showPage)

// 상태 필터링
$('#user_state').change(function(){
	console.log($(this).val());
	adUserManageListCall(showPage);
});

function adUserManageListCall(page){	
	var loginId = "${sessionScope.loginId}";
	console.log("여기");
	$.ajax({
		type:'get',
		url:'adUserManageList',
		data:{'loginId':loginId,'user_state':$('#user_state').val(), 'page':page}, 
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
		content+='<td><a href="#" onclick="openModal(\'' + item.user_id + '\')">'+item.user_id+'</a></td>';
		content+='<td>'+item.name+'</td>';
		content+='<td>'
		if(item.state==0){
			content+='일반'
		}else if(item.state==1){
			content+='승인대기'
		}else if(item.state==2){
			content+='업체'
		}else if(item.state==3){
			content+='정지'
		}else if(item.state==4){
			content+='탈퇴'
		}
		'</td>';
		content+='</tr>';
	});

	$('#adUserManageList').append(content);
	$('#pagination').twbsPagination({
		startPage:adUserManageList.currPage, // 보여줄 페이지
		totalPages:adUserManageList.pages,// 총 페이지 수(총갯수/페이지당보여줄게시물수) : 서버에서 계산해서 가져와야함
		visiblePages:5,//[1][2][3][4][5]
		onPageClick:function(e,page){ // 번호 클릭시 실행할 내용
			//console.log(e);
			if(showPage != page){
				console.log(page);
				showPage = page; // 클릭해서 다른 페이지를 보여주게 되면 현재 보고 있는 페이지 번호도 변경해 준다.
				adUserManageListCall(page);
			}
		}
	});
}
var modal = document.getElementById('myModal');
function openModal(user_id) {
	modal.style.display = 'block';
	console.log(user_id);
	var loginId="${sessionScope.ad_id}";
	console.log("관리자"+loginId);
	document.getElementById('ad_id').innerHTML = loginId;
	$.ajax({
		type:'get',
		url:'manageDetail',
		data:{'loginId':loginId,'user_id':user_id}, 
		dataType:'JSON',
		success: function(data){
			console.log("회원정보");	
			console.log(data);
			data.mDetail.forEach(function(item, idx){ 
				document.getElementById('user_id').innerHTML = item.user_id;
				document.getElementById('name').innerHTML = item.name;
				document.getElementById('state').innerHTML = item.state;
			});
		},
		error:function(e){
			console.log(e)
		}
	}); 
}

function closeModal() {
	confirm("정말로 취소하시겠습니까?");
	modal.style.display = 'none';
}

function saveManage(){
	confirm("정말로 수정하시겠습니까?");
	modal.style.display = 'none';
}
	
</script>
</html>