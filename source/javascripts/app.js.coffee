_ = require 'angular/angular'
_ = require 'angular-route/angular-route'
_ = require './directives/directives'
_ = require './services/services'
_ = require './filters/filters'

_ = require './routes/index-route'

console.log("hello ray 2")

m = angular.module 'helloApp', [
  'ngRoute'
  'directives'
  'services'
  'filters'
  'indexRoute'
]

routes = [
  path: ''
  templateName: 'index-route'
  controller: 'IndexCtrl'
]

m.config ($routeProvider) ->
  for route in routes
    console.log(route)
    $routeProvider.when "/#{route.path}",
      templateUrl: "templates/routes/#{route.templateName}.html"
      controller: route.controller
  $routeProvider.otherwise { redirectTo: '/' }
  console.log($routeProvider)