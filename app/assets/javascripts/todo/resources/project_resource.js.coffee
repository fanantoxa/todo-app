angular.module 'Todo'
  .factory 'ProjectResource', ['$resource', ($resource) ->
    $resource '/projects/:id', { id: '@id' },{
      update: { method: 'PUT' }
    }
  ]