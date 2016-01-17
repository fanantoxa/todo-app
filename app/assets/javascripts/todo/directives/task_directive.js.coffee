angular.module 'Todo'
  .directive 'task', () ->
    {
      restrict: 'E',
      templateUrl: 'task/template.html',
      controller: 'TaskCtrl'
      scope: {
        projectId: '=projectId'
      },
    }