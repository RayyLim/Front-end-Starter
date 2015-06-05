_ = require 'angular'
_ = require '../services/services'
_ = require '../directives/directives'


m = angular.module 'indexRoute', []

m.controller 'IndexCtrl', ($rootScope, $scope, $routeParams, $location) ->
  console.log("RAY 2")

  angular.extend $scope,
    goodbye: 'goodbye'