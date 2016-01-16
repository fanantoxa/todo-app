angular.module 'Todo'
  .directive 'todoFocus', ($timeout) ->
    (scope, elem, attrs) ->
      scope.$watch attrs.todoFocus, (newVal) ->
        if (newVal)
          $timeout () ->
            elem[0].focus()
          , 0, false