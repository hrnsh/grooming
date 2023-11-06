<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>업체 위치 찾기</title>
		<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=0f7bbdf9c95373d60e5bb55bb6f315e1&libraries=services"></script>
		
		<style>
			#map{
				height: 100vh;
				width: 100%;
				position:relative;
				overflow:hidden;
			}
			
			.search-container {
                position: absolute;
                top: 10px;
                left: 10px;
                z-index: 1;
                background-color: #fff;
                padding: 5px;
                border-radius: 5px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                display: inline-block;
            }
            
            .companyListContainer {
                position: absolute;
                top: 70px;
                left: 10px;
                z-index: 1;
                background-color: #fff;
                padding: 5px;
                border-radius: 5px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                max-height: 80%;
                overflow-y: auto;
            }
			
			.companyList{
				list-style-type: none;
				padding: 10px;
				margin: 0;
			}
			
			.companyItem{
				cursor: pointer;
				padding: 5px;
				margin: 5px 0;
				background-color: #f1f1f1;
				border: 1px solid #ccc;
				border-radius: 5px;
			}
			
			#showUserLocation {
			    margin-left: 10px;
			}
		</style>
	</head>
	
	<body>
		<div class="container">
            <div class="map_wrap">
                <div id="map"></div>
                
                <div class="search-container">
                    <input type="text" id="keyword" size="15" placeholder="키워드를 입력해주세요">
    				<button id= "searchPlaces" type="submit">검색하기</button>
	                <button id="showUserLocation">현재 위치 조회하기</button>
                </div>
                
                <div class="companyListContainer">
                    <ul id="companyList" class="companyList"></ul>
                </div>
            </div>
        </div>
		
		<script>
			var container = document.getElementById("map");
			
			var options = {
				center : new kakao.maps.LatLng(37.5666612, 126.9783785),
				level: 7
			};
			
			var markers = [];
			
			// 장소 검색 객체를 생성
			var ps = new kakao.maps.services.Places();
			
			// 지도 생성
			var map = new kakao.maps.Map(container, options);
			
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
			var zoomControl = new kakao.maps.ZoomControl();
			
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
			
			$("#showUserLocation").on("click", function() {
				console.log("showUserLocation 호출!");
				
				// HTML5의 geolocation으로 사용할 수 있는지 확인
				if(navigator.geolocation){
					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation.getCurrentPosition(function(position){
						var lat = position.coords.latitude,	// 위도
							   lon = position.coords.longitude;	// 경도
						
						var userLocation = new kakao.maps.LatLng(lat, lon);	// 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성
						
						var message = '<div style="padding:5px;">현 위치</div>'; // 인포윈도우에 표시될 내용
							
						removeMarker();
						
						displayUserMarker(userLocation, message);	// 마커와 인포윈도우를 표시
						
						sendLocationToServer(lat, lon);	// 서버로 현재 위치 정보 전송
						
						map.setLevel(7);
						// 지도 중심 좌표를 접속위치로 변경
						map.setCenter(userLocation);
						
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
					image: markerImage
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
							
							var message = '<div style="padding:5px;">'
				                + '<a href="#" class="companyLink">' + company.com_name + '</a><br>'
				                + '평균 별점: ' + company.avg_star
				                + '<br>'
				                + '누적 이용자 수: ' + company.user_total
				                + '</div>';
				                
							displayCompaniesMarker(companyLocation, message);
							
							// 화면 왼쪽의 리스트에 업체 이름을 추가합니다.
				            $("#companyList").append('<li class="companyItem" data-lat="' + company.lat 
				            		+ '" data-lon="' + company.lon + '">' 
				            		+ company.com_name 
				            		+ '</li>');
						}
						
						// 리스트의 각 항목을 클릭했을 때 지도에 해당 업체 마커를 표시합니다.
				        $(".companyItem").click(function () {
				            var lat = $(this).data("lat");
				            var lon = $(this).data("lon");
				            var companyLocation = new kakao.maps.LatLng(lat, lon);
				            
				            map.setCenter(companyLocation);
				        });
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
					image: markerImage
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
			
			
			
			
			
			$("#searchPlaces").on("click", function() {
				console.log("searchPlaces 호출!");
				
				var keyword = document.getElementById("keyword").value;
				
				if (!keyword.replace(/^\s+|\s+$/g, ' ')) {
					alert("키워드를 입력해주세요!");
					return false;
				}
				
				removeMarker();
				
				$.ajax({
					url: "getSearchCompanyLocations",
					type: "POST",
			        data: { "keyword": keyword },
			        dataType: "JSON",
			        success: function(companies) {
						console.log("업체 위치 정보 요청 완료!");
						
						// 검색 결과 목록에 추가된 항목들을 제거
						removeAllChildNods(document.getElementById("companyList"));
						
						// 검색된 장소 위치를 기준으로 지도 범위 재설정
						// LatLngBounds 객체에 좌표를 추가
						var bounds = new kakao.maps.LatLngBounds();
						
						
						for (var i = 0; i < companies.length; i++) {
							var company = companies[i];
							var companyLocation = new kakao.maps.LatLng(company.lat, company.lon);
							
							var message = '<div style="padding:5px;">'
				                + '<a href="#" class="companyLink">' + company.com_name + '</a><br>'
				                + '평균 별점: ' + company.avg_star
				                + '<br>'
				                + '누적 이용자 수: ' + company.user_total
				                + '</div>';
				            
							displayCompaniesMarker(companyLocation, message);
							
							// 화면 왼쪽의 리스트에 업체 이름을 추가
			                $("#companyList").append('<li class="companyItem" data-lat="' + company.lat 
			                        + '" data-lon="' + company.lon + '">' 
			                        + company.com_name 
			                        + '</li>');
			                        
			                bounds.extend(companyLocation);
						}
						
						// 리스트의 각 항목을 클릭했을 때 지도에 해당 업체 마커를 표시합니다.
				        $(".companyItem").click(function () {
				            var lat = $(this).data("lat");
				            var lon = $(this).data("lon");
				            var companyLocation = new kakao.maps.LatLng(lat, lon);
				            
				            map.setCenter(companyLocation);
				        });
						
							map.setBounds(bounds);
					},
			        error: function(error){
			            console.error("오류 발생:", error);
			        }
				});
			});
			
			function removeAllChildNods(e) {
				while(e.hasChildNodes()){
					e.removeChild(e.lastChild);
				}
			}
			
			function removeMarker() {
				for ( var i = 0; i < markers.length; i++ ) {
			        markers[i].setMap(null);
			    }   
			    markers = [];
			}
		</script>
	</body>
</html>