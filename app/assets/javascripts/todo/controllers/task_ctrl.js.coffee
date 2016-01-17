class TaskCtrl
  constructor: (@$scope, @$location, @Auth, @TaskResource) ->
    @$location.path '/' unless @Auth.isAuthenticated()

    @$scope.tasks_list = @TaskResource.query(project_id: @$scope.projectId)

angular.module 'Todo'
  .controller 'TaskCtrl', [
    '$scope',
    '$location',
    'Auth',
    'TaskResource',
    TaskCtrl
  ]
