angular.module 'Todo', ['ui.router','templates']

angular.module 'Todo'
  .config ($stateProvider, $urlRouterProvider) ->
    $urlRouterProvider.otherwise("/")
  