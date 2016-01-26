angular.module 'Todo'
  .factory 'TaskResource', ['$resource', ($resource) ->
    $resource '/projects/:project_id/tasks/:id',
      { project_id: '@project_id', id: '@id'} ,
      { update: method: 'PUT' }
  ]