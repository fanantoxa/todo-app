angular.module 'Todo'
  .controller 'RegistrationCtrl', ($scope, $location, Auth) ->
    $location.path '/' if Auth.isAuthenticated()
    
    $scope.credentials = {
      email: '',
      password: '',
      password_confirmation: ''
    }

    $scope.errors = {
      email: '',
      password: '',
      password_confirmation: ''
    }

    $scope.regiter = ->
      config = { headers: { 'X-HTTP-Method-Override': 'POST' } }
      Auth.register($scope.credentials, config).then (registeredUser) ->
        $location.path '/'
      , (response) ->
        console.log response.data.errors
        $scope.errors = angular.forEach response.data.errors, (value, key, obj) ->  obj[key] = value.join(' and ')
