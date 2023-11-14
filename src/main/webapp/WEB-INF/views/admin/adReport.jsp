<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>신고 문의 관리</title>
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

.reportBox{
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
	top: 7%;
}

.dateSearchBox{
	position: relative;
	top: 7%;
}

#reportDatePickSend{
	position: relative;
	left: 14%;	
}

#reportDatePickHandle{
	position: relative;	
	left: 43%;
}

</style>
</head>
<body>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width=150 height=120/>
		</div>
		<h1>신고 문의 관리</h1>
	</nav>
	<main>
		<div class="profButtonBox">
			<button onclick="location.href='adProfile?ad_id=${sessionScope.ad_id}'" class="profButton">내 프로필</button>
			<button onclick="location.href='adWrite?ad_id=${sessionScope.ad_id}'" class="profButton">내가 쓴 글</button>
			<button onclick="location.href='adUserManage?ad_id=${sessionScope.ad_id}'" class="profButton">회원 관리</button>
			<button onclick="location.href='adInquiry?ad_id=${sessionScope.ad_id}'" class="profButton">일반 문의 관리</button>
			<button onclick="location.href='adReport?ad_id=${sessionScope.ad_id}'" class="profButton">신고 문의 관리</button>
		</div>
		<div class="reportBox">
			<span class="searchBox" style="display:none;">
				<input type="text"/> 
				<button onclick="searchId()">검색</button>
			</span>
			<span class="dateSearchBox">
				<input type="date" id="reportDatePickSend"/>
				<input type="date" id="reportDatePickHandle"/>				
			</span>
				<table>
					<thead>
						<tr>
							<th style="width:50px;">번호</th>
							<th style="width:120px;">접수 일자</th>
							<th style="width:70px;">신고자</th>
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
							<th style="width:40px;">
								<select id="typeOption">
									<option value="all">전체</option>
									<option value="reserve">예약</option>
									<option value="board">게시글</option>
									<option value="review">리뷰</option>
									<option value="comment">댓글</option>
								</select>
							</th>
						</tr>
					</thead>
					<tbody id="reportList">
						
					</tbody>
				</table>
				<div id="paging">
					<!-- 	플러그인 사용	(twbsPagination)-->
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
reportListCall(showPage);

// 처리 상태 필터링
$('#stateOption').change(function(){
	console.log($(this).val());
	$('#typeOption').val('all');
	reportListCall(showPage);
});

// 분류 필터링
$('#typeOption').change(function(){
	console.log($(this).val())
	$('#stateOption').val('all');
	reportListCall(showPage);
});

//접수 날짜 필터링 
var selectedSendDate;
document.getElementById('reportDatePickSend').addEventListener('change', sendDateChange);

function sendDateChange() {
    // 변경된 날짜 값을 가져옴
    var selectedSendDate = document.getElementById('reportDatePickSend').value;
    $.ajax({
        type: "get",
        url: "reportDatePickSend", 
        data: {"selectedDate":selectedSendDate,"page":showPage},
        dataType:'JSON',
        success: function (data) {
            console.log(data);
            drawReportList(data);
        },
        error: function (error) {
            console.error(error);
        }
    });  
}


//처리 날짜 필터링 
var selectedSendDate;
document.getElementById('reportDatePickHandle').addEventListener('change', handleDateChange);

function handleDateChange() {
    // 변경된 날짜 값을 가져옴
    var selectedSendDate = document.getElementById('reportDatePickHandle').value;
    $.ajax({
        type: "get",
        url: "reportDatePickHandle", 
        data: {"selectedDate":selectedSendDate,"page":showPage},
        dataType:'JSON',
        success: function (data) {
            console.log(data);
            drawReportList(data);
        },
        error: function (error) {
            console.error(error);
        }
    });  
}


function reportListCall(page){	
	var ad_id = "${sessionScope.ad_id}";

	$.ajax({
		type:'get',
		url:'reportListCall',
		data:{'page':page,'ad_id':ad_id,'stateOption':$('#stateOption').val(),'typeOption':$('#typeOption').val()}, 
		dataType:'JSON',
		success: function(data){
			console.log(data)
			drawReportList(data);
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawReportList(reportList){
	console.log(reportList);
	var content='';
	var ad_id = "${sessionScope.ad_id}";
	
	reportList.list.forEach(function(item,idx){ 
		content+='<tr>';
		content+='<td style="text-align: center;"><a href="adReportDetail?report_num='+item.report_num+'">'+item.report_num+'</a></td>';
		var date = new Date(item.report_date);
		var dateStr = date.toLocaleDateString("ko-KR");
		var hisDate = new Date(item.rephis_date);
		var hisDateStr = hisDate.toLocaleDateString("ko-KR");
		content+='<td style="text-align: center;">'+dateStr+'</td>';
		content+='<td style="text-align: center;">'+item.user_id+'</td>';
		content+='<td style="text-align: center;">'+ad_id+'</td>';
		content+='<td style="text-align: center;">'
			if(hisDateStr=='Invalid Date'||item.rephis_date==null){
				content+='확인중';
			}else{
				content+=hisDateStr;
			}
		content+='</td>';
		content+='<td style="text-align: center;">' 
			if(item.report_state==0){
				content+='미완료';
			}else if(item.report_state==1){
				content+='처리중';
			}else{
				content+='완료';
			}
		content+='</td>';
		content+='<td style="text-align: center;">' 
			if(item.report_type==0){
				content+='게시글';
			}else if(item.report_type==1){
				content+='리뷰';
			}else if(item.report_type==2){
				content+='댓글';
			}else{
				content+='예약';
			}
		content+='</td>';
		content+='</tr>';
	});
	$('#reportList').empty();
	$('#reportList').append(content);
	
	$('#pagination').twbsPagination({
		startPage: reportList.currPage,
		totalPages: reportList.pages, 
		visiblePages:5, 
		onPageClick:function(e,page){ 
			if(showPage != page){ 
				console.log(page);	
				showPage=page; 
				reportListCall(page);
			}
		}
	});
}

</script>
</html>