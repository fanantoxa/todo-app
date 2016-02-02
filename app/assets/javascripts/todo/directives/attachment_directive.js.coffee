angular.module 'Todo'
  .directive 'attachments', () ->
    {
      restrict: 'E',
      templateUrl: 'attachment/template.html',
      controller: 'AttachmentCtrl'
      scope: {
        projectId: '=projectId',
        taskId: '=taskId',
        commentId: '=commentId'
      },
    }