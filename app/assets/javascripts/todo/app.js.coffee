angular.module 'Todo', ['ui.router','templates','Devise']

angular.module 'Todo'
  .run (Auth) ->  Auth.currentUser()

angular.module 'Todo'
  .config ($stateProvider, $urlRouterProvider, $httpProvider) ->
    $urlRouterProvider.otherwise("/")

    $httpProvider.defaults.withCredentials = true

    $stateProvider
      .state 'project',
        url: '/'
        controller: 'ProjectCtrl'
        templateUrl: 'project/main.html'
      .state 'login',
        url: '/login'
        controller:  'LoginCtrl'
        templateUrl: 'auth/login.html'
      .state 'registration',
        url: '/registration'
        controller:  'RegistrationCtrl'
        templateUrl: 'auth/registration.html'  