<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>업체 위치 찾기</title>
		<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
		<script  async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDo4JEaj8dm8audnkJA171qe-tUg3kKcao&callback=initMap"></script>
	</head>
	
	<body>
		<div>
			<button onclick="showUserLocation()">현재 위치 조회하기</button>
			<button onclick="showStoreLocation()">주변 업체 조회하기</button>
		</div>
		
		<div id="map" style="height: 100%; width: 100%;"></div>	<!-- 맵이 출력될 공간 -->
		
		<script>
		
		let map;
		
		function initMap() {
	            // 지도 생성
	            map = new google.maps.Map(document.getElementById('map'), {
	            	mapTypeId : 'roadmap',
					center : {lat : 37.5666612, lng : 126.9783785},
					zoom : 15,
					mapTypeControl: false
	            });
	    }
		
		function showUserLocation() {
			if (navigator.geolocation) {
			      navigator.geolocation.getCurrentPosition(
			    		  (position) => {
			    			  
			    		  }, () => {
			    			  
			    		  });
			    } else {
			      alert("브라우저가 위치 정보를 지원하지 않습니다.");
			    }
		}
		
		function sendLocation(position) {
			var userLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
		    
		    // 서버로 현재 위치 전송 (AJAX 또는 폼 submit을 이용해 전송)
		    $.ajax({
		      url: "${pageContext.request.contextPath}/updateLocation",
		      method: "POST",
		      data: { lat: position.coords.latitude, lon: position.coords.longitude },
		      success: function(response) {
		        console.log("현재 위치 전송 완료!");
		        
		        // 현재 위치 마커 표시
		        var userIcon = new google.maps.MarkerImage("${pageContext.request.contextPath}/resources/img/userMarker.png");
	            var userMarker = new google.maps.Marker({
	                position: userLocation,
	                map: map,
	                icon: userIcon,
	                title: '현재 위치'
	            }); 
		      },
		      error: function(error) {
		        console.error("오류 발생:", error);
		        
		        sendError(error);
		      }
		    });
		  }
		
		function sendError(error) {
			switch (error) {
			case error.PERMISSION_DENIED:
				str = "사용자 거부";
				break;

			case error.POSITION_UNAVAILABLE:
				str = "지리 정보 없음";
				break;
				
			case error.TIMEOUT:
				str = "시간 초과";
				break;
			}
		}
		
		window.initMap = initMap;
		</script>
	</body>
</html>