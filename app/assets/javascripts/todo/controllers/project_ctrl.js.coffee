angular.module 'Todo'
  .controller 'ProjectCtrl', ($scope, $location, Auth) -> 
    Auth.currentUser().then (user) ->
      console.log "lalal"
    ,(error) ->
      $location.path '/login'