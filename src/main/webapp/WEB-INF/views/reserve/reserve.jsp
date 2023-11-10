<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<!DOCTYPE html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Datepicker 예약된 날짜 표시</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <style>
    .reserved-date  {
      background-color: red ; /* 예약된 날짜의 배경색을 빨간색으로 설정 */
    }
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
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f7f33f996b442a5d86588bc9173489c3&libraries=services"
        type="text/javascript"></script>
<script>

$(function() {
	
    // 첫 번째 datepicker 초기화
    $("#datepicker1").datepicker();

    // 두 번째 datepicker 초기화
    $("#datepicker2").datepicker();
});
	var selectedDate;
$(function() {
	$("#datepicker").click(function(){
		$.ajax({
            type: "POST",  // 또는 "GET" 등 요청 메서드 선택
            url: "findRev",  // 컨트롤러 엔드포인트 URL 입력
            data: {},  // 전송할 데이터 설정
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                // 성공적으로 응답을 받았을 때 처리할 코드
                console.log("서버 응답: " + JSON.stringify(response));
           
            },
            error: function(error) {
             
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });

		});
    var reservedDates = ["2023-11-10", "2023-11-15", "2023-11-20"]; // 예약된 날짜 배열
    var enableDays = 90;
    
    $("#datepicker").datepicker({
    	
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
            $("#revdetail").show();
            console.log("날짜가 선택되었습니다: " + dateText);
            $("#datepicker1").val(dateText);
            $("#datepicker2").val(dateText);
            // 여기에 선택된 날짜에 대한 추가적인 처리 로직을 추가할 수 있습니다.
            selectedDate = $("#datepicker").datepicker("getDate");
        }
    });

    // Apm 버튼 클릭 시 다음 날짜를 입력하도록 처리
    $("#Apm").click(function() {
        var selectedDate = $("#datepicker").datepicker("getDate");
        if (selectedDate !== null) {
            selectedDate.setDate(selectedDate.getDate() + 1);
            $("#datepicker2").datepicker("setDate", selectedDate);
        }      	      
    });
 
    // 이용권 선택 버튼 클릭 시 클래스 추가
    $("#Am, #Pm").click(function() {
        if (selectedDate !== null) {
            // 선택된 날짜가 있다면 해당 날짜로 설정
            $("#datepicker2").datepicker("setDate", selectedDate);
        }
    });

    // 이용권 선택
    $("#Am").click(function() {
        // 원하는 드롭박스 옵션 값으로 변경
        $("#s_ticket").val("amOption"); // 시작 시간을 09:00으로 설정
        $("#e_ticket").val("amOption"); // 종료 시간을 09:00으로 설정
    });
    $("#Pm").click(function() {
        // 원하는 드롭박스 옵션 값으로 변경
        $("#s_ticket").val("pmOption"); // 시작 시간을 14:00으로 설정
        $("#e_ticket").val("pmOption"); // 종료 시간을 14:00으로 설정
    });
    $("#Apm").click(function() {
        // 원하는 드롭박스 옵션 값으로 변경
        $("#s_ticket").val("amOption"); // 시작 시간을 09:00으로 설정
        $("#e_ticket").val("pmOption"); // 종료 시간을 14:00으로 설정
    });
});

// 이용권 val값
var ticket;
$(document).ready(function() {
    // 버튼 클릭 이벤트 핸들러
    $("#Am,#Pm,#Apm").click(function() {
        // 버튼의 value 값을 가져오기
        var buttonValue = $(this).val();
        
        // AJAX 요청 보내기
        $.ajax({
            type: "POST",  // 또는 "GET" 등 요청 메서드 선택
            url: "tPrice",  // 컨트롤러 엔드포인트 URL 입력
            data: JSON.stringify({ "buttonValue": buttonValue }),  // 전송할 데이터 설정
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                // 성공적으로 응답을 받았을 때 처리할 코드
                console.log("서버 응답: " + response);
                console.log("이용권 가격:"+ response.ticket);
             // 이용권 가격을 표시할 <p> 태그에 동적으로 내용을 넣기
           ticket = response.ticket;
                $("p#ticketPrice").text("이용권 금액 : " + response.ticket);
            },
            error: function(error) {
                // 요청이 실패했을 때 처리할 코드
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });
    });
});

