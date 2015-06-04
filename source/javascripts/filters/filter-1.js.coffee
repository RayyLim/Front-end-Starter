_ = require 'angular/angular'

m = angular.module 'filter1', []

m.filter 'filter11', ->
  (x) -> x