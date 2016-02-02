class AttachmentCtrl
  constructor: (@$scope, @$location, @Auth, @AttachmentResource) ->
    @$location.path '/' unless @Auth.isAuthenticated()

    @$scope.attachments_list = @AttachmentResource.query(this._extandIds({}))

  _extandIds: (params) ->
    angular.extend({}, params,
      project_id: @$scope.projectId
      task_id: @$scope.taskId,
      comment_id: @$scope.commentId,
    )

angular.module 'Todo'
  .controller 'AttachmentCtrl', [
    '$scope',
    '$location',
    'Auth',
    'AttachmentResource',
    AttachmentCtrl
  ]