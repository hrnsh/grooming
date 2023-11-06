<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>업체 위치 찾기</title>
		<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f7bbdf9c95373d60e5bb55bb6f315e1"></script>
		
		<style>
			#map{
				height: 922px;
				width: 100%;
				position:relative;
				overflow:hidden;
			}
		</style>
	</head>
	
	<body>
		<div>
			<button id="showUserLocation">현재 위치 조회하기</button>
		</div>
		
		<div class="map_wrap">
			<div id="map"></div>	<!-- 맵이 출력될 공간 -->
		</div>
		<script>
			var container = document.getElementById("map");
			
			var options = {
				center : new kakao.maps.LatLng(37.5666612, 126.9783785),
				level: 3
			};
			
			var map = new kakao.maps.Map(container, options);
			
			$("#showUserLocation").on("click", function() {
				console.log("showUserLocation 호출!");
				
				// HTML5의 geolocation으로 사용할 수 있는지 확인
				if(navigator.geolocation){
					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation.getCurrentPosition(function(position){
						var lat = position.coords.latitude,	// 위도
							   lon = position.coords.longitude;	// 경도
						
						var userLocation = new kakao.maps.LatLng(lat, lon);	// 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성
						
						var message = '<div style="padding:5px;">현위치</div>'; // 인포윈도우에 표시될 내용
						
						displayUserMarker(userLocation, message);	// 마커와 인포윈도우를 표시
						
						sendLocationToServer(lat, lon);	// 서버로 현재 위치 정보 전송
					}, function (error){
						switch (error.code) {
		  				case error.PERMISSION_DENIED:
		  					console.error("사용자가 위치 공유를 거부했습니다.");
		  					break;
		  	
		  				case error.POSITION_UNAVAILABLE:
		  					console.error("위치 정보를 가져올 수 없습니다.");
		  					break;
		  					
		  				case error.TIMEOUT:
		  					console.error("시간 초과가 발생했습니다.");
		  					break;
		  				
		  				default:
		  				      console.error("알 수 없는 오류가 발생했습니다.");
	  				  	}
					});
				} else{	// HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
					alert("GeoLocation을 지원하지 않습니다!!");
				}    		  
			});		
					
			function displayUserMarker(userLocation, message){
				var imageSrc = "resources/img/userMarker.png";
				var imageSize = new kakao.maps.Size(35, 35);
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
				
				// 마커 생성
				var marker = new kakao.maps.Marker({
					map: map,
					position: userLocation,
					image: markerImage,
				});
				
				var iwContent = message,  // 인포윈도우에 표시할 내용
					iwRemoveable = true;
				
				// 인포윈도우를 생성
				var infowindow = new kakao.maps.InfoWindow({
					content: iwContent,
					removable: iwRemoveable
				});
				
				// 인포윈도우를 마커 위에 표시
				infowindow.open(map, marker);
				
				// 지도 중심 좌표를 접속위치로 변경
				map.setCenter(userLocation);
			}
			
			function sendLocationToServer(lat, lon) {
				$.ajax({
					url: "getNearbyCompanies",
					type: "POST",
					data: {
						"lat": lat, "lon": lon 
					},
					dataType: "JSON",
					success: function(companies){
						console.log("현재 위치 전송 완료!");
						
						for (var i = 0; i < companies.length; i++){
							var company = companies[i];
							var companyLocation = new kakao.maps.LatLng(company.lat, company.lon);
							var message = '<div style="padding:5px;">' + company.name + '</div>';
							displayCompaniesMarker(companyLocation, message);
						}
					},
					error: function(error){
						console.error("오류 발생:", error);
					}
				});
			}
			
			function displayCompaniesMarker(companyLocation, message){
				var imageSrc = "resources/img/storeMarker.png";
				var imageSize = new kakao.maps.Size(35, 35);
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
				
				// 마커 생성
				var marker = new kakao.maps.Marker({
					map: map,
					position: companyLocation,
					image: markerImage,
				});
				
				var iwContent = message,  // 인포윈도우에 표시할 내용
					iwRemoveable = true;
				
				// 인포윈도우를 생성
				var infowindow = new kakao.maps.InfoWindow({
					content: iwContent,
					removable: iwRemoveable
				});
				
				// 인포윈도우를 마커 위에 표시
				infowindow.open(map, marker);
			}
		</script>
	</body>
</html>