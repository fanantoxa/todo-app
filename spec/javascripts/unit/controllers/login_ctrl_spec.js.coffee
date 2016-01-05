#= require spec_helper

describe 'LoginCtrl', ->
  beforeEach ->
    @initLoginCtrl = ->
      @$controller 'LoginCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth
    @credentials = { email: '', password: '' }

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue(false)
      @initLoginCtrl()

    it 'should not redirect to /projects', ->
      expect(@$location.path).not.toHaveBeenCalledWith('/projects')

    it 'should initialize credentials', ->
      expect(@$scope.credentials).toEqual(@credentials)

    it 'should initialize error state', ->
      expect(@$scope.error).toEqual(false)

    describe '#logout', ->
      describe 'when success', ->
        beforeEach ->
          @Auth.login.and.returnValue(then: (resolve, reject) => resolve())
          @$scope.login()

        it 'should call login', ->
          expect(@Auth.login).toHaveBeenCalledWith(@credentials, { headers: { 'X-HTTP-Method-Override': 'POST' }})

        it 'should redirect to main page', ->
          expect(@$location.path).toHaveBeenCalledWith('/')

      describe 'when fail', ->
        beforeEach ->
          @Auth.login.and.returnValue(then: (resolve, reject) => reject())
          @$scope.login()

        it 'should show error', ->
          expect(@$scope.error).toEqual(true)

  describe 'when authenticated', ->
    beforeEach ->
      @initLoginCtrl()
      
    it 'should redirect to /projects', ->
      expect(@$location.path).toHaveBeenCalledWith('/projects')