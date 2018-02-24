// API endpoint for GeoJSON data
var queryUrl = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_day.geojson";

d3.json(queryUrl, function(data) {
    
    var myMap = L.map("map", {
        center: [37.09, -95.71],
        zoom: 5
    });


    L.tileLayer("https://api.mapbox.com/v4/mapbox.streets/{z}/{x}/{y}.png?" +
        "access_token=pk.eyJ1IjoiYWRhbWxkYXJuZWxsIiwiYSI6ImNqZGtmM2lrMTAwMWEycXBkaWZodmYzZm0ifQ.gu8LgIWHVdr-yu8tb8cswg"
    ).addTo(myMap);

    L.geoJSON(data, {
        onEachFeature: function(feature, layer) {
            layer.bindPopup(feature.properties.place)
        }
    }).addTo(myMap);

    L.circle(data, {
        onEachFeature: function(feature, layer) {
            circle.bindPopup(feature.properties.place)
        }
    }).addTo(myMap);
})