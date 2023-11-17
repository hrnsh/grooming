<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>

<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/profileCommon.css" type="text/css">
<style>

a{
	color: black;
}

.nav {
	height: 150px;
	display: flex;
	justify-content: space-between;
}

.container{
	max-width: 450px;
	left: 30px;
}

.logo{
	position: relative;
	right: 43%;
}

main{
	max-width: 100%;
}

table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}

th{
	 text-align: center;
}

table{	
	width: 500px;
	table-layout: fixed;
}

#readOptionSent, #readOptionReceive{
	position: relative;
	left: 310px;
	margin-bottom: 5px;
}

.datePickerSent, .datePickerReceive{
	position: relative;
	left: 230px;
}

.subjectCol{
	width: 190px;
	min-width:190px;
	max-width: 190px;
}

.subjectColTd{
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.idCol{
	width: 100px;
	min-width:100px;
	max-width: 100px;
}

.dateCol{
	width: 125px;
	min-width:125px;
	max-width: 125px;
}

.readCol{
	width: 50px;
	min-width:50px;
	max-width: 50px;
}

.checkCol{
	width: 15px;
	min-width:15px;
	max-width: 15px;
}

.checkReadTd{
	text-align: center;
}

.sentListBox{
	width: 40%;
	height: 450px;
	border: 1px solid black;
	border-radius: 50px;
	align-items: center;
	position: relative;
	left: 90px;
}

.sentListContent{
	margin: 30px;
}

.delBtn{
	height: 35px;
	width: 55px;
	background-color: rgb(94, 94, 94);
	border: none;
	border-radius: 10px;
	color: white;
	position: relative;
	top: 30px;
	left: 80%;
}


.receiveBox{
	width: 40%;
	height: 450px;
	border: 1px solid black;
	border-radius: 50px;
	align-items: center;
	position: relative;
	left: 120px;
}

.receiveContent{
	margin: 30px;
}

button{
	cursor: pointer;
}

#del_modal, #del_modal_receive{
	display: none; 
	width:300px; 
	height:150px; 
	background: rgb(237, 237, 237); 
	border:1px solid gray; 
	text-align:center;
}

#del_modal{
	position:absolute; 
	left:50%; 
	top:-120px; 
	margin-left:-200px; 
}

#del_modal_receive{
	position:absolute; 
	left:50%; 
	top:-120px; 
	margin-left:200px; 
}


.modalBtnNo, .modalBtnYes{
	height: 35px;
	width: 80px;
	color: white;
	border: none;
	border-radius: 10px;
}

.modalBtnNo{
	background-color: gray;
}

.modalBtnYes{
	background-color: rgb(94, 94, 94);
}



</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width="150" height="120"/>
		</div>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='./profile?user_id=${sessionScope.loginId}'" class="profButton">내 프로필</button>
			<button onclick="location.href='./pfNoteList?user_id=${sessionScope.loginId}'" class="profButton">쪽지함</button>
			<button onclick="location.href='./pfWrite?user_id=${sessionScope.loginId}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='./pfReportList?user_id=${sessionScope.loginId}'" class="profButton">신고 내역</button>
		</div>
		<!-- 내가 쓴 쪽지 -->
		<div class="sentListBox">
			<div class="sentListContent">
				<h1>보낸 쪽지</h1>
				<input type="date" id="datePickerSent" class="datePickerSent"/>
				<select id="readOptionSent">
					<option value="all">전체</option>
					<option value="read">읽음</option>
					<option value="unread">안읽음</option>
				</select>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allSent" class="checkCol"/></th>
							<th class="subjectCol">제목</th>
							<th class="dateCol">날짜</th>
							<th class="idCol">받는 사람</th>
							<th class="readCol">읽음</th>
						</tr>
					</thead>
					<tbody id="sentList">
						
					</tbody>
				</table>
				<button onclick="del_modal()" class="delBtn">삭제</button>
				<div id="paging" class="pagingBox">
					<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공함-->
					<div class="container">
						<nav aria-label="Page navigation" style="text-align: center">
							<ul class="pagination" id="paginationSent"></ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
		<!-- 모달 -->
		<div id="del_modal">
			<div style="margin:30px 0; font-size:24px;">삭제 하시겠습니까?</div>
			<button onclick="delNoSent()" class="modalBtnNo">아니요</button>
			<button onclick="delYesSent()" class="modalBtnYes">예</button>	
		</div>
		<!-- 받은 쪽지 -->
		<div class="receiveBox">
			<div class="receiveContent">
				<h1>받은 쪽지</h1>
				<input type="date" id="datePickerReceive" class="datePickerReceive"/>
				<select id="readOptionReceive">
					<option value="all">전체</option>
					<option value="read">읽음</option>
					<option value="unread">안읽음</option>
				</select>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allReceive" class="checkCol"/></th>
							<th class="subjectCol">제목</th>
							<th class="dateCol">날짜</th>
							<th class="idCol">보낸 사람</th>
							<th class="readCol">읽음</th>
						</tr>
					</thead>
					<tbody id="receiveList">
						
					</tbody>
				</table>
				<button onclick="delReceive()" class="delBtn">삭제</button>
				<div id="paging" class="pagingBox">
					<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공함-->
					<div class="container">
						<nav aria-label="Page navigation" style="text-align: center">
							<ul class="pagination" id="pagenationReceive"></ul>
						</nav>
					</div>
				</div>
			</div>
		</div>
		<!-- 모달 -->
		<div id="del_modal_receive">
			<div style="margin:30px 0; font-size:24px;">삭제 하시겠습니까?</div>
			<button onclick="delNoReceive()" class="modalBtnNo">아니요</button>
			<button onclick="delYesReceive()" class="modalBtnYes">예</button>	
		</div>
	</main>
