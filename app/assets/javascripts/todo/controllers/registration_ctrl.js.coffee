angular.module 'Todo'
  .controller 'RegistrationCtrl', ($scope, $location, Auth) ->
    $location.path '/' if Auth.isAuthenticated()
    
    $scope.credentials = {
      email: '',
      password: '',
      password_confirmation: ''
    }

    $scope.regiter = ->
      config = { headers: { 'X-HTTP-Method-Override': 'POST' } }
      console.log $scope.credentials
      Auth.register($scope.credentials, config).then (registeredUser) ->
        $location.path '/'
      , (error) ->
        console.log "regiter fails"
        console.log error