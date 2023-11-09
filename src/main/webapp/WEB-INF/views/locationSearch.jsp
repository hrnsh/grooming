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
			
			#companyList{
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
			
			.detail-container {
                position: absolute;
                top: 110px;
                left: 260px;
                z-index: 1;
                background-color: #fff;
                padding: 10px;
                border-radius: 5px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                max-height: 70%;
                overflow-y: auto;
            }

            .company-detail {
                text-align: center;
                border: 1px solid black;
            }
			
			#showUserLocation {
			    margin-left: 10px;
			}
			
			#btn{
				position: relative;
				left: 55%;
				margin: 10px;
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
            
            <div class="detail-container">
                <div class="company-detail" style="text-align:left;">
                	
                </div>
                <button class="review-btn" data-company="' + item.com_name + '">리뷰 보기</button>
            </div>
        </div>
		
		<script>
			$("#companyList").hide();
		    $(".detail-container").hide();
			
			var container = document.getElementById("map");
			
			var options = {
				center : new kakao.maps.LatLng(37.5666612, 126.9783785),
				level: 7
			};
			
			var markers = [];
			
			// 지도 생성
			var map = new kakao.maps.Map(container, options);
			
			// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성
			var zoomControl = new kakao.maps.ZoomControl();
			
			map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
			
			
			$("#showUserLocation").on("click", function() {
				console.log("showUserLocation 호출!");
				
				// 이전 검색 결과 항목들을 제거
			    removeAllChildNods(document.getElementById("companyList"));
			 
				// 이전 검색 결과를 표시하는 마커들을 제거
				removeMarker();
				
				// HTML5의 geolocation으로 사용할 수 있는지 확인
				if(navigator.geolocation){
					// GeoLocation을 이용해서 접속 위치를 얻어옵니다
					navigator.geolocation.getCurrentPosition(function(position){
						var lat = position.coords.latitude,	// 위도
							   lon = position.coords.longitude;	// 경도
						
						var userLocation = new kakao.maps.LatLng(lat, lon);	// 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성
						
						var message = '<div style="padding:5px;">현 위치</div>'; // 인포윈도우에 표시될 내용
							
						displayUserMarker(userLocation, message);	// 마커와 인포윈도우를 표시
						
						searchNearbyCompanies(userLocation, 5);	// 반경 5km 내의 업체 검색
						
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
				
				// 마커와 인포윈도우를 저장
			    markers.push({ type: 'user', marker: marker, infowindow: infowindow });
				
			 	// 마커 클릭 이벤트 리스너 추가
			    kakao.maps.event.addListener(marker, 'click', function() {
			        infowindow.open(map, marker);
			    });
			}
			
			function searchNearbyCompanies(userLocation, radius) {
				var bounds = map.getBounds();
			    var sw = bounds.getSouthWest();
			    var ne = bounds.getNorthEast();
			    var swLat = sw.getLat();
			    var swLon = sw.getLng();
			    var neLat = ne.getLat();
			    var neLon = ne.getLng();
			    
			 	// 서버로 반경 내의 업체 검색 요청 전송
				$.ajax({
					url: "getNearbyCompanies",
					type: "POST",
					data: {
						"swLat": swLat, "swLon": swLon,
			            "neLat": neLat, "neLon": neLon,
			            "userLat": userLocation.getLat(), "userLon": userLocation.getLng(),
			            "radius": radius
					},
					dataType: "JSON",
					success: function(companies){
						console.log("현재 위치 반경 " + radius + "km 내의 업체 검색 완료!");
						
						for (var i = 0; i < companies.length; i++){
							var company = companies[i];
							var companyLocation = new kakao.maps.LatLng(company.lat, company.lon);
							
							var message = '<div style="padding:5px;">'
				                + '<a href="#" class="companyLink">' + company.com_name + '</a><br>'
				                + '평균 별점: ' + company.avg_star
				                + '<br>'
				                + '누적 이용자 수: ' + company.user_total
				                + '</div>';
				            
				             // 업체와 사용자 간의 거리 계산
				            var distance = calculateDistance(userLocation.getLat(), userLocation.getLng(), company.lat, company.lon);
				                
				         	// 거리를 메시지에 추가
			                message += '거리: ' + distance + ' km';
				             
				            displayCompaniesMarker(companyLocation, message);
				             
				          	// 화면 왼쪽의 리스트에 업체 정보를 추가
				            $("#companyList").append('<li class="companyItem" data-lat="' + company.lat +
				                '" data-lon="' + company.lon + '">' +
				                company.com_name +
				                '<br>평균 별점: ' + company.avg_star +
				                '<br>누적 이용자 수: ' + company.user_total +
				                '<br>거리: ' + distance + ' km' +
				                '</li>');
						}
						
						// 리스트의 각 항목을 클릭했을 때 지도에 해당 업체 마커를 표시합니다.
				        $(".companyItem").click(function () {
				            var lat = $(this).data("lat");
				            var lon = $(this).data("lon");
				            var companyLocation = new kakao.maps.LatLng(lat, lon);
				            
				            map.setCenter(companyLocation);
				            
				        	 // 업체 상세 정보를 가져와서 표시
			                var companyName = $(this).find("span").text();
				         	console.log(companyName);
				         
			                showCompanyDetail(companyName);
				        });
						
				     	// 새로운 내용이 들어올 때마다 companyList 요소를 갱신
			            if (companies.length === 0) {
			                document.getElementById("companyList").style.display = "none";
			            } else {
			                document.getElementById("companyList").style.display = "block";
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
				
				// 마커와 인포윈도우를 저장
			    markers.push({ type: 'company', marker: marker, infowindow: infowindow });
				
			 	// 마커 클릭 이벤트
			    kakao.maps.event.addListener(marker, 'click', function() {
			        infowindow.open(map, marker);
			    });
			}
			
			
			$("#searchPlaces").on("click", function() {
				console.log("searchPlaces 호출!");
				
				var keyword = $("#keyword").val().trim();

			    if (!keyword) {
			        alert("키워드를 입력해주세요!");
			        return false;
			    }
				
				$.ajax({
					url: "searchCompany",
					type: "POST",
			        data: { "keyword": keyword },
			        dataType: "JSON",
			        success: function(companies) {
						console.log("업체 위치 정보 요청 완료!");
						
						// 이전 검색 결과 항목들을 제거
					    removeAllChildNods(document.getElementById("companyList"));
						
						// 이전 검색 결과를 표시하는 마커들을 제거
						removeMarker();
						
						if (companies.length > 0) {
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
								
								// 화면 왼쪽의 리스트에 업체 정보를 추가
					            $("#companyList").append(
					            		'<li class="companyItem" data-lat="' + company.lat +
					                '" data-lon="' + company.lon + '">' +'<span id="span">'+
					                company.com_name + '</span>' +
					                '<br>평균 별점: ' + company.avg_star +
					                '<br>누적 이용자 수: ' + company.user_total +
					                '</li>'); 
					                
					            bounds.extend(companyLocation);
							}
							map.setBounds(bounds);
							
							// 리스트의 각 항목을 클릭했을 때 지도에 해당 업체 마커를 표시
					        $(".companyItem").click(function () {
					            var lat = $(this).data("lat");
					            var lon = $(this).data("lon");
					            var companyLocation = new kakao.maps.LatLng(lat, lon);
					            
					            map.setCenter(companyLocation);
					            
					         	// 업체 상세 정보를 가져와서 표시
				                var companyName = $(this).find("span").text();
					         	console.log(companyName);
					         
				                showCompanyDetail(companyName);
					        });
							
					        document.getElementById("companyList").style.display = "block";
						} else{
							document.getElementById("companyList").style.display = "none";
						}
					},
			        error: function(xhr, status, error){
			        	console.error("AJAX 오류 발생:", status, error);
			        }
				});
			});
			
			function showCompanyDetail(companyName) {
				console.log("showCompanyDetail 호출!");
				
				$.ajax({
					url: "getCompanyDetail",
					type: "POST",
					data: {"companyName": companyName},
					dataType: "JSON",
					success: function(companyDetail) {
						console.log(companyDetail);
						
						drawList(companyDetail);
						
						$.ajax({
							url: "getTicketPrice",
							type: "POST",
							data: {"companyName": companyName},
							dataType: "JSON",
							success: function(ticketPrice) {
								console.log(ticketPrice);
								drawTicketList(ticketPrice);
							},
							error: function(e) {
								console.log(e);
							}
						});
					},
					error: function(e){
						console.log(e);
					}
				});
			}
			
			function drawList(companyDetail){
				var content="";
				
				$(".company-detail").empty();
				
				if (companyDetail.length > 0) {
					$("#companyList").show();
					$(".detail-container").show();
					
					companyDetail.forEach(function(item,idx){
						content +='<h2>'+item.com_name+'</h2>';
						content += '<div id="btn"><button class="contact-btn" data-company="' + item.com_name + '">문의하기</button>';
			            content += '<button class="reserve-btn" data-company="' + item.com_name + '">예약하기</button></div>';
						content +='<div">'+item.address+ "<br>";
						content +="영업시간: " + item.com_time + "<br>";
						content +="픽업 가능 여부: " + item.pickup + "<br>";
						content +="전화번호: " + item.phone + "<br>";
						content +="수용 가능 동물 수: " + item.accept + "<br>";
						content +="평균 별점: " + item.avg_star + "<br>";
						content +="누적 이용자 수: " + item.user_total + "<br>";
						
					});
					
					$(".company-detail").append(content);
				} else {
					$("#companyList").hide();
		            $(".detail-container").hide();
				}
			}
			
			function drawTicketList(ticketPrice) {
				var content = "";
				
				ticketPrice.forEach(function(item, idx) {
					if (item.t_type == "0") {
						content += "오전: " + item.t_price + "<br>";
					} else if(item.t_type == "1") {
						content += "오후: " + item.t_price + "<br>";
					} else{
						content += "종일: " + item.t_price;
					}
					
					content += "</div>";
					
				});
				
				$(".company-detail").append(content);
			}
			
			// 문의하기 버튼 클릭 이벤트
			$(".contact-btn").on("click", function () {
			    var companyName = $(this).data("company");
			    window.location.href = "문의하기페이지의URL?companyName=" + companyName;
			});

			// 예약하기 버튼 클릭 이벤트
			$(".reserve-btn").on("click",  function () {
			    var companyName = $(this).data("company");
			    window.location.href = "reserve?companyName=" + companyName;
			});

			// 리뷰 보기 버튼 클릭 이벤트
			$(".review-btn").on("click", function () {
			    var companyName = $(this).data("company");
			    window.location.href = "리뷰보기페이지의URL?companyName=" + companyName;
			});
		
			function showDistance(position, companies) {
				// 사용자 위도, 경도
				var userLat = position.coords.latitude;
			    var userLon = position.coords.longitude;
			    
			    for (var i = 0; i < companies.length; i++) {
			        var company = companies[i];
			        var companyLat = company.lat;
			        var companyLon = company.lon;

			        var distance = calculateDistance(userLat, userLon, companyLat, companyLon);
			        $(".distance").eq(i).text("거리: " + distance + " km");
			    }
			}
			
			function calculateDistance(lat1, lon1, lat2, lon2) {
				var radLat1 = Math.PI * lat1 / 180;
			    var radLon1 = Math.PI * lon1 / 180;
			    var radLat2 = Math.PI * lat2 / 180;
			    var radLon2 = Math.PI * lon2 / 180;
			    
			 	// 두 지점의 차이를 계산
			    var dLat = radLat2 - radLat1;
			    var dLon = radLon2 - radLon1;
			    
			    // 반지름
			    var R = 6371;
			    
			    // 하버사인 공식으로 거리 계산
			    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
	            			  Math.cos(radLat1) * Math.cos(radLat2) *
	            			  Math.sin(dLon / 2) * Math.sin(dLon / 2);
			    
			    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
			    
			    var distance = R * c;
			    
			    // 소수점 둘째 자리까지
			    return distance.toFixed(2);
			}
			
			function removeAllChildNods(e) {
				while(e.hasChildNodes()){
					e.removeChild(e.lastChild);
				}
			}
			
			function removeMarker() {
				for ( var i = 0; i < markers.length; i++ ) {
					if (markers[i].type === 'user' || markers[i].type === 'company') {
			            markers[i].marker.setMap(null);
			            markers[i].infowindow.close();
			        }
			    }   
			    markers = [];
			}
		</script>
	</body>
</html>