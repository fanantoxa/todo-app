class LoginCtrl
  constructor: (@$scope, @$location, @Auth) ->
    @$location.path '/projects' if @Auth.isAuthenticated()
    
    @$scope.credentials = {
      email: '',
      password: ''
    }

    @$scope.error = false

    @$scope.login = this.login

  login: =>
    config = { headers: { 'X-HTTP-Method-Override': 'POST' } }

    @Auth.login(@$scope.credentials, config).then (user) =>
      @$location.path '/'
    , (error) =>
      @$scope.error = true

angular.module 'Todo'
  .controller 'LoginCtrl', [ '$scope', '$location', 'Auth', LoginCtrl]