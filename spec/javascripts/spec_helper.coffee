#= require application
#= require angular-mocks

beforeEach angular.mock.module 'Todo'

beforeEach angular.mock.inject (_$controller_, $rootScope) ->
  @$controller = _$controller_
  @$rootScope = $rootScope.$new()

beforeEach ->
  @$scope = {}
  @$location = jasmine.createSpyObj('$location', ['path'])
  @isAuthenticated = true
  @currentUser = { name: 'test user' }
  currentUser =  then: (resolve, reject) =>
    if @currentUser then resolve() else reject() 
  @Auth = jasmine.createSpyObj('Auth', [
    'isAuthenticated',
    'currentUser',
    'logout',
    'login',
    'register'
    ])
  @Auth.isAuthenticated.and.returnValue(@isAuthenticated)
  @Auth.currentUser.and.returnValue(currentUser)
