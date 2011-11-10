(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  (function() {
    if (typeof navigator == "undefined" || navigator === null) {
      window.navigator = {};
    }
    delete navigator.geolocation;
    return navigator.geolocation = {
      delay: 1000,
      shouldFail: false,
      failsAt: -1,
      errorMessage: "There was an error retrieving the position!",
      currentTimeout: -1,
      lastPosReturned: 0,
      _sanitizeLastReturned: function() {
        if (this.lastPosReturned > this.waypoints.length - 1) {
          return this.lastPosReturned = 0;
        }
      },
      _geoCall: function(method, success, error) {
        if (this.shouldFail && (error != null)) {
          return this.currentTimeout = window[method].call(null, __bind(function() {
            return error(this.errorMessage);
          }, this), this.delay);
        } else {
          if (success != null) {
            return this.currentTimeout = window[method].call(null, __bind(function() {
              success(this.waypoints[this.lastPosReturned++]);
              return this._sanitizeLastReturned();
            }, this), this.delay);
          }
        }
      },
      getCurrentPosition: function(success, error) {
        return this._geoCall("setTimeout", success, error);
      },
      watchPosition: function(success, error) {
        this._geoCall("setInterval", success, error);
        return this.currentTimeout;
      },
      clearWatch: function(id) {
        return clearInterval(id);
      },
      waypoints: [
        {
          coords: {
            latitude: 52.5168,
            longitude: 13.3889
          }
        }, {
          coords: {
            latitude: 52.5162,
            longitude: 13.3890
          }
        }, {
          coords: {
            latitude: 52.5154,
            longitude: 13.3890
          }
        }, {
          coords: {
            latitude: 52.5150,
            longitude: 13.3890
          }
        }, {
          coords: {
            latitude: 52.5144,
            longitude: 13.3890
          }
        }, {
          coords: {
            latitude: 52.5138,
            longitude: 13.3890
          }
        }, {
          coords: {
            latitude: 52.5138,
            longitude: 13.3895
          }
        }, {
          coords: {
            latitude: 52.5139,
            longitude: 13.3899
          }
        }, {
          coords: {
            latitude: 52.5140,
            longitude: 13.3906
          }
        }, {
          coords: {
            latitude: 52.5140,
            longitude: 13.3910
          }
        }
      ]
    };
  })();
}).call(this);
