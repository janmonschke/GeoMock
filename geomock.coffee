###
(c) 2011 Jan Monschke
v1.1
GeoMock is licensed under the MIT license.
###

do ->
  unless navigator? 
    window.navigator = {}
  
  delete navigator.geolocation
  
  navigator.geolocation = 
    delay : 1000
    
    shouldFail : false
    failsAt : -1
    errorMessage : "There was an error retrieving the position!"
    
    currentTimeout : -1
    
    lastPosReturned : 0
    
    _sanitizeLastReturned : ->
      if @lastPosReturned > @waypoints.length-1
        @lastPosReturned = 0
    
    _geoCall : (method, success, error) ->
      if @shouldFail and error?
        @currentTimeout = window[method].call null, =>
          error @errorMessage
        , @delay
      else
        if success?
          @currentTimeout = window[method].call null, =>
            success @waypoints[@lastPosReturned++]
            do @_sanitizeLastReturned
          , @delay
    
    getCurrentPosition : (success, error) ->
      @_geoCall "setTimeout", success, error
    
    watchPosition : (success, error) ->
      @_geoCall "setInterval", success, error
      @currentTimeout
    
    clearWatch : (id) ->
      clearInterval id
    
    waypoints : [
      {coords : {latitude : 52.5168, longitude : 13.3889, accuracy: 1500 }},
      {coords : {latitude : 52.5162, longitude : 13.3890, accuracy: 1334 }},
      {coords : {latitude : 52.5154, longitude : 13.3890, accuracy: 631  }},
      {coords : {latitude : 52.5150, longitude : 13.3890, accuracy: 361  }},
      {coords : {latitude : 52.5144, longitude : 13.3890, accuracy: 150  }},
      {coords : {latitude : 52.5138, longitude : 13.3890, accuracy: 65   }},
      {coords : {latitude : 52.5138, longitude : 13.3895, accuracy: 65   }},
      {coords : {latitude : 52.5139, longitude : 13.3899, accuracy: 65   }},
      {coords : {latitude : 52.5140, longitude : 13.3906, accuracy: 65   }},
      {coords : {latitude : 52.5140, longitude : 13.3910, accuracy: 65   }}
    ]
