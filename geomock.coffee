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
      {coords : {latitude : 52.5168, longitude : 13.3889 }},
      {coords : {latitude : 52.5162, longitude : 13.3890 }},
      {coords : {latitude : 52.5154, longitude : 13.3890 }},
      {coords : {latitude : 52.5150, longitude : 13.3890 }}, 
      {coords : {latitude : 52.5144, longitude : 13.3890 }}, 
      {coords : {latitude : 52.5138, longitude : 13.3890 }}, 
      {coords : {latitude : 52.5138, longitude : 13.3895 }}, 
      {coords : {latitude : 52.5139, longitude : 13.3899 }}, 
      {coords : {latitude : 52.5140, longitude : 13.3906 }}, 
      {coords : {latitude : 52.5140, longitude : 13.3910 }}
    ]