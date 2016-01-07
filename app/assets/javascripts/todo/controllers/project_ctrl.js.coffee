class ProjectCtrl
  constructor: (@$scope, @$location, @Auth) ->
    @$location.path '/' unless @Auth.isAuthenticated()
    @$scope.projects = []

angular.module 'Todo'
  .controller 'ProjectCtrl', ['$scope', '$location', 'Auth', ProjectCtrl]