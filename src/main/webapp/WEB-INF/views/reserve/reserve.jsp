<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reserve</title>
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <!-- //fullcalendar css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<!-- //fullcalendar 언어 설정관련 script -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	#calendar{
		height:1000px;
		width:1000px;
		
	}
	
	#revdetail{
		height:500px;
		width:500px;
		margin: 30px;
		top:100px;
		float:right;
		background-color:pink;
		display:none;
	}
	
	table,th,td{
		border:1px solid black;
		border-collapse: collapse;
		padding:5px 10px;
	}
	
	th,td{
		font-size: 30px;
	}
</style>
<script>

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
		headerToolbar : { // 헤더에 표시할 툴 바
			start : 'prev next today',
			center : 'title',
			end : 'dayGridMonth,dayGridWeek,dayGridDay'
		},
		titleFormat : function(date) {
			return date.date.year + '년 ' + (parseInt(date.date.month) + 1) + '월';
		},
		//initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
		selectable : true, // 달력 일자 드래그 설정가능
		droppable : true,
		editable : true,
		nowIndicator: true, // 현재 시간 마크
		locale: 'ko', // 한국어 설정
	
		// date click
		dateClick: function() {
			$("#revdetail").show();
			  }
	});
	calendar.render();
});

//픽업여부에 따른 주소 입력창
function addrShow() {
    var valueCheck = $('input[name=pick]:checked').val(); 
    console.log(valueCheck);
    if ( valueCheck == "예" ) {
        $(".radio-value-detail").attr('disabled', false); 
    } else {
        $(".radio-value-detail").attr('disabled', true); 
    }
};

//주소API id="addr_kakao"
function showMap(){
document.getElementById("addr_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
    //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            document.getElementById("addr_kakao").value = data.address; // 주소 넣기
            document.querySelector("input[name=addr_detail]").focus(); //상세입력 포커싱
        }
    }).open();
});
}
	
	var animal = "${animal.com_id}";
	console.log(animal);

</script>
</head>
<body>
	<form action="events"><input type="submit" value="예약정보"> </form>

	<div id="calendar"></div>
	
	<div id="revdetail">
    <form action="booking" method="post" display="none">
    <a href="">업체명</a><br>   
    &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="Am" value="오전권" />&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" id="Pm" value="오후권" />&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" id="Apm" value="종일권" />
    <table>
			<tr>
				<th>예약 시작 시간</th>
				<th>
					<input type="text" id="datepicker1"  name="startRe" />
				</th>
				<th>
					<select name="s_ticket" id="s_ticket">
						<option value="9">09:00</option>
						<option value="14">14:00</option>
					</select>		
				</th>
			</tr>
			<tr>
				<th>예약 종료 시간</th>
				<td>
					<input type="text" id="datepicker2" name="endRe" />				
				</td>
				<th>
					<select name="e_ticket" id="e_ticket">
						<option value="9">09:00</option>
						<option value="13">13:00</option>
						<option value="18">18:00</option>
					</select>		
				</th>
			</tr>
			<tr>
			<tr>
				<th>반려 동물</th>
				<th>
					<select name="myAni" id="myAni">
						<option>망고</option>
						<option>보리</option>
						<option>호둘이</option>
					</select>
				</th>
			</tr>
			<tr>
				<th>요청사항</th>
				<th><textarea style="resize:none"></textarea></th>
			</tr>
			<tr>
				<th>픽업 서비스</th>
				<th><input type="radio"  name="pick" value="예" onchange="addrShow()" />예 <input
					type="radio" name="pick" value="아니오" checked  onchange="addrShow()"/>아니오</th>
			</tr>	
			<tr>
				<th>주소</th>
				<th><input type="text" onclick="showMap()" class="radio-value-detail" id="addr_kakao" name="addr" readonly></th>
			</tr>
			<tr>
				<th></th>
				<th><input type="text" class="radio-value-detail" name="addr_detail" placeholder="상세주소를 입력해 주세요."></th>
			</tr>		
			<tr>
				<th colspan="2">
				<input type="submit"  value="예약" />
				</th>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>