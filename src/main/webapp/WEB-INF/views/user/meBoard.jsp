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
	left: 500px;
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

.profButtonBox{

		top: 162px;

}

.logo{
	cursor: pointer;
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
	</nav>

		<div class="profButtonBox">
			<button onclick="location.href='./profile?user_id=${sessionScope.loginId}'" class="profButton">내 프로필</button>
			<button onclick="location.href='./pfNoteList?user_id=${sessionScope.loginId}'" class="profButton">쪽지함</button>
			<button onclick="location.href='./pfWrite?user_id=${sessionScope.loginId}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='./pfReportList?user_id=${sessionScope.loginId}'" class="profButton">신고 내역</button>
		</div>
		
		<div class="sentListBox">
			<div class="sentListContent">
				<h1>내가 쓴 글</h1>
				<input type="date" id="datePicker" class="datePicker"/>
				<input id="search" type="submit" value="검색">
				<table>
					<thead>
						<tr>
							<th><input type="checkbox" id="allSent" class="checkCol"/>선택</th>
							<th class="subjectCol">제목</th>
							<th class="dateCol">날짜</th>
							<th class="idCol">조회수</th>
							
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

	<footer>
	
	</footer>
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
var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("로그인이 필요합니다. 로그인 후 이 페이지를 이용하실 수 있습니다.");
    location.href = "./"; 
}



sentListCall(showPage);


function sentListCall(page){	
	var loginId = "${sessionScope.loginId}";
	$.ajax({
		type:'get',
		url:'memyBoardList',
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
		content+='<td class="subjectColTd"><a href="boardDetail?b_num='+item.b_num+'">'+item.b_subject+'</a></td>';
		var date = new Date(item.b_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		content+='<td>'+dateStr+'</td>';
		content+='<td>'+item.b_hit+'</td>';		
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
		url:'mebDelList',
		data:{'mebDelList' : chkArr},
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


$(".logo").on("click", function(){
	
	console.log("logo클릭");
	location.href="./";
	
});


</script>
</html>