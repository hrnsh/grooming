<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script>    
<script src="resources/js/jquery.twbsPagination.js" type="text/javascript"></script>
<style>
 .nav {
  	width:1200px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
}

.logo img {
    cursor: pointer;
}

.iconAll{
	width:100px;
    text-align: center;
}

div{text-align: center;}

.button {
    margin-top: 5px;
    padding: 5px 10px;
    font-size: 14px;
    background-color: rgb(163, 161, 161);
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

.button:hover {
    background-color: rgb(243, 208, 204);
}

body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
}

#revdetail {
    background-color: #fff;
    border: 1px solid #ddd;
    padding: 20px;
    margin-top: 20px;
    border-radius: 5px;
    display: none;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
}

table, th, td {
    border: 1px solid #ddd;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}

input[type="text"],
select,
textarea {
    width: 100%;
    padding: 8px;
    margin: 5px 0 15px 0;
    display: inline-block;
    border: 1px solid #ccc;
    box-sizing: border-box;
    border-radius: 4px;
}

input[type="button"],
input[type="submit"] {
    background-color: rgb(163, 161, 161);
    color: white;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
}

input[type="button"]:hover,
input[type="submit"]:hover {
    background-color: rgb(243, 208, 204);
}

textarea {
    resize: vertical;
}

	
</style>
</head>
<body>
	<h1>예약관리 - 회원</h1>>
	<nav class="nav">
		<div class="logo">
			<img onclick="location.href='./'" src="resources/img/logo.jpg" alt="logoImage" width="150" height="120"/>
		</div>	
		<div class="iconAll">
			<img src="resources/img/mapIcon.jpg" alt="mapIcon" width=100 height=100/>
			<button onclick="location.href='./locationSearch'" class="button">위치 탐색</button>
		</div>
		<div class="iconAll">
			<img src="resources/img/calendarIcon.jpg" alt="calendarIcon" width=100 height=100/>
			<button onclick="location.href='./revList'" class="button">예약 관리</button>
		</div>
		<div class="iconAll">
			<img src="resources/img/boardIcon.jpg" alt="boardIcon" width=100 height=100/>
			<button onclick="location.href='./boardMain'" class="button">게시판</button>
		</div>
		</nav>
	<div>
		 <select id="selDate">
			<option value="all">전체</option>
			<option value="today">오늘</option>
			<option value="week">1주일</option>
			<option value="month">30일</option>
			<option value="self">직접입력</option>
		</select> <input type="text" id="datepicker1" />-<input type="text"
			id="datepicker2" /> <input type="button" id="check" value="조회" />
	</div>
	<table>
		<thead>
			<tr>
				<th class="r_num">예약번호</th>
				<th class="user_id">업체ID</th>
				<th class="r_start">시작 날짜</th>
				<th class="r_end">종료 날짜</th>
				<th class="r_state">상태</th>
			</tr>
		</thead>
		<tbody id="reserveList">

		</tbody>
	</table>
	<select id="stateFilter">
		<option value="전체">전체</option>
		<option value="예약완료">예약완료</option>
		<option value="이용중">이용중</option>
		<option value="이용완료">이용완료</option>
		<option value="취소">취소</option>
	</select>
	<div id="paging">	
				<!-- 	플러그인 사용	(twbsPagination)	- 이렇게 사용하라고 tutorial 에서 제공-->
				<div class="container">									
					<nav aria-label="Page navigation" style="text-align:center">
						<ul class="pagination" id="pagination"></ul>
					</nav>					
				</div>
			</div>
</body>
<script>
//로그인 여부에 따른 페이지 권한 설정
var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("로그인이 필요합니다. 로그인 후 이 페이지를 이용하실 수 있습니다.");
    location.href = "./"; 
}

// 예약리스트 호출
var showPage=1;
reserveListCall(showPage);

function reserveListCall(page){	
	var loginId = "${sessionScope.loginId}";
	$.ajax({
		type:'get',
		url:'reserveList',
		data:{'loginId':loginId,'page':page}, 
		dataType:'JSON',
		success: function(data){
			console.log("초기 리스트"+data)
			drawReserveList(data);	
		},
		error:function(e){
			console.log(e)
		}
	});
}