//주소API id="addr_kakao"
function showMap(){
document.getElementById("addr_kakao").addEventListener("click", function(){ //주소입력칸을 클릭하면
    //카카오 지도 발생
    new daum.Postcode({
        oncomplete: function(data) { //선택시 입력값 세팅
            document.getElementById("addr_kakao").value = data.address; // 주소 넣기              
            console.log('도로명주소 : ' + data.roadAddress);
            document.querySelector("input[name=addr_detail]").focus(); //상세입력 포커싱
            //위도,경도 찾기
            const geocoder = new kakao.maps.services.Geocoder();
        geocoder.addressSearch(data.roadAddress, (result, status) => {
          if (status === kakao.maps.services.Status.OK) {
        	  var latitude = result[0].y;
              var longitude = result[0].x;
            console.log('위도 : ' +latitude);
            console.log('경도 : ' +longitude);
            sendDataToServer(latitude, longitude); // 서버로 데이터 전송
          }
        });                     
        }
    }).open();
});
}

var pick;
function sendDataToServer(latitude, longitude) {
    var data = {
        latitude: latitude,
        longitude: longitude
    };

    $.ajax({
        type: "post",
        url: "revDis", // Controller에서 데이터를 받을 엔드포인트 URL
        data: JSON.stringify(data),
        contentType: "application/json",
        dataType: "json",
        success: function(response) {
            console.log("데이터 전송 성공: " + JSON.stringify(response));
            console.log("두 지점 거리"+response.distance);
            if(response.distance>10){
            	alert("픽업이 불가능한 거리 입니다.");
            }else{
            	pick=response.pick;
            	$("p#ticketPrice").append("+픽업 가격 :"+response.pick);
            	if(ticket!=null){
            	$("p#ticketPrice").append("=총 이용금액 :"+(ticket+pick));
            	}else{
            		$("p#ticketPrice").append("=총 이용금액 :"+(allTicket+pick));
            	}
            }
        },
        error: function() {
            console.error();
        }
    });
}
//픽업여부에 따른 주소 입력창
$(document).ready(function() {
    // 페이지 로드 시 초기 상태 설정
    addrShow();
});

function addrShow() {
    var valueCheck = $('input[name=pick]:checked').val(); 
    console.log(valueCheck);
    if (valueCheck == "예") {
        $(".radio-value-detail").prop('disabled', false);
    } else {
        $(".radio-value-detail").prop('disabled', true);
    }
}

// 라디오 버튼의 변경 이벤트에 addrShow() 함수 연결
$('input[name=pick]').change(function() {
    addrShow();
});
var allTicket;
// datepicker1,2 값 전달
$(function() {
    // 버튼 클릭 이벤트 핸들러
    $("#selPrice").click(function() {
        // 선택된 날짜 가져오기
        var selectedDate1 = $("#datepicker1").val();
        var selectedDate2 = $("#datepicker2").val();
        var selectedTime1 = $("#s_ticket").val();
        var selectedTime2 = $("#e_ticket").val();
        
        // AJAX 요청 보내기
        $.ajax({
            type: "POST",  // 또는 "GET" 등 요청 메서드 선택
            url: "selPrice",  // 컨트롤러 엔드포인트 URL 입력
            data: {
                date1: selectedDate1,
                date2: selectedDate2,
                time1: selectedTime1,
                time2: selectedTime2
            },  // 전송할 데이터 설정
            success: function(response) {
                // 성공적으로 응답을 받았을 때 처리할 코드
                console.log("서버 응답: " + response);
                allTicket =(response.dayTicket+response.timeTicket);
                $("p#ticketPrice").text("이용권 금액 : " +allTicket );
            },
            error: function(error) {
                // 요청이 실패했을 때 처리할 코드
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });
    });
});


  </script>
</head>
<body>
	<label for="datepicker">날짜 선택:</label>
  <input type="text" id="datepicker" class="dtp">
  
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
						<option value="amOption">09:00</option>
						<option value="pmOption">14:00</option>
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
						<option value="apmOption">09:00</option>
						<option value="amOption">13:00</option>
						<option value="pmOption">18:00</option>
					</select>	
					<input type="button" id="selPrice" value="이용권 금액 계산"/>	
				</th>
			</tr>
				<tr>
					<th>반려 동물</th>
					<th>
					<select id="dropdownMenu">
							<c:forEach var="option" items="${aNameList}">
								<option value="${option}">${option}</option>
							</c:forEach>
					</select></th>
				</tr>
				<tr>
					<th>요청사항</th>
					<th><textarea style="resize: none"></textarea></th>
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
				<p id="ticketPrice">이용권 금액 :</p>
				</th>
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