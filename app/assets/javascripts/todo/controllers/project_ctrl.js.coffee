class ProjectCtrl
  constructor: ($scope, $location, Auth) ->
    $location.path '/' if !Auth.isAuthenticated()

    console.log "test"


angular.module 'Todo'
  .controller 'ProjectCtrl', ['$scope', '$location', 'Auth', ProjectCtrl]