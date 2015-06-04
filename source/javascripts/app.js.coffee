#= require angular/angular
#= require angular-route/angular-route
#= require ./directives/directives
#= require ./services/services
#= require ./filters/filters

#= require ./routes/index-route

console.log("hello ray")

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