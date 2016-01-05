#= require spec_helper

describe 'AppCtrl', ->
  beforeEach ->
    @initAppCtrl = ->
      @$controller 'AppCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth

  describe 'when authenticated', ->
    beforeEach ->
      @initAppCtrl()

    it 'should redirect to /projects', ->
      expect(@$location.path).toHaveBeenCalledWith('/projects')

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue(false)

    describe 'and server have user on session', ->
      beforeEach ->
        @initAppCtrl()
        
      it 'should redirect to /projects', ->
        expect(@$location.path).toHaveBeenCalledWith('/projects')

    describe 'and server have no user on session', ->
      beforeEach ->
        @currentUser = null
        @initAppCtrl()

      it 'should not redirect to /projects', ->
        expect(@$location.path).not.toHaveBeenCalledWith('/projects')

      it 'should redirect to /login', ->
        expect(@$location.path).toHaveBeenCalledWith('/login')