angular.module 'Todo'
  .directive 'todoEscape', () ->
    ESCAPE_KEY = 27

    (scope, elem, attrs) ->
      elem.bind 'keydown', (event) ->
        if (event.keyCode === ESCAPE_KEY)
          scope.$apply(attrs.todoEscape)

      scope.$on '$destroy', () ->
        elem.unbind('keydown')
