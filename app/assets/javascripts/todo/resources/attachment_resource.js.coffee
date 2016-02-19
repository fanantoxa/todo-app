angular.module 'Todo'
  .factory 'AttachmentResource', ['$resource', ($resource) ->
    $resource '/projects/:project_id/tasks/:task_id/comments/:comment_id/attachments/:id',
      {
        project_id: '@project_id',
        task_id: '@task_id',
        comment_id: '@comment_id',
        id: '@id'
      },
      { update: method: 'PUT' }
  ]