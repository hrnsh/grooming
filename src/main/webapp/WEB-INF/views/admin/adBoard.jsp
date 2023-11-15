<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
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
    right: 23%;
}

h1{
	position: relative;
	right: 18%;
	top: 55px;
	font-size: 35px;
	font-weight: 5;
}

table {
	width: 100%;
    margin-top: 20px;
    float: left;
    margin-right: 20px;
    border-collapse: collapse;
    table-layout:fixed;
    border-radius: 10px;
  	border-style: hidden;
  	box-shadow: 0 0 0 1px #000;
}

th, td {
    border: 1px solid rgb(163, 161, 161);
    padding: 8px;
    text-align: center;
}

.listBox{
	width: 800px;
	height: 530px;
	position: relative;
	left: 10px;
	bottom: 20px;
}

.boardBtn, .delBtn{
	height: 35px;
	width: 100px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
	position: relative;
	top: 30px;
}

#paging{
	position: relative;
	top: 50px;
	right: 190px;
}

.datePicker{
	position: relative;
	left: 580px;
	top: 10px;
}

#search{
	position: relative;
	left: 580px;
	top: 10px;
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<h1>내가 쓴 글</h1>
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
				<input type="date" id="datePicker" class="datePicker"/>
				<input id="search" type="submit" value="검색">
				<div>
				<table>
					<thead>
						<tr>
							<th style="width:80px;"><input type="checkbox" id="allSent"/></th>
							<th style="width:480px;">제목</th>
							<th>날짜</th>
							<th style="width:80px;">조회수</th>
						</tr>
					</thead>
					<tbody id="sentList">
						
					</tbody>
				</table>
				</div>
				<div>
					<button onclick="location.href='./boardMain'" class="boardBtn">게시판 가기</button>
					<button onclick="del_modal()" class="delBtn">삭제</button>
				</div>
				<div id="paging" class="pagingBox">
					<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공함-->
					<div class="container">
						<nav aria-label="Page navigation" style="text-align: center">
							<ul class="pagination" id="paginationSent"></ul>
						</nav>
					</div>
				</div>
			</div>
</main>
</body>
<script>
var dday = 0;
var showPage=1;


$("#search").on("click", function(){
	
	dday = document.querySelector("#datePicker").value;
	
	console.log(dday);
	
	sentListCall(showPage);
	
		
});




// 로그인 여부에 따른 페이지 권한 설정
var loginId="${sessionScope.ad_id}";
if (!loginId) {
    alert("로그인이 필요합니다. 로그인 후 이 페이지를 이용하실 수 있습니다.");
    location.href = "./"; 
}



sentListCall(showPage);


function sentListCall(page){	
	var loginId = "${sessionScope.ad_id}";
	$.ajax({
		type:'get',
		url:'admyBoardList',
		data:{'page':page,'loginId':loginId, 'date':dday}, 
		dataType:'JSON',
		success: function(data){
			console.log(data)
			drawSentList(data);	
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawSentList(sentList){
	console.log(sentList);
	var content='';
	var loginId = "${sessionScope.loginId}";
	sentList.list.forEach(function(item,note_num){ 
		content+='<tr>';
		content+='<td><input type="checkbox" name="allSentCheck" value="'+item.b_num+'" class="checkReadTd"/></td>';
		content+='<td class="subjectColTd"><a href="adpfNoteSend?idx='+item.b_num+'">'+item.adb_subject+'</a></td>';
		var date = new Date(item.adb_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.adb_hit+'</td>';		
		content+='</tr>';
	});
	$('#sentList').empty();
	$('#sentList').append(content);
	
	$('#paginationSent').twbsPagination({
		startPage: sentList.currPage,
		totalPages: sentList.pages, 
		visiblePages:5, 
		onPageClick:function(e,page){ 
			if(showPage != page){ 
				console.log(page);	
				showPage=page; 
				sentListCall(page);
			}
		}
	});
}

// 체크 박스 
$('#allSent').on('click',function(){
	var $chk = $('input[type="checkbox"]');
	console.log($chk);
	console.log($(this).is(":checked")); 
	if($(this).is(":checked")){
		$chk.prop("checked",true);
	}else{
		$chk.prop("checked",false);
	}
}); 


function del_modal(){
	console.log("삭제버튼 눌림");
	delYesSent();
}



// 삭제
function delYesSent(){
	var chkArr = []; 
	$('input[type="checkbox"]:checked').each(function(idx,item){
		console.log(idx, $(item).val()); 
		var val = $(item).val();
		if(val != 'on'){
			chkArr.push(val);
		}
	});
	console.log(chkArr);

	$.ajax({
		type:'get',
		url:'adbDelList',
		data:{'adbDelList' : chkArr},
		dataType:'JSON',
		success:function(data){
			console.log(data);
			if(data.cnt>0){
				alert('요청하신 '+data.cnt+'개의 게시물이 삭제 되었습니다.');
				sentListCall(showPage);
			}
		},
		error:function(e){
			console.log(e)
		}
	});
}


$('#datePicker').change(function(e){
	//페이지당 보여줄 게시물 갯수가 변경되면 페이징 처리 UI를 지우고 다시 그려준다.
	//안그러면 처음계산한 페이지 값을 그대로 들고있다.
	$('#paginationSent').twbsPagination('destroy');
	sentListCall(showPage);
	
}); 



</script>
</html>