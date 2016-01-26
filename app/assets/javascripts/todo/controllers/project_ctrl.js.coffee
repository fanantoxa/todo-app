class ProjectCtrl
  constructor: (@$scope, @$location, @Auth, @ProjectResource) ->
    @$location.path '/' unless @Auth.isAuthenticated()
    @$scope.projects_list = @ProjectResource.query()
    @$scope.edited_project = null

    @$scope.addProject = this.addProject
    @$scope.editProject = this.editProject
    @$scope.cancelEditing = this.cancelEditing
    @$scope.updateProject = this.updateProject
    @$scope.destroyProject = this.destroyProject

  addProject: (new_project) =>
    @ProjectResource.save(new_project)
      .$promise.then (project) =>
          @$scope.projects_list.push project
          @$scope.new_project = {}
      , (error) =>
        console.log 'error'

  editProject: (project) =>
    @$scope.edited_project = project
    @$scope.original_project = angular.extend({}, project)

  cancelEditing: (project) =>
    projects = @$scope.projects_list
    projects[projects.indexOf(project)] = @$scope.original_project
    @$scope.edited_project = null
    @$scope.original_project = null

  updateProject: (project) =>
    project.name = project.name.trim()

    if (project == @$scope.original_project)
      @$scope.edited_project = null
      return

    @ProjectResource.update(project)
      .$promise.then (project) => 
        @$scope.edited_project = null
      ,(error) =>
        project.name = @$scope.original_project.name

  destroyProject: (project) =>
    @ProjectResource.remove({ id: project.id })
      .$promise.then (result) =>
          index = @$scope.projects_list.indexOf(project)
          @$scope.projects_list.splice(index, 1)

angular.module 'Todo'
  .controller 'ProjectCtrl', [
    '$scope',
    '$location',
    'Auth',
    'ProjectResource',
    ProjectCtrl
  ]