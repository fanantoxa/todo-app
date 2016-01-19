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
        templateUrl: 'project/template.html'
      .state 'login',
        url: '/login'
        controller:  'LoginCtrl'
        templateUrl: 'auth/login.html'
      .state 'registration',
        url: '/registration'
        controller:  'RegistrationCtrl'
        templateUrl: 'auth/registration.html'  

angular.module 'Todo', ['ui.bootstrap', 'ui.router', 'templates', 'Devise', 'ngResource']

angular.module 'Todo'
  .config ['$stateProvider', '$urlRouterProvider', '$httpProvider', TodoConfig ]  