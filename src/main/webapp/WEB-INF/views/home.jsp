<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script defer src="./index.js"></script>
		<script
		  defer
		  src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDo4JEaj8dm8audnkJA171qe-tUg3kKcao
		  &callback=initMap"
		></script>
	</head>
	<body>
		<div id="map" style="height: 100%;"></div>
	</body>
	
	<script>
		window.initMap = function () {
			  const map = new google.maps.Map(document.getElementById("map"), {
			    center: { lat: 37.5400456, lng: 126.9921017 },
			    zoom: 10,
			  });
			};
	</script>
</html>