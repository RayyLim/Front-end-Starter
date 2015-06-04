#= require angular/angular
#= require ../services/services
#= require ../directives/directives


m = angular.module 'indexRoute', []

m.controller 'IndexCtrl', ($rootScope, $scope, $routeParams, $location) ->
  console.log("RAY 2")

  angular.extend $scope,
    goodbye: 'goodbye'