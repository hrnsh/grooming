<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>reserve</title>
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
  <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
  <script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<style>
	div{
		margin: 0 auto;
		float:right;
		background-color:pink;
		display:none;
	}
	
td {
            width: 50px;
            height: 50px;
        }

        .Calendar { 
            text-align: center;
            margin: 0 auto; 
            float: left;
        }

        .Calendar>thead>tr:first-child>td { font-weight: bold; }

        .Calendar>thead>tr:last-child>td {
            background-color: gray;
            color: white;
        }        

        .pastDay{ background-color: lightgray; }

        .today{            
            background-color: #FFCA64;            
            cursor: pointer;
        }

        .futureDay{            
            background-color: #FFFFFF;
            cursor: pointer;
        }

        .futureDay.choiceDay, .today.choiceDay{            
            background-color: #3E85EF;            
            color: #fff;
            cursor: pointer;
        }
</style>
<script>
window.onload = function () { buildCalendar(); }    // 웹 페이지가 로드되면 buildCalendar 실행

let nowMonth = new Date();  // 현재 달을 페이지를 로드한 날의 달로 초기화
let today = new Date();     // 페이지를 로드한 날짜를 저장
today.setHours(0,0,0,0);    // 비교 편의를 위해 today의 시간을 초기화

// 달력 생성 : 해당 달에 맞춰 테이블을 만들고, 날짜를 채워 넣는다.
function buildCalendar() {

    let firstDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth(), 1);     // 이번달 1일
    let lastDate = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, 0);  // 이번달 마지막날

    let tbody_Calendar = document.querySelector(".Calendar > tbody");
    document.getElementById("calYear").innerText = nowMonth.getFullYear();             // 연도 숫자 갱신
    document.getElementById("calMonth").innerText = leftPad(nowMonth.getMonth() + 1);  // 월 숫자 갱신

    while (tbody_Calendar.rows.length > 0) {                        // 이전 출력결과가 남아있는 경우 초기화
        tbody_Calendar.deleteRow(tbody_Calendar.rows.length - 1);
    }

    let nowRow = tbody_Calendar.insertRow();        // 첫번째 행 추가           

    for (let j = 0; j < firstDate.getDay(); j++) {  // 이번달 1일의 요일만큼
        let nowColumn = nowRow.insertCell();        // 열 추가
    }

    for (let nowDay = firstDate; nowDay <= lastDate; nowDay.setDate(nowDay.getDate() + 1)) {   // day는 날짜를 저장하는 변수, 이번달 마지막날까지 증가시키며 반복  

        let nowColumn = nowRow.insertCell();        // 새 열을 추가하고
        nowColumn.innerText = leftPad(nowDay.getDate());      // 추가한 열에 날짜 입력

    
        if (nowDay.getDay() == 0) {                 // 일요일인 경우 글자색 빨강으로
            nowColumn.style.color = "#DC143C";
        }
        if (nowDay.getDay() == 6) {                 // 토요일인 경우 글자색 파랑으로 하고
            nowColumn.style.color = "#0000CD";
            nowRow = tbody_Calendar.insertRow();    // 새로운 행 추가
        }


        if (nowDay < today) {                       // 지난날인 경우
            nowColumn.className = "pastDay";
        }
        else if (nowDay.getFullYear() == today.getFullYear() && nowDay.getMonth() == today.getMonth() && nowDay.getDate() == today.getDate()) { // 오늘인 경우           
            nowColumn.className = "today";
            nowColumn.onclick = function () { choiceDate(this); }
        }
        else {                                      // 미래인 경우
            nowColumn.className = "futureDay";
            nowColumn.onclick = function () { choiceDate(this); }
        }
    }
}
var pickDay;
// 날짜 선택
function choiceDate(nowColumn) {
    if (document.getElementsByClassName("choiceDay")[0]) {                              // 기존에 선택한 날짜가 있으면
        document.getElementsByClassName("choiceDay")[0].classList.remove("choiceDay");  // 해당 날짜의 "choiceDay" class 제거
    }
    nowColumn.classList.add("choiceDay");           // 선택된 날짜에 "choiceDay" class 추가
   console.log(nowColumn);
   pickDay = document.getElementsByClassName("futureDay choiceDay")[0]
	console.log(pickDay.innerText);
   $("#revdetail").show();
}
// 이전달 버튼 클릭
function prevCalendar() {
    nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() - 1, nowMonth.getDate());   // 현재 달을 1 감소
    buildCalendar();    // 달력 다시 생성
}
// 다음달 버튼 클릭
function nextCalendar() {
    nowMonth = new Date(nowMonth.getFullYear(), nowMonth.getMonth() + 1, nowMonth.getDate());   // 현재 달을 1 증가
    buildCalendar();    // 달력 다시 생성
}

// input값이 한자리 숫자인 경우 앞에 '0' 붙혀주는 함수
function leftPad(value) {
    if (value < 10) {
        value = "0" + value;
        return value;
    }
    return value;
	}

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

//예약일 직접설정
$(function() {
    $("#datepicker1,#datepicker2").datepicker({
    	dateFormat:'yy.mm.dd',
    	selectOtherMonths:true,
    	showMonthAfterYear:true,
    	changeYear:true,
    	changeMonth:true,
    	numberOfMonths:1,
		minDate:-0,
		maxDate:"+90D"
    });
});

// 주소API id="addr_kakao"
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

</script>
</head>
<body>
	<table class="Calendar">
        <thead>
            <tr>
                <td onClick="prevCalendar();" style="cursor:pointer;">&#60;</td>
                <td colspan="5">
                    <span id="calYear"></span>년
                    <span id="calMonth"></span>월
                </td>
                <td onClick="nextCalendar();" style="cursor:pointer;">&#62;</td>
            </tr>
            <tr>
                <td>일</td>
                <td>월</td>
                <td>화</td>
                <td>수</td>
                <td>목</td>
                <td>금</td>
                <td>토</td>
            </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
    
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</html>