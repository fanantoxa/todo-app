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

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue(false)
      @initProjectCtrl()

    it 'should not redirect to /', ->
      expect(@$location.path).toHaveBeenCalledWith('/')