function drawReserveList(reserveList){
	console.log(reserveList);
	$('#reserveList').empty();
	var content='';
	reserveList.revComList.forEach(function(item, idx){ 
		content+='<tr>';
		content+='<td><a href="reserveDetail?idx='+item.r_num+'">'+item.r_num+'</a></td>';
		content+='<td>'+item.com_id+'</td>';
		content+='<td>'+item.r_start+'</td>';
		content+='<td>'+item.r_end+'</td>';
		content+='<td>'+item.r_state+'</td>';	
		content+='</tr>';
	});
	$('#reserveList').append(content);
	$('#pagination').twbsPagination({
		startPage:reserveList.currPage, // 보여줄 페이지
		totalPages:reserveList.pages,// 총 페이지 수(총갯수/페이지당보여줄게시물수) : 서버에서 계산해서 가져와야함
		visiblePages:5,//[1][2][3][4][5]
		onPageClick:function(e,page){ // 번호 클릭시 실행할 내용
			//console.log(e);
			if(showPage != page){
				console.log(page);
				showPage = page; // 클릭해서 다른 페이지를 보여주게 되면 현재 보고 있는 페이지 번호도 변경해 준다.
				reserveListCall(page);
			}
		}
	});
}
	
	
$(function() {
    // 첫 번째 datepicker 초기화
    $("#datepicker1").datepicker();

    // 두 번째 datepicker 초기화
    $("#datepicker2").datepicker();

    var selectedDate;
    var reservedDates = ["2023-11-10", "2023-11-15", "2023-11-20"]; // 예약된 날짜 배열
    var enableDays = 90;

    $("#datepicker1, #datepicker2").datepicker({
        beforeShowDay: function(date) {
            var dateString = $.datepicker.formatDate("yy-mm-dd", date);
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            var maxDate = new Date(today.getTime() + enableDays * 24 * 60 * 60 * 1000);

            if (date < today || date > maxDate) {
                // 오늘 이전이거나 90일 이후인 경우 선택 불가능하게 만듦
                return [false, "", "선택불가능"];
            }

            if ($.inArray(dateString, reservedDates) !== -1) {
                // 예약된 날짜일 경우 표시
                return [false, "reserved-date", "예약됨"];
            }

            // 나머지 날짜는 선택 가능
            return [true, "", ""];
        },
        onSelect: function(dateText, inst) {
            console.log("날짜가 선택되었습니다: " + dateText);
            // 여기에 선택된 날짜에 대한 추가적인 처리 로직을 추가할 수 있습니다.
            selectedDate = $(this).datepicker("getDate");
        }
    });
});
// 선택한 날짜 controller에 전송
$(function() {
    // 버튼 클릭 이벤트 핸들러
    $("#check").click(function() {
        // 선택된 날짜 가져오기
        var selectedDate1 = $("#datepicker1").val();
        var selectedDate2 = $("#datepicker2").val();
      
        
        // AJAX 요청 보내기
        $.ajax({
            type:'get',  // 또는 "GET" 등 요청 메서드 선택
            url:'check',  // 컨트롤러 엔드포인트 URL 입력
            data: {
                'date1': selectedDate1,
                'date2': selectedDate2            
            },  // 전송할 데이터 설정
            dataType: 'json',
            success: function(data) {
                // 성공적으로 응답을 받았을 때 처리할 코드
                console.log("서버 응답: " + JSON.stringify(data));
                drawReserveComList(data);
            },
            error:function(e){
            	console.log(e)
            }
         });
    })
});

// '상태' 필터링
$(function() {
    // 버튼 클릭 이벤트 핸들러
    $('#stateFilter').change(function(){
    		console.log($(this).val());
    		
        // AJAX 요청 보내기
        $.ajax({
            type:'get',  // 또는 "GET" 등 요청 메서드 선택
            url:'state',  // 컨트롤러 엔드포인트 URL 입력
            data: {'stateFilter':$('#stateFilter').val()},  // 전송할 데이터 설정
            dataType: 'json',
            success: function(data) {
                // 성공적으로 응답을 받았을 때 처리할 코드
                console.log("서버 응답: " + JSON.stringify(data));
                drawReserveList(data);
            },
            error:function(e){
            	console.log(e)
            }
         });
    })
});

// 기간 필터링
$(document).ready(function() {
    // 드롭다운 메뉴에서 선택된 값이 바뀔 때 호출되는 이벤트 핸들러
    $("#selDate").change(function() {
        // 선택된 드롭다운 메뉴의 값 가져오기
        var selectedValue = $(this).val();

        // 선택된 값에 따라 처리
        if (selectedValue === "today") {
            // 오늘 날짜 설정
            var today = new Date();
            var formattedDate = formatDate(today);
            $("#datepicker1").val(formattedDate).prop("disabled", true);
            $("#datepicker2").val(formattedDate).prop("disabled", true);
        } else if (selectedValue === "week") {
            // 1주일 전부터 오늘까지의 날짜 설정
            var today = new Date();
            var weekAgo = new Date();
            weekAgo.setDate(today.getDate() - 7);
            var formattedWeekAgo = formatDate(weekAgo);
            var formattedToday = formatDate(today);
            $("#datepicker1").val(formattedWeekAgo).prop("disabled", true);
            $("#datepicker2").val(formattedToday).prop("disabled", true);
        } else if (selectedValue === "month") {
            // 30일 전부터 오늘까지의 날짜 설정
            var today = new Date();
            var monthAgo = new Date();
            monthAgo.setDate(today.getDate() - 30);
            var formattedMonthAgo = formatDate(monthAgo);
            var formattedToday = formatDate(today);
            $("#datepicker1").val(formattedMonthAgo).prop("disabled", true);
            $("#datepicker2").val(formattedToday).prop("disabled", true);
        } else if (selectedValue === "self") {
            // 직접 입력 선택 시 input 박스 활성화
            $("#datepicker1").val('').prop("disabled", false);
            $("#datepicker2").val('').prop("disabled", false);
        } else if (selectedValue === "all") {
            // 전체 선택 시 input 박스 비활성화
            $("#datepicker1").val('').prop("disabled", true);
            $("#datepicker2").val('').prop("disabled", true);
        }
    });

    // 날짜를 MM/dd/yyyy 형식으로 변환하는 함수
    function formatDate(date) {
        var month = String(date.getMonth() + 1).padStart(2, '0');
        var day = String(date.getDate()).padStart(2, '0');
        var year = date.getFullYear();
        return month + '/' + day + '/' + year;
    }
});


</script>
</html>