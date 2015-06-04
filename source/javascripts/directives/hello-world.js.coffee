#= require angular/angular
#= require ../services/services

m = angular.module 'helloWorld', []

m.directive 'helloWorldThing', ->
  controller: 'HelloWorldCtrl'
  restrict: 'E'
  replace: true
  scope:
    start: '='
    end: '='
    pageSize: '='
    loading: '='
    events: '='
  templateUrl: 'templates/directives/hello-world.html'

m.controller 'HelloWorldCtrl', ($rootScope, $scope) ->
  angular.extend $scope,
    yes: "no"