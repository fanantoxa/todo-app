class AppCtrl
  constructor: ($scope, $location, Auth) ->
    $location.path '/projects' if Auth.isAuthenticated()

    Auth.currentUser().then (user) ->
      $location.path '/projects'
    ,(error) ->
      $location.path '/login'

angular.module 'Todo'
  .controller 'AppCtrl', ['$scope', '$location', 'Auth', AppCtrl]