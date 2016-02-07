#= require spec_helper

describe 'CommentCtrl', ->
  beforeEach ->
    @success_action = true

    @CommentResource = jasmine.createSpyObj 'CommentResource', [
      'query',
      'save',
      'remove'
    ]

    @comments_list = [
      { id: 1, text: 'text 1'},
      { id: 2, text: 'text 2'}
    ]

    @comment = { id: 3, text: 'name 3'}

    @CommentResource.query.and.returnValue(@comments_list)

    action_with_promise = $promise: then: (resolve, reject) =>
      if @success_action then resolve(@comment) else reject(@comment)

    @CommentResource.save.and.returnValue action_with_promise
    @CommentResource.remove.and.returnValue action_with_promise

    @$scope.projectId = 1
    @$scope.taskId = 1

    console.log = jasmine.createSpy 'log'

    @initCommentCtrl = ->
      @$controller 'CommentCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth
        CommentResource: @CommentResource

  describe 'when authenticated', ->
    beforeEach ->
      @controller = @initCommentCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).not.toHaveBeenCalledWith '/'

    describe 'should initialize vairables', ->

      it 'should get comments list', ->
        expect(@$scope.comments_list).toEqual @comments_list

      it 'should set defult vairables', ->
        expect(@$scope.new_comment).toEqual {}

      it 'should assign functions to scope', ->
        expect(@$scope.addComment).toEqual @controller.addComment
        expect(@$scope.destroyComment).toEqual @controller.destroyComment

    describe '#addComment', ->
      it 'should save comment', ->
        @$scope.addComment @comment
        expect(@$scope.comments_list.pop()).toEqual @comment
        expect(@$scope.new_comment).toEqual {}

      it 'should handle errors', ->
        @success_action = false
        @$scope.addComment @comment
        expect(@CommentResource.save).toHaveBeenCalledWith {id: 3, text: 'name 3', project_id: 1, task_id: 1}
        expect(console.log).toHaveBeenCalledWith 'error'

    describe '#destroyComment', ->
      it 'should destroy comment', ->
        @$scope.destroyComment @comment
        expect(@$scope.comments_list.indexOf(@comment)).toEqual -1

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue false
      @initCommentCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).toHaveBeenCalledWith '/'