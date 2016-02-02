class AttachmentCtrl
  constructor: (@$scope, @$location, @Auth, @Upload, @$timeout, @AttachmentResource) ->
    @$location.path '/' unless @Auth.isAuthenticated()

    @$scope.attachments_list = @AttachmentResource.query(this._extandIds({}))

    @$scope.uploadFiles = this.uploadFiles

  uploadFiles: (files, invalid_files) =>
    @$scope.files = files
    @$scope.invalid_files = invalid_files
    angular.forEach files, (file) =>
      file.upload = @Upload.upload
        url: "/projects/#{@$scope.projectId}/tasks/#{@$scope.taskId}/comments/#{@$scope.commentId}/attachments"
        method: 'POST',
        data: {file: file}

      file.upload.then (response) =>
        @$timeout () =>
          file.result = response.data
      , (response) =>
        if (response.status > 0)
          @$scope.errorMsg = response.status + ': ' + response.data
      , (evt) =>
        file.progress = Math.min(100, parseInt(100.0 * evt.loaded / evt.total))

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
    'Upload',
    '$timeout',
    'AttachmentResource',
    AttachmentCtrl
  ]
