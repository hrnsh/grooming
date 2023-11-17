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
            display:none;
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

        input[type="text"], select, textarea {
            width: 100%;
            padding: 8px;
            margin: 5px 0 15px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            border-radius: 4px;
        }

        input[type="button"], input[type="submit"] {
            background-color: rgb(163, 161, 161);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="button"]:hover, input[type="submit"]:hover {
            background-color: rgb(243, 208, 204);
        }

        textarea {
            resize: vertical;
        }

    .ui-datepicker-unselectable.ui-state-disabled[title="reserved"] {
        background-color: red !important;
        color: white !important;
        border: 1px solid red !important;
    }
    </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f7f33f996b442a5d86588bc9173489c3&libraries=services"
        type="text/javascript"></script>
<script>

var loginId="${sessionScope.loginId}";
if (!loginId) {
    alert("페이지에 권한이 없습니다.");
    location.href = "./"; 
}

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
            	 var findRevArray = Array.isArray(response.findRev) ? response.findRev : [response.findRev];
                 var accept = response.findAcc;              
            	 var enableDays = 90;
            	 console.log("예약건"+findRevArray);
            	console.log("수용"+accept);
   			 $("#datepicker").datepicker({  	
     			 beforeShowDay: function(date) {
     				 console.log("비활성화");
       			 var dateString = $.datepicker.formatDate("yy-mm-dd", date);
       			 var today = new Date();
       			 today.setHours(0, 0, 0, 0);
        		var maxDate = new Date(today.getTime() + enableDays * 24 * 60 * 60 * 1000);
        
       			 if (date <= today || date > maxDate) {
           			 // 오늘 이전이거나 90일 이후인 경우 선택 불가능하게 만듦
            	return [false, "", "선택불가능"];
         		 }			
       			// reservedDates 배열에서 해당 날짜의 예약 건수 가져오기
                 var reservationCount = getReservationCount(dateString, findRevArray);
                console.log("뭐라고말좀해봐"+reservationCount); 
       			if (reservationCount >= accept) {
                     // 예약 건수가 accept개 이상인 경우 선택 불가능하게 만듦
                     return [false, "", "reserved"];
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
           selectedDate = dateText;
           console.log("선택날짜: " + selectedDate);
        }
    });
            },
            error: function(error) {
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });
    });
});



// picker1
$(function() {
	$("#datepicker1").click(function(){
		$.ajax({
            type: "POST",  // 또는 "GET" 등 요청 메서드 선택
            url: "findRev",  // 컨트롤러 엔드포인트 URL 입력
            data: {},  // 전송할 데이터 설정
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
            	 var findRevArray = Array.isArray(response.findRev) ? response.findRev : [response.findRev];
                 var accept = response.findAcc;              
            	 var enableDays = 90;
            	 
            	console.log("수용"+accept);
   			 $("#datepicker1").datepicker({  	
     			 beforeShowDay: function(date) {
       			 var dateString = $.datepicker.formatDate("yy-mm-dd", date);
       			 var today = new Date();
       			 today.setHours(0, 0, 0, 0);
        		var maxDate = new Date(today.getTime() + enableDays * 24 * 60 * 60 * 1000);
        
       			 if (date <= today || date > maxDate) {
           			 // 오늘 이전이거나 90일 이후인 경우 선택 불가능하게 만듦
            	return [false, "", "선택불가능"];
         		 }
				
       			// reservedDates 배열에서 해당 날짜의 예약 건수 가져오기
                 var reservationCount = getReservationCount(dateString, findRevArray);
                console.log("뭐라고말좀해봐"+reservationCount); 
       			if (reservationCount >= accept) {
                     // 예약 건수가 accept개 이상인 경우 선택 불가능하게 만듦
                     return [false, "", "reserved"];
                 }

         		 // 나머지 날짜는 선택 가능
        		  return [true, "", ""];
        },
        onSelect: function(dateText, inst) {
            $("#revdetail").show();
            console.log("날짜가 선택되었습니다: " + dateText);
            $("#datepicker1").val(dateText);
            // 여기에 선택된 날짜에 대한 추가적인 처리 로직을 추가할 수 있습니다.
           selectedDate = dateText;
           console.log("선택날짜: " + selectedDate);
        }
    });
            },
            error: function(error) {
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });
    });
});

