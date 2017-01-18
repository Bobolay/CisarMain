function initialize_google_map() {
    var $map_wrapper = $("#googleMapWrapper")
    if (!$map_wrapper.length){
      return
    }
    var $map = $map_wrapper.children().filter(".map-container")
    var data_lat_lng = $map_wrapper.attr("data-center").split(",").map(function(a){return parseFloat(a)})
    var lat_lng = new google.maps.LatLng(data_lat_lng[0], data_lat_lng[1])
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
        center: lat_lng,
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
    var image = image_paths.map_marker
    //var marker = new google.maps.Marker({
    //    map: map,
    //    draggable: false,
    //    position: lat_lng,
    //    icon: image
    //});

    var $marker = $map_wrapper.children().filter(".marker")
    var $tooltip = $map_wrapper.children().filter('.info-window')
    var html_marker = $marker.get(0)

    var map_marker = new RichMarker({
        map: map,
        position: lat_lng,
        draggable: false,
        flat: true,
        anchor: RichMarkerPosition.MIDDLE,
        content: html_marker
    })

    map.mapTypes.set('map_style', styledMap);
    map.setMapTypeId('map_style');
}
//google.maps.event.addDomListener(window, 'resize', initialize);
//google.maps.event.addDomListener(window, 'load', initialize)
$window.on("resize load", initialize_google_map)
$document.on("page:load", initialize_google_map)

function open_marker() {
  $(this).addClass("opened");
  return $(this).closest(".map-wrapper").children().filter(".info-window").addClass("opened");
};

function close_marker() {
  $(this).removeClass("opened");
  return $(this).closest(".map-wrapper").children().filter(".info-window").removeClass("opened");
};

function toggle_marker() {
  if ($(this).hasClass("opened")) {
    return close_marker.apply(this);
  } else {
    return open_marker.apply(this);
  }
};

$document.on("click", ".marker-icon", function() {
  var $marker = $(this).closest(".marker");
  return toggle_marker.apply($marker);
});

$.clickOut(".info-window", function() {
  var $marker = $(this).closest(".map-wrapper").find(".marker");
  return close_marker.apply($marker);
}, {
  except: ".marker .marker-icon"
});