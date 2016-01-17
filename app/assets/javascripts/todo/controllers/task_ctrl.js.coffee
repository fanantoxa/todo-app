class TaskCtrl
  constructor: (@$scope, @$location, @Auth, @TaskResource) ->
    @$location.path '/' unless @Auth.isAuthenticated()

    @$scope.tasks_list = @TaskResource.query(project_id: @$scope.projectId)

    @$scope.addTask = this.addTask
    @$scope.editTask = this.editTask
    @$scope.cancelEditingTask = this.cancelEditingTask
    @$scope.updateTask = this.updateTask
    @$scope.destroyTask = this.destroyTask

  addTask: (new_task) =>
    params = this._extandProjectId(new_task)
    @TaskResource.save(params)
      .$promise.then (task) =>
          @$scope.tasks_list.push task
          @$scope.new_task = {}
      , (error) =>
        console.log 'error'

  editTask: (task) =>
    @$scope.edited_task = task
    @$scope.original_task = angular.extend({}, task)

  cancelEditingTask: (task) =>
    tasks = @$scope.tasks_list
    tasks[tasks.indexOf(task)] = @$scope.original_task
    @$scope.edited_task = null
    @$scope.original_task = null

  updateTask: (task, field) =>
    params = this._updateParams(task, field)

    @TaskResource.update(params)
      .$promise.then (task) => 
        @$scope.edited_task = null
      ,(error) =>
        console.log 'error'

  destroyTask: (task) =>
    @TaskResource.remove(this._extandProjectId({ id: task.id }))
      .$promise.then (result) =>
        index = @$scope.tasks_list.indexOf(task)
        @$scope.tasks_list.splice(index, 1)

  _updateParams: (task, field) ->
    params = { id: task.id }
    params[field] = task[field]
    this._extandProjectId(params)

  _extandProjectId: (params) ->
    angular.extend({}, params, project_id: @$scope.projectId)

angular.module 'Todo'
  .controller 'TaskCtrl', [
    '$scope',
    '$location',
    'Auth',
    'TaskResource',
    TaskCtrl
  ]