$(function() {
	$("#datepicker2").click(function(){
		$.ajax({
            type: "POST",  // 또는 "GET" 등 요청 메서드 선택
            url: "findRev",  // 컨트롤러 엔드포인트 URL 입력
            data: {},  // 전송할 데이터 설정
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
            	 var findRevArray = Array.isArray(response.findRev) ? response.findRev : [response.findRev];
                 var accept = response.findAcc;              
            	 var enableDays = 90;
            	 
            	console.log("수용"+accept);
   			 $("#datepicker2").datepicker({  	
     			 beforeShowDay: function(date) {
       			 var dateString = $.datepicker.formatDate("yy-mm-dd", date);
       			 var today = new Date();
       			 today.setHours(0, 0, 0, 0);
        		var maxDate = new Date(today.getTime() + enableDays * 24 * 60 * 60 * 1000);
        
       			 if (date <= today || date > maxDate) {
           			 // 오늘 이전이거나 90일 이후인 경우 선택 불가능하게 만듦
            	return [false, "", "선택불가능"];
         		 }
				
       			// reservedDates 배열에서 해당 날짜의 예약 건수 가져오기
                 var reservationCount = getReservationCount(dateString, findRevArray);
                console.log("뭐라고말좀해봐"+reservationCount); 
       			if (reservationCount >= accept) {
                     // 예약 건수가 accept개 이상인 경우 선택 불가능하게 만듦
                     return [false, "", "reserved"];
                 }

         		 // 나머지 날짜는 선택 가능
        		  return [true, "", ""];
        },
        onSelect: function(dateText, inst) {
            $("#revdetail").show();
            console.log("날짜가 선택되었습니다: " + dateText);
            $("#datepicker2").val(dateText);
            // 여기에 선택된 날짜에 대한 추가적인 처리 로직을 추가할 수 있습니다.
           selectedDate = dateText;
           console.log("선택날짜: " + selectedDate);
        }
    });
            },
            error: function(error) {
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });
    });
});

function getReservationCount(dateString, findRevArray) {
    console.log("dateString:", dateString);
    console.log("findRevArray:", findRevArray);

    var count = 0;
    var selectedDate = new Date(dateString);

    for (var i = 0; i < findRevArray.length; i++) {
        console.log("findRevArray[i].formatted_date:", findRevArray[i].formatted_date);
        var formattedDate = new Date(findRevArray[i].formatted_date);

        // 날짜가 일치하는 경우에만 count 증가
        if (formattedDate.toDateString() === selectedDate.toDateString()) {
            count += findRevArray[i].reservation_count;
        }
    }

    console.log("count:", count);
    return count;
}


/* function getReservationCount(date, reservedDates) {
    for (var i = 0; i < reservedDates.length; i++) {
        if (date === reservedDates[i].formatted_date) {
            return reservedDates[i].reservation_count;
        }
    }
    return 0; // 예약 데이터가 없을 경우 0을 반환
}
 */
// 이용권종류 버튼 이벤트
/* var ticket;

$(document).ready(function() {
    // 버튼 클릭 이벤트 핸들러
    $("#Am, #Pm, #Apm").click(function() {
        // 버튼의 value 값을 가져오기
        var buttonValue = $(this).val();
        
        // AJAX 요청 보내기
        $.ajax({
            type: "POST",  
            url: "tPrice",  
            data: JSON.stringify({ "buttonValue": buttonValue }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                console.log("서버 응답: " + response);
                console.log("이용권 가격:" + response.ticket);
                // 이용권 가격을 표시할 <p> 태그에 동적으로 내용을 넣기
                ticket = response.ticket;
                $("p#ticketPrice").text("이용권 금액 : " + response.ticket);
                
                // 여기서 추가적인 처리 로직을 수행할 수 있습니다.
                // 예를 들면, 이용권에 따른 특별한 동작을 수행하는 등
            },
            error: function(error) {
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });
    });


    // Apm 버튼 클릭 시 다음 날짜를 입력하도록 처리
    $("#Apm").click(function() {
        // #datepicker2에 설정된 날짜 가져오기
        var currentDate = $("#datepicker2").datepicker("getDate");
        // 내일로 설정
        if (currentDate !== null) {
            currentDate.setDate(currentDate.getDate() + 1);
            $("#datepicker2").datepicker("setDate", currentDate);
        }
    });

    // 이용권 선택 버튼 클릭 시 클래스 추가
    $("#Am, #Pm").click(function() {
        if (selectedDate !== null) {
            $("#datepicker2").datepicker("setDate", selectedDate);
        }
    });

    // 이용권 선택
    $("#Am").click(function() {
        $("#s_ticket").val("amOption");
        $("#e_ticket").val("amOption");
    });
    $("#Pm").click(function() {
        $("#s_ticket").val("pmOption");
        $("#e_ticket").val("pmOption");
    });
    $("#Apm").click(function() {
        $("#s_ticket").val("amOption");
        $("#e_ticket").val("apmOption");
    });
});
 */
    	

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
            	$("p#ticketPrice").append("+픽업 가격 :"+response.pick+"=총 이용금액 :"+(allTicket+pick));    
            	$("#tp").val(allTicket+pick);         	
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
    var valueCheck = $('input[name=r_pick]:checked').val(); 
    console.log(valueCheck);
    if (valueCheck == "예") {
        var findPick = "${findPick}";
        // '아니오'인 경우에만 처리
        if (findPick === '아니오') {
            alert('픽업 서비스를 지원하지 않는 업체입니다.');
            $('input[name=r_pick][value="아니오"]').prop('checked', true);
          }else{
        $(".radio-value-detail").prop('disabled', false);
          }
    } else {
        $(".radio-value-detail").prop('disabled', true);
    }
}

