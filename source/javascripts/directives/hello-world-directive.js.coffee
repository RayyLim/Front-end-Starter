_ = require 'angular/angular'

console.log("K 1")
m = angular.module 'helloWorld1', []

m.directive 'helloWorld', ->
  restrict: 'AE'
  replace: true
  templateUrl: 'templates/directives/hello-world.html'