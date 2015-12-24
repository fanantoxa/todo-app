class MenuCtrl
  constructor: ($scope, $location, $rootScope, Auth) ->
    $rootScope.$on 'devise:login', (event, args) -> checkLogin()
    $rootScope.$on 'devise:logout', (event, args) -> checkLogin()

    $scope.logout = ->
      config = { headers: { 'X-HTTP-Method-Override': 'DELETE' }}
      Auth.logout(config).then (oldUser) ->
        $location.path '/login'
      , (error) ->
        $location.path '/'

    checkLogin = ->
      $scope.logged_in = Auth.isAuthenticated()

angular.module "Todo"
  .controller "MenuCtrl", ['$scope', '$location', '$rootScope', 'Auth', MenuCtrl]