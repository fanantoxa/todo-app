class TaskCtrl
  constructor: (@$scope, @$location, @Auth, @TaskResource, @$filter) ->
    @$location.path '/' unless @Auth.isAuthenticated()

    @$scope.new_task = {}
    @$scope.edited_task = null
    @$scope.sortable_options =
      animation: 150
      handle: '.task'
      onUpdate: this.updatePosition

    @$scope.tasks_list = @TaskResource.query(project_id: @$scope.projectId)

    @$scope.openDatapicker = this.openDatapicker

    @$scope.toggleComments = this.toggleComments
    @$scope.addTask = this.addTask
    @$scope.editTask = this.editTask
    @$scope.cancelEditingTask = this.cancelEditingTask
    @$scope.updateTask = this.updateTask
    @$scope.destroyTask = this.destroyTask

  openDatapicker: (task) =>
    task.datapickerOpened = true

  toggleComments: (task)=>
    task.show_comments = !task.show_comments

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

  updateTask: (task, field, callback = {}) =>
    if @$scope.original_task && (task[field] == @$scope.original_task[field])
      @$scope.edited_task = null
      return

    params = this._updateParams(task, field)

    @TaskResource.update(params)
      .$promise.then (task) =>
        callback.success() if callback.success
        @$scope.edited_task = null
      ,(error) =>
        callback.error() if callback.error
        if @$scope.original_task && (field == 'name' || field == field)
          task[field] = @$scope.original_task[field]

  destroyTask: (task) =>
    @TaskResource.remove(this._extandProjectId({ id: task.id }))
      .$promise.then (result) =>
        index = @$scope.tasks_list.indexOf(task)
        @$scope.tasks_list.splice(index, 1)

  _updateParams: (task, field) ->
    params = { id: task.id }
    params[field] = task[field]
    params[field] = @$filter('date')(params[field], 'dd-MM-yyyy') if field == 'due_date'
    this._extandProjectId(params)

  _extandProjectId: (params) ->
    angular.extend({}, params, project_id: @$scope.projectId)

  _reverse_order: (old_index, new_index) ->
    list = @$scope.tasks_list
    list[new_index].position = old_index

    list.sort (a, b) ->
      return -1  if a.position < b.position
      return 1 if a.position > b.position
      return 0 

  _reorder_list: (old_index, new_index) ->
    for index in [old_index..new_index]
      @$scope.tasks_list[index].position = index

angular.module 'Todo'
  .controller 'TaskCtrl', [
    '$scope',
    '$location',
    'Auth',
    'TaskResource',
    '$filter',
    TaskCtrl
  ]