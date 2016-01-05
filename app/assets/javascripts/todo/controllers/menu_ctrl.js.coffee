class MenuCtrl
  constructor: (@$scope, @$location, @$rootScope, @Auth) ->
    this.checkLogin()
    angular.forEach ['devise:login','devise:logout','devise:new-registration'], 
      (value) => @$rootScope.$on value, => this.checkLogin()

    @$scope.logout = this.logout

  checkLogin: ->
    @$scope.logged_in = @Auth.isAuthenticated()

  logout: =>
    config = { headers: { 'X-HTTP-Method-Override': 'DELETE' }}
    @Auth.logout(config).then (oldUser) =>
      @$location.path '/login'
    , (error) =>
      @$location.path '/'

angular.module "Todo"
  .controller "MenuCtrl", ['$scope', '$location', '$rootScope', 'Auth', MenuCtrl]