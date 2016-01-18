parseDate = (data) ->
  if data.due_date
    dd = new Date(data.due_date)
    data.due_date = "#{dd.getDate()}/#{dd.getMonth()+1}/#{dd.getFullYear()}"
  data

angular.module 'Todo'
  .factory 'TaskResource', ['$resource', ($resource) ->
    $resource '/projects/:project_id/tasks/:id', { project_id: '@project_id', id: '@id'} ,
      query: 
        isArray: true
        method: 'GET'
        params: { project_id: '@project_id' }
        transformResponse: (data) =>
          list = angular.fromJson(data)
          angular.forEach list, (value) =>
            parseDate(value)
          list
      update:
        method: 'PUT'
        transformResponse: (data) =>
          item = angular.fromJson(data)
          parseDate(item)
          item
      update:
        params: { project_id: '@project_id', id: '@id'}
        method: 'PUT'
        transformResponse: (data) =>
          item = angular.fromJson(data)
          parseDate(item)
          item
      save:
        params: { project_id: '@project_id'}
        method: 'POST'
        transformResponse: (data) =>
          item = angular.fromJson(data)
          parseDate(item)
          item
  ]