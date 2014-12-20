class @FindTheLights.CurrentLocation
  @DEFAULT_LOCATION = 'Acton, MA'

  constructor: (deferredResolution) ->
    @deferredResolution = deferredResolution || (defer) =>
      navigator.geolocation.getCurrentPosition(
        @_reverseGeocodeLocation(defer), defer.reject
      )

  getLocation: (callback) =>
    successCallback = (value) -> callback(value)
    failureCallback = (value) -> callback(FindTheLights.CurrentLocation.DEFAULT_LOCATION)

    $.Deferred(@deferredResolution).then(successCallback, failureCallback)

  _reverseGeocodeLocation: (deferred) =>
    (geoposition) =>
      reverseGeocoder = new FindTheLights.ReverseGeocoder(
        geoposition.coords.latitude,
        geoposition.coords.longitude
      )
      reverseGeocoder.location(deferred)