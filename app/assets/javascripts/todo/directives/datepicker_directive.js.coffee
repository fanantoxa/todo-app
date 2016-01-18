angular.module 'Todo'
  .directive 'theDatepicker', () ->
    {
      restrict: 'A'
      link: (scope, el, attr) ->
        el.datepicker {autoclose: true, clearBtn: true}
        component = el.siblings '[data-toggle="datepicker"]'
        if (component.length)
          component.on 'click', () ->
            el.trigger 'focus'
    }