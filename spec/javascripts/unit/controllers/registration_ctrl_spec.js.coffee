#= require spec_helper

describe 'RegistrationCtrl', ->
  beforeEach ->
    @initRegistrationCtrl = ->
      @$controller 'RegistrationCtrl',
        $scope: @$scope
        $location: @$location
        Auth: @Auth
    @credentials = { email: '', password: '', password_confirmation: '' }
    @errors = { email: '', password: '', password_confirmation: '' }
    @server_errors = {data: errors: {
      email: ['err1'],
      password: ['err2', 'err3'],
      password_confirmation: []
    }}

  describe 'when not authenticated', ->
    beforeEach ->
      @Auth.isAuthenticated.and.returnValue(false)
      @initRegistrationCtrl()

    it 'should not redirect to /projects', ->
      expect(@$location.path).not.toHaveBeenCalledWith('/projects')

    it 'should initialize credentials', ->
      expect(@$scope.credentials).toEqual(@credentials)

    it 'should initialize errors', ->
      expect(@$scope.error).toEqual(@error)

    describe '#register', ->
      describe 'when success', ->
        beforeEach ->
          @Auth.register.and.returnValue(then: (resolve, reject) => resolve())
          @$scope.register()

        it 'should call register', ->
          expect(@Auth.register).toHaveBeenCalledWith(@credentials, { headers: { 'X-HTTP-Method-Override': 'POST' }})

        it 'should redirect to main page', ->
          expect(@$location.path).toHaveBeenCalledWith('/')

      describe 'when fail', ->
        beforeEach ->
          @Auth.register.and.returnValue(then: (resolve, reject) => reject(@server_errors))
          @$scope.register()

        it 'should parse errors', ->
          expect(@$scope.errors).toEqual({
            email: 'err1',
            password: 'err2 and err3',
            password_confirmation: '' })

  describe 'when authenticated', ->
    beforeEach ->
      @initRegistrationCtrl()
      
    it 'should redirect to /projects', ->
      expect(@$location.path).toHaveBeenCalledWith('/projects')