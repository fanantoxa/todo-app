app = angular.module('Todo', [
    'ui.router'
])

app.config(
  ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise("/")

    $stateProvider
      .state('index', {
        url: '/',
        controller: 'TestCtrl',
        templateUrl: 'index.html'
      })
  )