// 라디오 버튼의 변경 이벤트에 addrShow() 함수 연결
$('input[name=r_pick]').change(function() {
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
        
        // AJAX 요청 보내기
        $.ajax({
            type: "POST",  // 또는 "GET" 등 요청 메서드 선택
            url: "selPrice",  // 컨트롤러 엔드포인트 URL 입력
            data: {
                "date1": selectedDate1,
                "date2": selectedDate2,
            },  // 전송할 데이터 설정
            success: function(response) {
                // 성공적으로 응답을 받았을 때 처리할 코드
                console.log("서버 응답: " + response);
                allTicket =(response.dayTicket);
                $("p#ticketPrice").text("이용권 금액 : " +allTicket );
                $("#tp").val(allTicket);
            },
            error: function(error) {
                // 요청이 실패했을 때 처리할 코드
                console.error("에러 발생: " + JSON.stringify(error));
            }
        });
    });
});

//뒤로가기
var companyName="${companyName}";
function goBack() {
            window.history.back();
        }
//뒤로 간 페이지에서 실행할 함수
function showCompanyDetail(companyName) {
	console.log('회사 상세 정보 표시: ' + companyName);
}
window.addEventListener('popstate', function (event) {
    // 뒤로 간 페이지에서 실행할 함수 호출
    showCompanyDetail(event.state && event.state.companyName);
});

  </script>
</head>
<body>
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
	<label for="datepicker">날짜 선택:</label>
  <input type="text" id="datepicker" class="dtp">
  
  <div id="revdetail">
    <form action="booking" method="post">
    <a href="#" onclick="goBack()">${companyName}</a><br>   
    <!-- &nbsp;&nbsp;&nbsp;&nbsp;<input type="button" id="Am" value="오전권" />&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" id="Pm" value="오후권" />&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="button" id="Apm" value="종일권" /> -->
	<input type="hidden" id="com_id" name="com_id" value="${com_id}" />
    <table>
			<tr>
				<th>예약 시작 시간</th>
				<th>
					<input type="text" id="datepicker1"  name="startRe" />
				</th>
				<!-- <th>
					<select name="s_ticket" id="s_ticket">
						<option value="amOption">09:00</option>
						<option value="pmOption">14:00</option>
					</select>		
				</th> -->
			</tr>
			<tr>
				<th>예약 종료 시간</th>
				<td>
					<input type="text" id="datepicker2" name="endRe" />				
				</td>
				<!-- <th>
					<select name="e_ticket" id="e_ticket">
						<option value="apmOption">09:00</option>
						<option value="amOption">13:00</option>
						<option value="pmOption">18:00</option>
					</select>	
				</th> -->
			</tr>
				<tr>
					<th>반려 동물</th>
					<th>
					<select id="dropdownMenu" name="ani">
							<c:forEach var="option" items="${aNameList}">
								<option value="${option}">${option}</option>
							</c:forEach>
					</select></th>
				</tr>
				<tr>
					<th>요청사항</th>
					<th><textarea style="resize: none" name="r_spec"></textarea></th>
				</tr>
				<tr>
				<th>픽업 서비스</th>
				<th><input type="radio"  name="r_pick" value="예" onchange="addrShow()" />예 <input
					type="radio" name="r_pick" value="아니오" checked  onchange="addrShow()"/>아니오</th>
			</tr>	
			<tr>
				<th>주소</th>
				<th><input type="text" onclick="showMap()" class="radio-value-detail" id="addr_kakao" name="r_pickaddr" readonly></th>
			</tr>
			<tr>
				<th></th>
				<th><input type="text" class="radio-value-detail" name="addr_detail" placeholder="상세주소를 입력해 주세요."></th>
			</tr>	
			<tr>
				<th colspan="2">
				<p id="ticketPrice">총 이용금액 :</p>
				<input type="button" id="selPrice" value="이용권 금액 계산"/>	
				<input type="hidden" id="tp" name="r_totalprice"/>
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