<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta charset="UTF-8">
		<title>업체 위치 찾기</title>
		<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
		<script  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDo4JEaj8dm8audnkJA171qe-tUg3kKcao
	    &callback=initMap" async defer></script>
		
		<script>
			let map;
			let marker;
			
			// 초기 지도
			function initMap() {
				map = new google.maps.Map(document.getElementById("map"), 
				{
					mapTypeId : 'roadmap',
					center : {lat : 37.5666612, lng : 126.9783785},
					zoom : 15
				});
			}
			
			// 현재 위치
			function showCurrentLocation() {
				if(navigator.geolocation){
					navigator.geolocation.getCurrentPosition(success, error, options);
				} else{
					alert("브라우저가 위치 정보를 지원하지 않습니다!!");
				}
			}
			
			// 위치 정보 요청 성공
			function success(position){
				const currentLocation = {
						lat: position.coords.latitude,
						lng: position.coords.longitude
				};
					
				// 기존 마커 삭제
				if(marker){
					marker.setMap(null);
				}
					
				// 새로운 마커 생성
				marker = new google.maps.Marker({
					position: currentLocation,
					map: map,
					title: "현재 위치"
				});
					
				// 지도 이동
				map.panTo(currentLocation);
			}
			
			// 실패
			function error() {
				alert("위치 정보를 가져올 수 없습니다!!");
			}
			
			const options = {
					// 높은 정확도 위치 설정
					enableHighAccuracy: true,
					// 위치 정보를 받기 위해 15초 동안 대기
					timeout: 15000,
					// 5분이 지나기 전까지는 위치 정보가 수정되지 않게 함
					maximumAge: 30000
			};
		</script>
	</head>
	<body onload="initMap()">
		<div>
			<button onclick="showCurrentLocation()">현재 위치 조회하기</button>
		</div>
		
		<div id="map" style="height: 100%; width: 100%;"></div>	<!-- 맵이 출력될 공간 -->
	</body>

	
</html>