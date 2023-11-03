<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
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
nav {
	height: 150px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.logo {
	margin-left: 50px;
}

table, th, td{
	border: 1px solid black;
	border-collapse: collapse;
	padding: 5px 10px;
}

table{
	width: 500px;
}

main{
	height: 540px;
	background-size: 175%;
	background-position: 46% 4%;
	display: flex;
	align-items: center;
	justify-content: center;
	position: relative;	
}

.sentListBox{
	width: 40%;
	height: 450px;
	border: 1px solid brown;
	border-radius: 50px;
	align-items: center;
	position: relative;
	left: 100px;
}

.pagingBox{
	position: relative;
	left: 18%;
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
	left: 80%;
}

.receiveBox{
	width: 40%;
	height: 450px;
	border: 1px solid brown;
	border-radius: 50px;
	align-items: center;
	position: relative;
	left: 150px;
}

.receiveContent{
	margin: 30px;
}

.buttonBox{
	width: 60%;
	position: absolute;
	top: 10px;
	display:flex;
	left: 50px;
	flex-direction: column;
}

.button{
	border: none;
	background-color: rgb(224, 224, 224);
	border-radius: 500px;
	margin-top: 30px;
	height: 50px;
	width: 150px;
	font-size: 18px;
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
		<div class="buttonBox">
			<button onclick="location.href='./pfNormal'" class="button">내 프로필</button>
			<button onclick="location.href='./pfNoteList'" class="button">쪽지함</button>
			<button onclick="location.href='./pfWrite'" class="button">내가 쓴 글</button>
			<button onclick="location.href='./pfNotiList'" class="button">알림함</button>
			<button onclick="location.href='./pfReportList'" class="button">신고 내역</button>
		</div>
		<div class="sentListBox">
			<div class="sentListContent">
				<h1>내가 쓴 쪽지</h1>
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="all"/></th>
							<th>제목</th>
							<th>날짜</th>
							<th>받는 사람</th>
							<th>읽음</th>
						</tr>
					</thead>
					<tbody id="sentList">
						
					</tbody>
				</table>
			</div>
			<button onclick="del()" class="delBtn">삭제</button>
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
							<th><input type="checkbox" id="all"/></th>
							<th>제목</th>
							<th>날짜</th>
							<th>받는 사람</th>
							<th>읽음</th>
						</tr>
					</thead>
					<tbody id="receiveList">
						
					</tbody>
				</table>
			</div>
			<button onclick="del()" class="delBtn">삭제</button>
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
		content+='<td><input type="checkbox"/></td>';
		content+='<td>'+item.note_subject+'</td>';
		var date = new Date(item.note_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.receiver+'</td>';
		content+='<td>'+item.note_state+'</td>';
		content+='</tr>';
	});
	$('#sentList').empty();
	$('#sentList').append(content);
	
	// 페이징 처리 UI 그리기 (플러그인 사용)
	$('#paginationSent').twbsPagination({
		startPage: sentList.currPage, // 보여줄 페이지 (1,2,3..) ***페이지 변경 이슈로 showPage 에서 obj.currPage로 변경
		totalPages: sentList.pages, // 총 페이지 수 (총 게시물 수/페이지 당 보여줄 게시물 수) - 서버에서 계산해서 가져와야 함
		visiblePages:5, // [1],[2],[3],[4],[5] - 고정값이다.
		onPageClick:function(e,page){ // 번호 클릭시 실행할 내용
			//console.log(e);
			if(showPage != page){ // page 가 1 이면 보여주지 않기? (처음 켜지면 console에 1을 보여준다)
				console.log(page);	
				showPage=page; // 클릭해서 다른 페이지를 보여주게 되면 현재 보고 있는 페이지 번호도 변경해준다.
				sentListCall(page);
			}
		}
	});
}

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
		content+='<td><input type="checkbox"/></td>';
		content+='<td>'+item.note_subject+'</td>';
		var date = new Date(item.note_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.receiver+'</td>';
		content+='<td>'+item.note_state+'</td>';
		content+='</tr>';
	});
	$('#receiveList').empty();
	$('#receiveList').append(content);
	
	// 페이징 처리 UI 그리기 (플러그인 사용)
	$('#pagenationReceive').twbsPagination({
		startPage: receiveList.currPage, // 보여줄 페이지 (1,2,3..) ***페이지 변경 이슈로 showPage 에서 obj.currPage로 변경
		totalPages: receiveList.pages, // 총 페이지 수 (총 게시물 수/페이지 당 보여줄 게시물 수) - 서버에서 계산해서 가져와야 함
		visiblePages:5, // [1],[2],[3],[4],[5] - 고정값이다.
		onPageClick:function(e,page){ // 번호 클릭시 실행할 내용
			//console.log(e);
			if(showPage != page){ // page 가 1 이면 보여주지 않기? (처음 켜지면 console에 1을 보여준다)
				console.log(page);	
				showPage=page; // 클릭해서 다른 페이지를 보여주게 되면 현재 보고 있는 페이지 번호도 변경해준다.
				receiveListCall(page);
			}
		}
	});
}




</script>
</html>