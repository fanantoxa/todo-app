class ProjectCtrl
  constructor: ($scope, $location, Auth) ->
    Auth.currentUser().then (user) ->
      console.log "test"
    ,(error) ->
      $location.path '/login'

angular.module 'Todo'
  .controller 'ProjectCtrl', ['$scope', '$location', 'Auth', ProjectCtrl]