</body>
<script>
// 로그인 여부에 따른 페이지 권한 설정
var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("로그인이 필요합니다. 로그인 후 이 페이지를 이용하실 수 있습니다.");
    location.href = "./"; 
}

// 내가 쓴 쪽지 리스트 호출
var showPage=1;
sentListCall(showPage);

// 내가 쓴 쪽지 읽음 여부 필터링 
$('#readOptionSent').change(function(){
	console.log($(this).val());
	sentListCall(showPage);
});

// 내가 쓴 쪽지 날짜 필터링 
var selectedSendDate;
document.getElementById('datePickerSent').addEventListener('change', sendDateChange);

function sendDateChange() {
    // 변경된 날짜 값을 가져옴
    var selectedSendDate = document.getElementById('datePickerSent').value;
    var loginId = "${sessionScope.loginId}";
    $.ajax({
        type: "get",
        url: "noteSendDateFilter", // 여기에 실제 컨트롤러의 URL을 입력하세요.
        data: {"selectedDate":selectedSendDate,"page":showPage,"loginId":loginId},
        dataType:'JSON',
        success: function (data) {
            console.log(data);
            drawSentList(data);
        },
        error: function (error) {
            console.error(error);
        }
    });  
}

function sentListCall(page){	
	var loginId = "${sessionScope.loginId}";
	$.ajax({
		type:'get',
		url:'sentList',
		data:{'page':page,'loginId':loginId,'readOptionSent':$('#readOptionSent').val()}, 
		dataType:'JSON',
		success: function(data){
			console.log(data);
			drawSentList(data);	
		},
		error:function(e){
			console.log(e);
		}
	});
}

