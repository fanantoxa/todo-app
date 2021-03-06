class RegistrationCtrl
  constructor: (@$scope, @$location, @Auth) ->
    @$location.path '/projects' if @Auth.isAuthenticated()
    
    @$scope.credentials = {
      email: '',
      password: '',
      password_confirmation: ''
    }

    @$scope.errors = {
      email: '',
      password: '',
      password_confirmation: ''
    }

    @$scope.register = this.register

  register: =>
    config = { headers: { 'X-HTTP-Method-Override': 'POST' } }
    @Auth.register(@$scope.credentials, config).then (registeredUser) =>
      @$location.path '/'
    , (response) =>
      @$scope.errors = this.parseErrors(response.data.errors)

  parseErrors: (errors) ->
    parsedErrors = {}
    angular.forEach errors,
      (value, key) ->  parsedErrors[key] = value.join(' and ')
    parsedErrors

angular.module 'Todo'
  .controller 'RegistrationCtrl', ['$scope', '$location', 'Auth', RegistrationCtrl]
