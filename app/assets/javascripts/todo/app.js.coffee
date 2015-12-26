class TodoConfig 
  constructor: ($stateProvider, $urlRouterProvider, $httpProvider) ->
    $urlRouterProvider.otherwise("/")

    $httpProvider.defaults.withCredentials = true

    $stateProvider
      .state 'index',
        url: '/'
        controller: 'AppCtrl'
        templateUrl: 'index.html'
      .state 'projects',
        url: '/projects'
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

angular.module 'Todo', ['ui.router','templates','Devise']

angular.module 'Todo'
  .config ['$stateProvider', '$urlRouterProvider', '$httpProvider', TodoConfig ]  