function drawSentList(sentList){
	console.log(sentList);
	var content='';
	sentList.list.forEach(function(item,note_num){ 
		content+='<tr>';
		content+='<td><input type="checkbox" name="allSentCheck" value="'+item.note_num+'" class="checkReadTd"/></td>';
		content+='<td class="subjectColTd"><a href="pfNoteSend?idx='+item.note_num+'">'+item.note_subject+'</a></td>';
		var date = new Date(item.note_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>';
		if(item.receiver!=null){
			content+=item.receiver;
		}else{
			content+='관리자';
		}
		content+='</td>';
		content+='<td>';
		if(item.note_state==0){
			content+='<img src="resources/img/unread.jpg" alt="logoImage" width=20 height=20/>';
		}else{
			content+='<img src="resources/img/read.jpg" alt="logoImage" width=20 height=20/>';
		}
		content+='</td>';		
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

// 내가 쓴 쪽지 체크 박스 
$('#allSent').on('click',function(){
	var $chk = $('input[name="allSentCheck"]');
	console.log($chk);
	console.log($(this).is(":checked")); 
	if($(this).is(":checked")){
		$chk.prop("checked",true);
	}else{
		$chk.prop("checked",false);
	}
}); 

// 내가 쓴 쪽지 삭제 모달창 (체크했을 때만 나타남)
function del_modal(){
	document.getElementById('del_modal').style.display = 'block';
}

// 모달창 아니요 버튼 클릭
function delNoSent(){
	document.getElementById('del_modal').style.display = 'none';
}

// 모달창 예 버튼 클릭 (리스트에서 숨김 처리)
function delYesSent(){
	var chkArr = []; 
	$('input[name="allSentCheck"]:checked').each(function(idx,item){
		//console.log(idx, $(item).val()); 
		var val = $(item).val();
		if(val != 'on'){
			chkArr.push(val);
		}
	});
	console.log(chkArr);

	$.ajax({
		type:'get',
		url:'delSent',
		data:{'delList' : chkArr},
		dataType:'JSON',
		success:function(data){
			console.log(data);
			if(data.del_cnt>0){
				alert('요청하신 '+data.del_cnt+'개의 게시물이 삭제 되었습니다.');
				sentListCall(showPage);
				document.getElementById('del_modal').style.display = 'none';
			}
		},
		error:function(e){
			console.log(e)
		}
	});
}

// 받은 쪽지 리스트 호츨
receiveListCall(showPage);

// 받은 쪽지 읽음 여부 필터링
$('#readOptionReceive').change(function(){
	console.log($('#readOptionReceive').val());
	receiveListCall(showPage);
});


// 받은 쪽지 날짜 필터링 
var selectedReceiveDate;
document.getElementById('datePickerReceive').addEventListener('change', receiveDateChange);

function receiveDateChange() {
    // 변경된 날짜 값을 가져옴
    var selectedReceiveDate = document.getElementById('datePickerReceive').value;
    console.log(selectedReceiveDate);
    var loginId = "${sessionScope.loginId}";
    $.ajax({
        type: "get",
        url: "noteReceiveDateFilter", // 여기에 실제 컨트롤러의 URL을 입력하세요.
        data: {"selectedDate":selectedReceiveDate,"page":showPage,"loginId":loginId},
        dataType:'JSON',
        success: function (data) {
            console.log(data);
            drawReceiveList(data);
        },
        error: function (error) {
            console.error(error);
        }
    });  
}

function receiveListCall(page){
	var loginId = "${sessionScope.loginId}";
	$.ajax({
		type:'get',
		url:'receiveList',
		data:{'page':page,'loginId':loginId,'readOptionReceive':$('#readOptionReceive').val()},
		dataType:'JSON',
		success: function(data){
			console.log(data)
			drawReceiveList(data);
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawReceiveList(receiveList){
	console.log(receiveList);
	var content='';
	receiveList.list.forEach(function(item,note_num){ 
		content+='<tr>';
		content+='<td><input type="checkbox" name="allReceiveCheck" value="'+item.note_num+'" class="checkReadTd"/></td>';
		content+='<td class="subjectColTd"><a href="pfNoteReceive?idx='+item.note_num+'">'+item.note_subject+'</a></td>';
		var date = new Date(item.note_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.sender+'</td>';
		content+='<td>' 
			if(item.note_state==0){
				content+='<img src="resources/img/unread.jpg" alt="logoImage" width=20 height=20/>';
			}else {
				content+='<img src="resources/img/read.jpg" alt="logoImage" width=20 height=20/>';
			}
		content+='</td>';	
		content+='</tr>';
	});
	$('#receiveList').empty();
	$('#receiveList').append(content);
	
	$('#pagenationReceive').twbsPagination({
		startPage: receiveList.currPage, 
		totalPages: receiveList.pages, 
		visiblePages:5, 
		onPageClick:function(e,page){ 
			if(showPage != page){ 
				console.log(page);	
				showPage=page; 
				receiveListCall(page);
			}
		}
	});
}

// 받은 쪽지 체크 박스
$('#allReceive').on('click',function(){
	var $chk = $('input[name="allReceiveCheck"]'); 
	console.log($chk);
	console.log($(this).is(":checked")); 
	if($(this).is(":checked")){
		$chk.prop("checked",true);
	}else{
		$chk.prop("checked",false);
	}
});

// 받은 쪽지 삭제 모달창
function delReceive(){
	document.getElementById('del_modal_receive').style.display = 'block';
}

// 받은 쪽지 '아니요' 버튼 클릭
function delNoReceive(){
	document.getElementById('del_modal_receive').style.display = 'none';
}

// 받은 쪽지 '예' 버튼 클릭 (리스트에서 숨김 처리)
function delYesReceive(){
	var chkArr = []; 
	$('input[name="allReceiveCheck"]:checked').each(function(idx,item){
		//console.log(idx, $(item).val()); 
		var val = $(item).val();
		if(val != 'on'){
			chkArr.push(val);
		}
	});
	console.log(chkArr);

	$.ajax({
		type:'get',
		url:'delReceive',
		data:{'delList' : chkArr},
		dataType:'JSON',
		success:function(data){
			console.log(data);
			if(data.del_cnt>0){
				alert('요청하신 '+data.del_cnt+'개의 게시물이 삭제 되었습니다.');
				receiveListCall(showPage);
				document.getElementById('del_modal_receive').style.display = 'none';
			}
		},
		error:function(e){
			console.log(e)
		}
	});
}




</script>
</html>