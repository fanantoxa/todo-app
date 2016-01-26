#= require spec_helper

describe 'TaskCtrl', ->
  beforeEach ->
    @success_action = true

    @TaskResource = jasmine.createSpyObj 'TaskResource', [
      'query',
      'save',
      'update',
      'remove'
    ]

    @tasks_list = [
      { id: 1, name: 'name 1', project_id: 1, position: 1},
      { id: 3, name: 'name 2', project_id: 1, position: 0}
    ]

    @task = { id: 3, name: 'name 3', project_id: 1, position: 2}

    @TaskResource.query.and.returnValue(@tasks_list)

    action_with_promise = $promise: then: (resolve, reject) =>
      if @success_action then resolve(@task) else reject(@task)

    @TaskResource.save.and.returnValue action_with_promise
    @TaskResource.update.and.returnValue action_with_promise
    @TaskResource.remove.and.returnValue action_with_promise

    @filter = jasmine.createSpy 'filter'

    @$scope.projectId = 1

    console.log = jasmine.createSpy 'log'

    @initTaskCtrl = ->
      @$controller 'TaskCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth
        TaskResource: @TaskResource
        $filter: @filter

  describe 'when authenticated', ->
    beforeEach ->
      @controller = @initTaskCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).not.toHaveBeenCalledWith '/'

    describe 'should initialize vairables', ->

      it 'should get tasks list', ->
        expect(@$scope.tasks_list).toEqual @tasks_list

      it 'should set defult vairables', ->
        expect(@$scope.new_task).toEqual {}
        expect(@$scope.edited_task).toEqual null
        expect(@$scope.sortable_options).toEqual { 
          animation: 150
          onUpdate: @controller.updatePosition
        }

      it 'should assign functions to scope', ->
        expect(@$scope.openDatapicker).toEqual @controller.openDatapicker
        expect(@$scope.addTask).toEqual @controller.addTask
        expect(@$scope.editTask).toEqual @controller.editTask
        expect(@$scope.cancelEditingTask).toEqual @controller.cancelEditingTask
        expect(@$scope.updateTask).toEqual @controller.updateTask
        expect(@$scope.destroyTask).toEqual @controller.destroyTask

    describe '#openDatapicker', ->
      it 'should open Datapicker', ->
        @$scope.openDatapicker @task
        expect(@task.datapickerOpened).toEqual true

    describe '#addTask', ->
      it 'should save task', ->
        @$scope.addTask @task
        expect(@$scope.tasks_list.shift()).toEqual @task
        expect(@$scope.new_task).toEqual {}

      it 'should handle errors', ->
        @success_action = false
        @$scope.addTask @task
        expect(@TaskResource.save).toHaveBeenCalledWith @task
        expect(console.log).toHaveBeenCalledWith 'error'

    describe '#editTask', ->
      it 'should initialize editing', ->
        @$scope.editTask @task
        expect(@$scope.edited_task).toEqual @task
        expect(@$scope.original_task).toEqual @task

    describe '#cancelEditingTask', ->
      it 'should cancel editing', ->
        @$scope.cancelEditingTask @task
        expect(@$scope.edited_task).toEqual null
        expect(@$scope.original_task).toEqual null

    describe '#updatePosition', ->
      beforeEach ->
        @event = { oldIndex: 0, newIndex: 1 }
        @$scope.original_task = @task

      it 'should update position', ->
        @controller.updatePosition @event
        expect(@$scope.tasks_list).toEqual [
          { id: 1, name: 'name 1', project_id: 1, position: 0},
          { id: 3, name: 'name 2', project_id: 1, position: 1}
        ]

      it 'should handle errors', ->
        @success_action = false
        @controller.updatePosition @event
        expect(@$scope.tasks_list).toEqual [
          { id: 3, name: 'name 2', project_id: 1, position: 2},
          { id: 1, name: 'name 1', project_id: 1, position: 1}
        ]

    describe '#updateTask', ->
      beforeEach ->
        @$scope.original_task = { id: 1, name: 'original_name', position: 5, project_id: 1}

      it 'should not call update when project not modified', ->
        @$scope.original_task = @task
        @$scope.updateTask @task, 'name'
        expect(@TaskResource.update).not.toHaveBeenCalled()

      it 'should update task', ->
        @$scope.updateTask @task, 'name'
        expect(@$scope.edited_task).toEqual null

      it 'should handle errors', ->
        @success_action = false
        @$scope.updateTask @task, 'name'
        expect(@task.name).toEqual 'original_name'

    describe '#destroyTask', ->
      it 'should destroy project', ->
        @$scope.destroyTask @task
        expect(@$scope.tasks_list.indexOf(@task)).toEqual -1

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue false
      @initTaskCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).toHaveBeenCalledWith '/'