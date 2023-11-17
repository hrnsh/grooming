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
				height: 98.3vh;
				width: 100%;
				position: relative;
				overflow: hidden;
			}
			
			#companyList{
				list-style-type: none;
                padding: 30px 5px 10px 0px;
                margin: 0;
			}
			
			.logo{
				cursor: pointer;
				position: absolute;
				z-index: 1;
				top: 20px;
				left: 30px;
			}
			
			.search-container {
                position: absolute;
                top: 50px;
                left: 200px;
                z-index: 1;
                background-color: Transparent;
                padding: 10px;
                border-radius: 5px;
                display: inline-block;
                height: 3%;
            }
            
            .companyListContainer {
                position: absolute;
                top: 155px;
                left: 30px;
                z-index: 1;
                background-color: rgba(255,255,255,0.7);
                padding: 5px;
                border-radius: 5px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                max-height: 80%;
                overflow-y: auto;
                width: 300px;
            }
			
			.companyItem{
				cursor: pointer;
				padding: 0px 5px;
				margin: 5px 0px;
				background-color: #f1f1f1;
				border: 1px solid #ccc;
				border-radius: 5px;
			}
			
			.detail-container {
                position: absolute;
                top: 180px;
                left: 350px;
                z-index: 1;
                background-color: rgba(255,255,255,0.7);
                padding: 10px;
                border-radius: 5px;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
                max-height: 70%;
                overflow-y: auto;
                width: 380px;
            }
            
            .contact-btn{
            	background-color: rgb(94, 94, 94);
				border: none;
				border-radius: 5px;
				color: white;
				width: 66px;
			    height: 25px;
			    margin-right: 5px;
            }
            
            .reserve-btn{
            	background-color: rgb(94, 94, 94);
				border: none;
				border-radius: 5px;
				color: white;
				width: 66px;
				height: 25px;
            }

            .company-detail {
                text-align: left;
                background-color: #f1f1f1;
                position: relative;
    			bottom: 20px;
            }
			
			.review-btn {
			   	background-color: rgb(94, 94, 94);
				border: none;
				border-radius: 5px;
				color: white;
				height: 25px;
				position: absolute;
				width: 380px;
				margin: 3px 0px 1px 0px;
    			right: 1px;
			}
			
			.review {
			    position: absolute;
			    top: 206px;
    			left: 760px;
			    z-index: 1;
			    background-color: rgba(255,255,255,0.7);
			    padding: 10px;
			    border-radius: 5px;
			    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
			    max-height: 70%;
			    overflow-y: auto;
			    width: 425px;
			}
			
			.review-container{
				    height: 240px;
			
			}
			
			#showUserLocation,  #searchPlaces{
			    height: 80%;
			    cursor: pointer;
			}
			
			#searchPlaces {
		        margin-right: 5px;
		        background-color: rgb(94, 94, 94);
				border: none;
				border-radius: 5px;
				color: white;
				bottom: 43px;
				position: relative;
				height: 32px;
		    }
			
			#keyword{
				position: relative;
				height: 30px;
				width: 300px;
				margin-right: 5px;
				bottom: 45px;
			}
			
			#closeCompanyList{
				background-color: rgb(94, 94, 94);
				border: none;
				border-radius: 5px;
				color: white;
				width: 45px;
				height: 25px;
				position: absolute;
				left: 235px;
				top: 10px;
			}
			
			#closeCompanyDetail{
				background-color: rgb(94, 94, 94);
				border: none;
				border-radius: 5px;
				color: white;
				width: 45px;
				height: 25px;
				position: absolute;
				top: 15px;
    			right: 25px;
			}
			
			#closeReview-container{
				background-color: rgb(94, 94, 94);
				border: none;
				border-radius: 5px;
				color: white;
				height: 25px;
				position: absolute;
				right: 15px;
    			top: 5px;
			}
			
			#showUserLocation{
				border:none;
				background-color:Transparent;
				position:relative;
				bottom: 15px;
			}
			
			#sortDropdown{
				position: relative;
			    left: 10px;
			    height: 25px;
			    top: 5px;
			}
			
			.reviewContent{
				border:1px solid black;
				margin-top:10px;
				margin-bottom:10px;
				position: relative;
				top: 10px;
				background-color: #f1f1f1;
			}
			
			
		</style>
	</head>
	
	<body>
		<div class="container">
            <div class="map_wrap">
                <div id="map"></div>
                
                <div class="logo">
					<img onclick="location.href='./'" src="resources/img/logo(location).png" alt="logoImage" width="150" height="120"/>
				</div>
                
                <div class="search-container">
                    <input type="text" id="keyword" size="15" placeholder="키워드를 입력해주세요">
    				<button id= "searchPlaces" type="submit">검색하기</button>
	                <button id="showUserLocation">
	                	<img alt="내 주변 위탁소 찾기" src="resources/img/locationButton.png" width="70px" height="70px">
	                	
	                </button>
                </div>
                
                <div class="companyListContainer">
                	<select id="sortDropdown">
                		<option value="distance">거리순</option>
                		<option value="rating">평균 별점순</option>
                	</select>
                	<button id="closeCompanyList">닫기</button>
                    <ul id="companyList" class="companyList"></ul>
                </div>
            </div>
            
            <div class="detail-container">
                <div class="company-detail"></div>
            	<button id="closeCompanyDetail">닫기</button>
            </div>
            
            <div class="review">
            	<button id="closeReview-container">닫기</button>
            	<div class="review-container"></div>
            </div>
        </div>
		
		<script>
			$(".companyListContainer").hide();
			$(".detail-container").hide();
			$(".review").hide();
			
			// 각 섹션에 닫기 기능 추가
		    $("#closeCompanyList").on("click", function () {
		        $(".companyListContainer").hide();
		        removeMarker(); // 업체 리스트를 닫을 때 마커도 삭제하려면 해당 함수를 호출
		    });

		    $("#closeCompanyDetail").on("click", function () {
		        $(".detail-container").hide();
		    });

		    $("#closeReview-container").on("click", function () {
		        $(".review").hide();
		    });
			
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
				
				// 키워드 검색 시 열었던 업체 리스트, 상세보기, 리뷰 리스트 숨기기
			    $(".companyListContainer").hide();
			    $(".detail-container").hide();
			    $(".review").hide();
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
			  				alert("사용자가 위치 공유를 거부했습니다.");
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
				var imageSrc = "resources/img/user.png";
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
						
						if (companies.length > 0) {
							$(".companyListContainer").show();
							$("#sortDropdown").show();
							
							$(".company-detail").empty();
							$(".review-container").empty();
						
							for (var i = 0; i < companies.length; i++){
								var company = companies[i];
								var companyLocation = new kakao.maps.LatLng(company.lat, company.lon);
								
								var message = '<div style="padding:5px;">'
					                + company.com_name + '<br>'
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
					            $("#companyList").append(
					            	'<li class="companyItem" data-lat="' + company.lat +
					                '" data-lon="' + company.lon + 
					                '" data-distance="' + distance +
					                '" data-rating="' + company.avg_star +
					                '">' +'<span id="span" style="font-weight:bold; font-size:20px;">'+
					                company.com_name + '</span>' +
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
					            
				            	 // 리뷰 컨테이너를 숨김
				                $(".review").hide();
					            
					            map.setCenter(companyLocation);
					            
					        	 // 업체 상세 정보를 가져와서 표시
				                var companyName = $(this).find("span").text();
					         	console.log(companyName);
					         
				                showCompanyDetail(companyName);
				                
					        });
							
					        sortCompaniesByDistance();
						} else {
							$(".companyListContainer").hide();
						}
					},
					error: function(error){
						console.error("오류 발생:", error);
					}
				});
			}
			
			function displayCompaniesMarker(companyLocation, message){
				var imageSrc = "resources/img/store.png";
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
						
						$(".company-detail").empty();
						$(".review-container").empty();
						
						if (companies.length > 0) {
							$(".companyListContainer").show();
							$("#sortDropdown").hide();
							
							// 검색된 장소 위치를 기준으로 지도 범위 재설정
							// LatLngBounds 객체에 좌표를 추가
							var bounds = new kakao.maps.LatLngBounds();

							for (var i = 0; i < companies.length; i++) {
								var company = companies[i];
								var companyLocation = new kakao.maps.LatLng(company.lat, company.lon);
								
								var message = '<div style="padding:5px;">'
					                + company.com_name + '<br>'
					                + '평균 별점: ' + company.avg_star
					                + '<br>'
					                + '누적 이용자 수: ' + company.user_total
					                + '</div>';
					            
								displayCompaniesMarker(companyLocation, message);
								
								// 화면 왼쪽의 리스트에 업체 정보를 추가
					            $("#companyList").append(
					            		'<li class="companyItem" data-lat="' + company.lat +
					                '" data-lon="' + company.lon + 
					                '" data-rating="' + company.avg_star +
					                '">' +'<span id="span" style="font-weight:bold; font-size:20px;">'+
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
					            
					            $(".review").hide();
					            
					            map.setCenter(companyLocation);
					            
					         	// 업체 상세 정보를 가져와서 표시
				                var companyName = $(this).find("span").text();
					         	console.log(companyName);
					         
				                showCompanyDetail(companyName);
					        });
							
					        sortCompaniesByRating();
						} else{
							$(".companyListContainer").hide();
						}
					},
			        error: function(xhr, status, error){
			        	console.error("AJAX 오류 발생:", status, error);
			        }
				});
				
				// 새로운 키워드로 검색할 때 업체 상세 정보 창을 숨김
			    $(".detail-container").hide();
			    $(".review").hide();
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
						
						// 기존에 있던 내용을 비워줌
			            $(".company-detail").empty();
						
						drawList(companyDetail);
						/*
						$.ajax({
							url: "getTicketPrice",
							type: "POST",
							data: {"companyName": companyName},
							dataType: "JSON",
							success: function(ticketPrice) {
								console.log(ticketPrice);
								drawTicketList(ticketPrice);
								*/
								// 상세 정보가 있는 경우 상세 정보 창을 표시
			                    $(".detail-container").show();
			                    $(".review-container").empty(); // 리뷰 창을 초기화
								
								// 리뷰 보기 버튼 추가
					            $(".company-detail").append('<button class="review-btn" data-company="' + companyName + '">리뷰 보기</button>');
								
					         	// "리뷰 보기" 버튼 클릭 시 리뷰 가져와 표시
					            $(".review-btn").on("click", function() {
									 var companyName = $(this).data("company");
									console.log("업체 이름: " + companyName);
									$(".review-container").empty(); // 리뷰 창을 초기화
									
									// 리뷰 상세 보기
									getReview(companyName);
									
									// 리뷰 컨테이너를 보이게 함
								    $(".review-container").show();
								});
					         	/*
							},
							error: function(e) {
								console.log(e);
							}
						});
						*/
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
					$(".detail-container").show();
					
					companyDetail.forEach(function(item,idx){
						content +='<h2 style="position: relative; top: 10px;">'+item.com_name+'</h2>';
						content += '<div id="btn"><button class="contact-btn" data-company="' + item.com_name + '">문의하기</button>';
			            content += '<button class="reserve-btn" data-company="' + item.com_name + '">예약하기</button></div>';
						content +='<div>'+item.address+ "<br>";
						content +="영업시간 : " + item.com_time + "<br>";
						content +="픽업 가능 여부 : " + item.pickup + "<br>";
						content +="전화번호 : " + item.phone + "<br>";
						content +="수용 가능 동물 수 : " + item.accept + "<br>";
						content +="평균 별점 : " + item.avg_star + "<br>";
						content +="누적 이용자 수 : " + item.user_total + "<br>";
						content += "가격 : " + 70000 + "</div>";
					});
					
					$(".company-detail").append(content);
				} else {
		            $(".detail-container").hide();
				}
			}
			/*
			function drawTicketList(ticketPrice) {
				var content = "";
				
				ticketPrice.forEach(function(item, idx) {
					if (item.t_type == "0") {
						content += "오전: " + item.t_price + "<br>";
					} else if(item.t_type == "1") {
						content += "오후: " + item.t_price + "<br>";
					} else{
						content += "종일: " + item.t_price + "<br>";
					}
					
					content += "</div>";
					
				});
				
				$(".company-detail").append(content);
			}
			*/
			function getReview(companyName) {
				$.ajax({
					url: "getReviews",
					type: "POST",
					data:{"companyName": companyName},
					dataType:"JSON",
					success: function(reviews) {
						console.log("getReview 호출!");
						
						displayReviews(reviews);
					},
					error: function(e) {
						console.log(e);
					}
				});
			}
			
			function displayReviews(reviews) {
				console.log("displayReviews 호출!");
				console.log(reviews);
				
				var reviewList = $(".review-container");
				
				var content="";
				
				reviewList.empty();
				
				if(reviews.length > 0) {
					$(".review").show();
					
					reviews.forEach(function(item, idx) {
						var date = new Date(item.rev_date);
					    var dateStr = date.toLocaleDateString("ko-KR");
					    
					   
						content += '<div class="reviewContent"><strong>작성자:</strong> ' + item.user_id + '<br>';
						content += '<strong>제목:</strong> ' + item.rev_subject + '<br>';
						content += '<strong>별점:</strong> ' + item.rev_star + '<br>';
						content += '<strong>내용:</strong> ' + item.rev_content + '<br>';
						content += '<strong>작성일:</strong> ' + dateStr + '<br></div>';
					});
						
					$(".review-container").append(content);
				
				} else{
					$(".review").show();
					// 리뷰가 없을 때 메시지를 표시
			        content = '<p>리뷰가 존재하지 않습니다.</p>';
			        $(".review-container").append(content);
				}
			}
			
			$("#sortDropdown").on("change", function() {
				console.log("정렬 변경!");
				var selectedOption = $(this).val();
				
				if (selectedOption === "distance") {
					// 거리순으로 업체 리스트 정렬
					sortCompaniesByDistance();
				} else if(selectedOption === "rating") {
					// 평균 별점순으로 업체 리스트 정렬
					sortCompaniesByRating();
				}
			});
			
			function sortCompaniesByDistance() {
				// 업체 리스트를 거리순으로 정렬
				var companyList = $("#companyList");
				
				var companies = companyList.find(".companyItem").get();
				companies.sort(function(a, b) {
					var distanceA = parseFloat($(a).data("distance"));
					var distanceB = parseFloat($(b).data("distance"));
					
					return distanceA - distanceB;
				});
				
				$.each(companies, function(index, element) {
					companyList.append(element);
				});
			}
			
			function sortCompaniesByRating() {
				// 업체 리스트를 평균 별점 순으로 정렬
				var companyList = $("#companyList");
				
				var companies = companyList.find(".companyItem").get();
			    companies.sort(function(a, b) {
			        var ratingA = parseFloat($(a).data("rating"));
			        var ratingB = parseFloat($(b).data("rating"));
			        return ratingB - ratingA;
			    });

			    $.each(companies, function(index, element) {
			        companyList.append(element);
			    });
			}
			
			// 문의하기 버튼 클릭 이벤트
			$(document).on("click", ".contact-btn", function() {
				console.log("문의하기 이동");
    		var companyName = $(this).data("company");
    		window.location.href = "locationNote?companyName=" + companyName;
			});

			// 예약하기 버튼 클릭 이벤트
			$(document).on("click", ".reserve-btn", function() {
				console.log("예약하기 이동");
   			 var companyName = $(this).data("company");
    		window.location.href = "reserve?companyName=" + companyName;
			});

			// 리뷰 보기 버튼 클릭 이벤트
			$(document).on("click", ".review-btn", function() {
   			 
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