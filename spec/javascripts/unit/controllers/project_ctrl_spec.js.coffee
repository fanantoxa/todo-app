#= require spec_helper

describe 'ProjectCtrl', ->
  beforeEach ->
    @success_action = true

    @ProjectResource = jasmine.createSpyObj 'ProjectResource', [
      'query',
      'save',
      'update',
      'remove'
    ]

    @project_list = [ { id: 1, name: 'name 1'}, { id: 3, name: 'name 3'}]
    @project = { id: 3, name: 'name 3'}

    @ProjectResource.query.and.returnValue(@project_list)

    action_with_promise = $promise: then: (resolve, reject) =>
      if @success_action then resolve(@project) else reject(@project)

    @ProjectResource.save.and.returnValue action_with_promise
    @ProjectResource.update.and.returnValue action_with_promise
    @ProjectResource.remove.and.returnValue action_with_promise
    console.log = jasmine.createSpy 'log'

    @initProjectCtrl = ->
      @$controller 'ProjectCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth
        ProjectResource: @ProjectResource

  describe 'when authenticated', ->
    beforeEach ->
      @controller = @initProjectCtrl()
      
    it 'should not redirect to /', ->
      expect(@$location.path).not.toHaveBeenCalledWith '/'

    describe 'should initialize vairables', ->

      it 'should get projects list', ->
        expect(@$scope.projects_list).toEqual @project_list

      it 'should set defult vairables', ->
        expect(@$scope.edited_project).toEqual null

      it 'should assign functions to scope', ->
        expect(@$scope.addProject).toEqual @controller.addProject
        expect(@$scope.editProject).toEqual @controller.editProject
        expect(@$scope.cancelEditing).toEqual @controller.cancelEditing
        expect(@$scope.updateProject).toEqual @controller.updateProject
        expect(@$scope.destroyProject).toEqual @controller.destroyProject

    describe '#addProject', ->
      it 'should save project', ->
        @$scope.addProject @project
        expect(@$scope.projects_list.pop()).toEqual @project
        expect(@$scope.new_project).toEqual {}

      it 'should handle errors', ->
        @success_action = false
        @$scope.addProject @project
        expect(@ProjectResource.save).toHaveBeenCalledWith @project
        expect(console.log).toHaveBeenCalledWith 'error'

    describe '#editProject', ->
      it 'should initialize editing', ->
        @$scope.editProject @project
        expect(@$scope.edited_project).toEqual @project
        expect(@$scope.original_project).toEqual @project

    describe '#cancelEditing', ->
      it 'should cancel editing', ->
        @$scope.cancelEditing @project
        expect(@$scope.edited_project).toEqual null
        expect(@$scope.original_project).toEqual null

    describe '#updateProject', ->
      beforeEach ->
        @$scope.original_project = { id: 1, name: 'original_name'}

      it 'should not call update when project not modified', ->
        @$scope.original_project = @project
        @$scope.updateProject @project
        expect(@ProjectResource.update).not.toHaveBeenCalled()

      it 'should update project', ->
        @$scope.updateProject @project
        expect(@$scope.edited_project).toEqual null

      it 'should handle errors', ->
        @success_action = false
        @$scope.updateProject @project
        expect(@project.name).toEqual 'original_name'

    describe '#destroyProject', ->
      it 'should destroy project', ->
        @$scope.destroyProject @project
        expect(@$scope.projects_list.indexOf(@project)).toEqual -1

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue(false)
      @initProjectCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).toHaveBeenCalledWith('/')