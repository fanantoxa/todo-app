class CommentCtrl
  constructor: (@$scope, @$location, @Auth, @CommentResource) ->
    @$location.path '/' unless @Auth.isAuthenticated()

    @$scope.new_comment = {}
    @$scope.comments_list = @CommentResource.query(this._extandIds({}))

    @$scope.addComment = this.addComment
    @$scope.destroyComment = this.destroyComment

  addComment: (new_comment) =>
    params = this._extandIds(new_comment)
    @CommentResource.save(params)
      .$promise.then (comment) =>
          @$scope.comments_list.unshift comment
          @$scope.new_comment = {}
      , (error) =>
        console.log 'error'
        
  destroyComment: (comment) =>
    @CommentResource.remove(this._extandIds({ id: comment.id }))
      .$promise.then (result) =>
        index = @$scope.comments_list.indexOf(comment)
        @$scope.comments_list.splice(index, 1)

  _extandIds: (params) ->
    angular.extend({}, params,
      project_id: @$scope.projectId
      task_id: @$scope.taskId
    )

angular.module 'Todo'
  .controller 'CommentCtrl', [
    '$scope',
    '$location',
    'Auth',
    'CommentResource',
    CommentCtrl
  ]