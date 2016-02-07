#= require spec_helper

describe 'AttachmentCtrl', ->
  beforeEach ->
    @success_action = true

    @AttachmentResource = jasmine.createSpyObj 'AttachmentResource', [
      'query',
      'remove'
    ]

    @attachments_list = [
      { id: 1, text: 'text 1'},
      { id: 2, text: 'text 2'}
    ]

    @attachment = { id: 3, text: 'name 3'}

    fake_promise = (resolve, reject) =>
      if @success_action then resolve(@attachment) else reject(@attachment)

    fake_uploader =
      then: fake_promise,
      finally: (func) ->
        func()

    @Upload = jasmine.createSpyObj 'Upload', ['upload']

    @Upload.upload.and.returnValue(fake_uploader)  

    @AttachmentResource.query.and.returnValue(@attachments_list)

    action_with_promise = $promise: then: fake_promise

    @AttachmentResource.remove.and.returnValue action_with_promise

    @$scope.projectId = 1
    @$scope.taskId = 1
    @$scope.commentId = 1

    @$timeout = jasmine.createSpy '$timeout'

    console.log = jasmine.createSpy 'log'

    @initAttachmentCtrl = ->
      @$controller 'AttachmentCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth
        Upload: @Upload
        $timeout: @$timeout
        AttachmentResource: @AttachmentResource

  describe 'when authenticated', ->
    beforeEach ->
      @controller = @initAttachmentCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).not.toHaveBeenCalledWith '/'

    describe 'should initialize vairables', ->

      it 'should get attachments list', ->
        expect(@$scope.attachments_list).toEqual @attachments_list

      it 'should assign functions to scope', ->
        expect(@$scope.uploadAttachments).toEqual @controller.uploadAttachments
        expect(@$scope.destroyAttachment).toEqual @controller.destroyAttachment

    describe '#uploadAttachments', ->
      beforeEach ->
        @$scope.uploadAttachments [{a: 1}, {b: 2}], []

      it 'should update scope', ->
        expect(@$scope.invalid_files).toEqual []

      it 'should create Uploader for each file', ->
        expect(@Upload.upload.calls.count()).toEqual 2        

      it 'should upload files sucessful', ->
        expect(@$timeout.calls.count()).toEqual 2

      it 'should clear files queue', ->
        expect(@$scope.files).toEqual null

    describe '#destroyAttachment', ->
      it 'should destroy attachment', ->
        @$scope.destroyAttachment @attachment
        expect(@$scope.attachments_list.indexOf(@attachment)).toEqual -1

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue false
      @initAttachmentCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).toHaveBeenCalledWith '/'