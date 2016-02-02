angular.module 'Todo'
  .factory 'CommentResource', ['$resource', ($resource) ->
    $resource '/projects/:project_id/tasks/:task_id/comments/:id',
      { project_id: '@project_id', task_id: '@task_id', id: '@id'},
      { update: method: 'PUT' }
  ]