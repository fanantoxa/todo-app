#= require spec_helper

describe 'ProjectCtrl', ->
  beforeEach ->
    @initProjectCtrl = ->
      @$controller 'ProjectCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth

  describe 'when authenticated', ->
    beforeEach ->
      @initProjectCtrl()
      
    it 'should not redirect to /', ->
      expect(@$location.path).not.toHaveBeenCalledWith('/')

    describe 'should initialize vairables', ->

      it 'should get projects list'
      it 'should set defult vairables'
      it 'should assign functions to scope'

    describe '#addProject', ->
      it 'should save progect'
      it 'should handle errors'

    describe '#editProject', ->
      it 'should initialize editing'

    describe '#cancelEditing', ->
      it 'should cancel editing'

    describe '#updateProject', ->
      it 'should update progect'
      it 'should handle errors'

    describe '#destroyProject', ->
      it 'should destroy progect'
      it 'should handle errors'

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue(false)
      @initProjectCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).toHaveBeenCalledWith('/')