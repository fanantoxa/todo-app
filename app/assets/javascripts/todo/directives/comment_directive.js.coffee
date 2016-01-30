angular.module 'Todo'
  .directive 'comments', () ->
    {
      restrict: 'E',
      templateUrl: 'comment/template.html',
      controller: 'CommentCtrl'
      scope: {
        projectId: '=projectId',
        taskId: '=taskId'
      },
    }