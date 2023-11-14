<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>일반 문의 관리</title>
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
	right: 310px;
}

h1{
	position: relative;
	right: 220px;
	top: 50px;
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
	width: 1000px;
	position: relative;
	left: 50px;
	top: 50px;
	border-radius: 10px;
  	border-style: hidden;
  	box-shadow: 0 0 0 1px #000;
}

.subjectColTd{
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.inquiryBox{
	position: relative;
	left: 100px;
	height: 100%;
}

.subjectCol{	
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#paging {
	position: relative;
	top: 70px;
	right: 50px;
}

a{
	color: black;
}

.searchBox{
	width: 250px;
	position: relative;
	left: 70%;
}

.dateSearchBox{
	position: relative;
	top: 7%;
}

#inquiryDatePickSend{
	position: relative;	
	left: 47%;
}

#inquiryDatePickHandle{
	position: relative;	
	left: 61%;
}


</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<h1>일반 문의 관리</h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
		<div class="inquiryBox">
			<!-- 검색바 숨김 처리 -->
			<span class="searchBox" style="display:none;">
				<input type="text" id="search"/> 
				<button onclick="searchId()" id="searchBtn">검색</button>
			</span>
			<span class="dateSearchBox">
				<input type="date" id="inquiryDatePickSend"/>
				<input type="date" id="inquiryDatePickHandle"/>				
			</span>
				<table>
					<thead>
						<tr>
							<th style="width:50px;">번호</th>
							<th class="subjectCol">제목</th>
							<th style="width:120px;">접수 일자</th>
							<th style="width:70px;">회원</th>
							<th style="width:70px;">담당자</th>
							<th style="width:120px;">처리 일자</th>
							<th style="width:40px;">
								<select id="stateOption">
									<option value="all">전체</option>
									<option value="complete">완료</option>
									<option value="inProcess">처리중</option>
									<option value="uncompleted">미완료</option>
								</select>
							</th>
						</tr>
					</thead>
					<tbody id="inquiryList">
						
					</tbody>
				</table>
				<div id="paging">
					<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공함-->
					<div class="container">
						<nav aria-label="Page navigation" style="text-align: center">
							<ul class="pagination" id="pagination"></ul>
						</nav>
					</div>
				</div>
		</div>
	</main>
</body>
<script>
var ad_id="${sessionScope.ad_id}";
if (!ad_id) {
    alert("관리자 권한이 필요한 페이지 입니다.");
    location.href = "./"; 
}


var showPage=1;
inquiryListCall(showPage);

// 처리 상태 필터링
$('#stateOption').change(function(){
	console.log($(this).val());
	inquiryListCall(showPage);
});


// 접수 날짜 필터링 
var selectedSendDate;
document.getElementById('inquiryDatePickSend').addEventListener('change', sendDateChange);

function sendDateChange() {
    // 변경된 날짜 값을 가져옴
    var selectedSendDate = document.getElementById('inquiryDatePickSend').value;
    $.ajax({
        type: "get",
        url: "inquiryDatePickSend", 
        data: {"selectedDate":selectedSendDate,"page":showPage},
        dataType:'JSON',
        success: function (data) {
            console.log(data);
            drawInquiryList(data);
        },
        error: function (error) {
            console.error(error);
        }
    });  
}

//처리 날짜 필터링 
document.getElementById('inquiryDatePickHandle').addEventListener('change', handleDateChange);

function handleDateChange() {
    // 변경된 날짜 값을 가져옴
    var selectedSendDate = document.getElementById('inquiryDatePickHandle').value;
    $.ajax({
        type: "get",
        url: "inquiryDatePickHandle", 
        data: {"selectedDate":selectedSendDate,"page":showPage},
        dataType:'JSON',
        success: function (data) {
            console.log(data);
            drawInquiryList(data);
        },
        error: function (error) {
            console.error(error);
        }
    });  
}


function inquiryListCall(page){	
	var ad_id = "${sessionScope.ad_id}";
	var option = 0;
	if($('#stateOption').val()=='complete'){
		option=2;
	}else if($('#stateOption').val()=='inProcess'){
		option=1;
	}else{
		option=0;
	}
	
	$.ajax({
		type:'get',
		url:'inquiryListCall',
		data:{'page':page,'ad_id':ad_id, 'stateOption':$('#stateOption').val(),'option':option}, 
		dataType:'JSON',
		success: function(data){
			console.log(data)
			drawInquiryList(data);	
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawInquiryList(inquiryList){
	console.log(inquiryList);
	var content='';
	var ad_id = "${sessionScope.ad_id}";
	
	inquiryList.list.forEach(function(item,inq_num){ 
		content+='<tr>';
		content+='<td style="text-align: center;">'+item.inq_num+'</td>';
		content+='<td class="subjectColTd"><a href="adInquiryDetail?inq_num='+item.inq_num+'">'+item.inq_subject+'</a></td>';
		var date = new Date(item.inq_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		var hisDate = new Date(item.inqhis_date);
		var hisDateStr = hisDate.toLocaleDateString("ko-KR");
		content+='<td style="text-align: center;">'+dateStr+'</td>';
		content+='<td style="text-align: center;">'+item.user_id+'</td>';
		content+='<td style="text-align: center;">'+ad_id+'</td>';
		content+='<td style="text-align: center;">'
			if(hisDateStr=='Invalid Date'||item.inqhis_date==null){
				content+='확인중';
			}else{
				content+=hisDateStr;
			}
		content+='</td>';
		content+='<td style="text-align: center;">' 
			if(item.inq_state==0){
				content+='미완료';
			}else if(item.inq_state==1){
				content+='처리중';
			}else{
				content+='완료';
			}
		content+='</td>';			
		content+='</tr>';
	});
	$('#inquiryList').empty();
	$('#inquiryList').append(content);
	
	$('#pagination').twbsPagination({
		startPage: inquiryList.currPage,
		totalPages: inquiryList.pages, 
		visiblePages:5, 
		onPageClick:function(e,page){ 
			if(showPage != page){ 
				console.log(page);	
				showPage=page; 
				inquiryListCall(page);
			}
		}
	});
}

/* // 검색 기능 
function searchId(){
	inquiryListCall(showPage);
}

$("#search").keypress(function(e){
	//검색어 입력 후 엔터키 입력하면 조회버튼 클릭
	if(e.keyCode && e.keyCode == 13){
		$("#searchBtn").trigger("click");
		return false;
	}
	//엔터키 막기
	if(e.keyCode && e.keyCode == 13){
		  e.preventDefault();	
	}
}); */


</script>
</html>