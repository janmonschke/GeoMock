# GeoMock

Developing Geo-aware Apps/Games can be such a pain in the ass.

It can take ages until the device finally gets a decent signal or it's raining outside and you don't want to run around out in that bad weather to test your app or maybe you're just too lazy to walk a mile or two ;)

GeoMock can help in many ways when working with the Geolocation API:
	- Predefined locations can fire up through the normal Geolocation API after a certain delay or even immediately
	- It also allows you to define a set of waypoints that are being propagated through `geolocation.watchPosition`.
	- It can be used to test the way your app behaves when no signal could be retrieved

## Usage

Simply include geomock.js in your website and it will replace the native Geolocation object. There is no need to change the API for tests because it mocks the Geolocation API.

To retrieve a location user `navigator.geolocation.getCurrentPosition(success, error)` or `navigator.geolocation.watchPosition(success, error)`.

The mock-locations can be changed by accessing the `navigator.geolocation.waypoints`-Array.

The predefined delay is 1000ms. Change it like this `navigator.geolocation.delay = 2000;`.

To test failing requests, set `navigator.geolocation.shouldFail` to `true`.

## Example
[http://janmonschke.com/GeoMock/example.html](http://janmonschke.com/GeoMock/example.html)

## License
MIT