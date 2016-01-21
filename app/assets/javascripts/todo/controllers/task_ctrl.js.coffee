class TaskCtrl
  constructor: (@$scope, @$location, @Auth, @TaskResource) ->
    @$location.path '/' unless @Auth.isAuthenticated()

    @$scope.sortable_options= 
      animation: 150
      onUpdate: this.updatePosition

    @$scope.tasks_list = @TaskResource.query(project_id: @$scope.projectId)

    @$scope.openDatapicker = this.openDatapicker

    @$scope.addTask = this.addTask
    @$scope.editTask = this.editTask
    @$scope.cancelEditingTask = this.cancelEditingTask
    @$scope.updateTask = this.updateTask
    @$scope.destroyTask = this.destroyTask

  openDatapicker: (task) =>
    task.datapickerOpened = true

  addTask: (new_task) =>
    params = this._extandProjectId(new_task)
    @TaskResource.save(params)
      .$promise.then (task) =>
          @$scope.tasks_list.unshift task
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

  updatePosition: (event) =>
    old_index = event.oldIndex
    new_index = event.newIndex
    task = @$scope.tasks_list[new_index]
    task.position = new_index

    this.updateTask(task, 'position',
      success: () =>
        this._reorder_list(old_index, new_index)
      error: () =>
        this._reverse_order(old_index, new_index)
    )
    
  _reverse_order: (old_index, new_index) ->
    console.log "old_index: #{old_index}"
    console.log "new_index: #{new_index}"
    list = @$scope.tasks_list
    list[new_index].position = old_index

    list.sort (a, b) ->
      return -1  if a.position < b.position
      return 1 if a.position > b.position
      return 0 

  _reorder_list: (old_index, new_index) ->
    for index in [old_index..new_index]
      @$scope.tasks_list[index].position = index

  updateTask: (task, field, callback = {}) =>
    params = this._updateParams(task, field)

    @TaskResource.update(params)
      .$promise.then (task) =>
        callback.success() if callback.success
        @$scope.edited_task = null
      ,(error) =>
        console.log callback
        callback.error() if callback.error
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
