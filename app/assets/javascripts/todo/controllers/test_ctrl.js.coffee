TestCtrl = ($rootScope, $location) ->
  return true

angular.module('Todo').controller('TestCtrl', ['$rootScope','$location', TestCtrl])