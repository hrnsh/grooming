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
		
			function initMap() {
				map = new google.maps.Map(document.getElementById("map"), 
				{
					mapTypeId : 'roadmap',
					center : {lat : 37.476517, lng : 126.880036},
					zoom : 15
				});
			}
		
			function showCurrentLocation() {
				if(navigator.geolocation){
					navigator.geolocation.getCurrentPosition(
						(position) => {
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
						},
						() => {
							alert("위치 정보를 가져올 수 없습니다.");
						}
					);
				} else{
					alert("브라우저가 위치 정보를 지원하지 않습니다!!");
				}
			}
		</script>
	</head>
	<body onload="initMap()">
		<div>
			<button onclick="showCurrentLocation()">현재 위치 조회하기</button>
		</div>
		
		<div id="map" style="height: 100%; width: 100%;"></div>	<!-- 맵이 출력될 공간 -->
	</body>

	
</html>