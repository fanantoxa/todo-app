#= require spec_helper

describe 'MenuCtrl', ->
  beforeEach ->
    @$controller 'MenuCtrl',
      $scope: @$scope
      $location: @$location
      $rootScope: @$rootScope
      Auth: @Auth

  describe 'when authenticated', ->

    it 'should set loged_in', ->
      expect(@$scope.logged_in).toBe(@isAuthenticated)

    describe 'should listen Auth events and update loged_in', ->
      beforeEach ->
        @Auth.isAuthenticated.and.returnValue(false)

      it 'when devise:login', ->
        @$rootScope.$broadcast('devise:login')
        expect(@$scope.logged_in).toBe(false)

      it 'when devise:logout', ->
        @$rootScope.$emit('devise:logout')
        expect(@$scope.logged_in).toBe(false)

      it 'when devise:new-registration', ->
        @$rootScope.$emit('devise:new-registration')
        expect(@$scope.logged_in).toBe(false)

    describe '#logout', ->
      describe 'when success', ->
        beforeEach ->
          @Auth.logout.and.returnValue(then: (resolve, reject) => resolve())
          @$scope.logout()

        it 'should call logout', ->
          expect(@Auth.logout).toHaveBeenCalledWith({ headers: { 'X-HTTP-Method-Override': 'DELETE' }})

        it 'on success should redirect to login page', ->
          expect(@$location.path).toHaveBeenCalledWith('/login')

      describe 'when fail', ->
        beforeEach ->
          @Auth.logout.and.returnValue(then: (resolve, reject) => reject())
          @$scope.logout()

        it 'on fails should redirect to main page', ->
          @Auth.logout.and.returnValue(then: (resolve, reject) => reject())
          expect(@$location.path).toHaveBeenCalledWith('/')