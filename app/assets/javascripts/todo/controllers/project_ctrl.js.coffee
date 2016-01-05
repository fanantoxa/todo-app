class ProjectCtrl
  constructor: ($scope, $location, Auth) ->
    $location.path '/' unless Auth.isAuthenticated()

    console.log "test"


angular.module 'Todo'
  .controller 'ProjectCtrl', ['$scope', '$location', 'Auth', ProjectCtrl]