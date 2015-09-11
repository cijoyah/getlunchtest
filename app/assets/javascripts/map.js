$(function(){

var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
var geocoder;
var map;
var bounds = new google.maps.LatLngBounds();
var endPoint = $('#address').text();

function initialize() {
  directionsDisplay = new google.maps.DirectionsRenderer();
  geocoder = new google.maps.Geocoder();
  var latlng = new google.maps.LatLng(-34.397, 150.644);
  var mapOptions = {
    // zoom: 17, (fit bounds sets zoom automatically)
    center: latlng
  }
  map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
  codeAddress();
  directionsDisplay.setMap(map);

  if(navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
      // var marker = new google.maps.Marker({
      //     map: map,
      //     position: pos
      // });
      calcRoute(pos)
      // map.setCenter(pos);
    }, function() {
      handleNoGeolocation(true);
    });
  } else {
    // Browser doesn't support Geolocation
    handleNoGeolocation(false);
  }
}

function handleNoGeolocation(errorFlag) {
  if (errorFlag) {
    var content = 'Error: The Geolocation service failed.';
  } else {
    var content = 'Error: Your browser doesn\'t support geolocation.';
  }
  var options = {
    map: map,
    position: new google.maps.LatLng(60, 105),
    content: content
  };
  var infowindow = new google.maps.InfoWindow(options);
  map.setCenter(options.position);
}

function calculateDistances(pos) {
  var service = new google.maps.DistanceMatrixService();
  service.getDistanceMatrix(
    {
      origins: [pos],
      destinations: [endPoint],
      travelMode: google.maps.TravelMode.WALKING,
      unitSystem: google.maps.UnitSystem.METRIC,
      avoidHighways: false,
      avoidTolls: false
    }, callback);
}

function callback(response, status) {
  console.log(response.rows[0].elements[0].distance.text)
  console.log(response.rows[0].elements[0].duration.text)
  $('.duration').append(response.rows[0].elements[0].duration.text)
  $('.distance').append(response.rows[0].elements[0].distance.text)
  console.log(status)
}

function codeAddress() {
  var address = $('#address').text();
  geocoder.geocode( { 'address': address}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      map.setCenter(results[0].geometry.location);
      // var marker = new google.maps.Marker({
      //     map: map,
      //     position: results[0].geometry.location
      // });
    } else {
      alert('Geocode was not successful for the following reason: ' + status);
    }
  });
}

function calcRoute(pos) {
  // var selectedMode = document.getElementById('mode').value;
  var request = {
      origin: pos,
      destination: endPoint,
      travelMode: google.maps.TravelMode["WALKING"]
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
    map.fitBounds(bounds);
  });
  calculateDistances(pos);
}
google.maps.event.addDomListener(window, 'load', initialize);
})