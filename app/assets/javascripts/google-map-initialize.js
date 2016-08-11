function initialize() {
    var $map = $("#googleMap")
    var data_lat_lng = $map.attr("data-center").split(",").map(function(a){return parseInt(a)})
    var styles = [
      {
        stylers: [
          { hue: "#ffb300" },
          { saturation: -14 },
          { lightness: -5 },
          { gamma: 1.28 }
        ]
      },{
        featureType: "all",
        elementType: "all",
      }
    ];
    var styledMap = new google.maps.StyledMapType(styles, {name: "Styled Map"});
    
    var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
    var isDraggable = w > 640 ? true : false;
    var xCordinate, zoomZoom = null;
    if (w > 640){
        xCordinate = 23.9097038;
        zoomZoom = 16;
    } else {
        xCordinate = 23.9097038;
        zoomZoom = 16;
    }

    var mapOptions = {
        zoom: zoomZoom,
        center: new google.maps.LatLng(data_lat_lng[0], data_lat_lng[1]),
        panControl:false,
        zoomControl:true,
        mapTypeControl:false,
        scaleControl:false,
        streetViewControl:false,
        overviewMapControl:false,
        rotateControl:false,
        draggable: true,
        scrollwheel: false,
        mapTypeControlOptions:{
            mapTypeIds: [google.maps.MapTypeId.ROADMAP, "map_style"]
        }
    };
    var map = new google.maps.Map($map[0],
        mapOptions);
    var image = '/assets/icons/map-marker.svg'
    var marker = new google.maps.Marker({
        map: map,
        draggable: false,
        position: new google.maps.LatLng(49.8450956, 24.0227671),
        icon: image
    });
    map.mapTypes.set('map_style', styledMap);
    map.setMapTypeId('map_style');
}
google.maps.event.addDomListener(window, 'resize', initialize);
google.maps.event.addDomListener(window, 'load', initialize)