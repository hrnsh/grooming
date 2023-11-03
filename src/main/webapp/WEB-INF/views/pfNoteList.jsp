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
<link rel="stylesheet" href="resources/css/profileCommon.css" type="text/css">
<style>

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
	border: 1px solid brown;
	border-radius: 50px;
	align-items: center;
	position: relative;
	left: 90px;
}

.pagingBox{
	position: relative;
	left: 15%;
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
	top: 50px;
	left: 82%;
}

.receiveBox{
	width: 40%;
	height: 450px;
	border: 1px solid brown;
	border-radius: 50px;
	align-items: center;
	position: relative;
	left: 120px;
}

.receiveContent{
	margin: 30px;
}


</style>
</head>
<body>
	<nav>
		<div class="logo">
			<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='./pfNormal'" class="profButton">내 프로필</button>
			<button onclick="location.href='./pfNoteList'" class="profButton">쪽지함</button>
			<button onclick="location.href='./pfWrite'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='./pfNotiList'" class="profButton">알림함</button>
			<button onclick="location.href='./pfReportList'" class="profButton">신고 내역</button>
		</div>
		<div class="sentListBox">
			<div class="sentListContent">
				<h1>내가 쓴 쪽지</h1>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allSent" name="allSent" class="checkCol"/></th>
							<th class="subjectCol">제목</th>
							<th class="dateCol">날짜</th>
							<th class="idCol">받는 사람</th>
							<th class="readCol">읽음</th>
						</tr>
					</thead>
					<tbody id="sentList">
						
					</tbody>
				</table>
			</div>
			<button onclick="delSent()" class="delBtn">삭제</button>
			<div id="paging" class="pagingBox">
				<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공함-->
				<div class="container">
					<nav aria-label="Page navigation" style="text-align: center">
						<ul class="pagination" id="paginationSent"></ul>
					</nav>
				</div>
			</div>
		</div>
		<div class="receiveBox">
			<div class="receiveContent">
				<h1>받은 쪽지</h1>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allReceive" name="allReceive" class="checkCol"/></th>
							<th class="subjectCol">제목</th>
							<th class="dateCol">날짜</th>
							<th class="idCol">받는 사람</th>
							<th class="readCol">읽음</th>
						</tr>
					</thead>
					<tbody id="receiveList">
						
					</tbody>
				</table>
			</div>
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
	</main>
</body>
<script>

// 내가 쓴 쪽지 리스트 호출 
var showPage=1;
sentListCall(showPage);

function sentListCall(page){
	$.ajax({
		type:'get',
		url:'sentList',
		data:{'page':page},
		dataType:'JSON',
		success: function(data){
			console.log(data)
			drawList(data);
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawList(sentList){
	console.log(sentList);
	var content='';
	sentList.list.forEach(function(item,note_num){ 
		content+='<tr>';
		content+='<td><input type="checkbox" name="allSentCheck" value="'+item.note_num+'" class="checkReadTd"/></td>';
		content+='<td class="subjectColTd"><a href="pfNoteSend?idx='+item.note_num+'">'+item.note_subject+'</a></td>';
		var date = new Date(item.note_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.receiver+'</td>';
		content+='<td class="checkReadTd">'+item.note_state+'</td>';
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


// 받은 쪽지 리스트 호츨
receiveListCall(showPage);

function receiveListCall(page){
	$.ajax({
		type:'get',
		url:'receiveList',
		data:{'page':page},
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
		content+='<td>'+item.receiver+'</td>';
		content+='<td class="checkReadTd">'+item.note_state+'</td>';
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





</script>
</html>