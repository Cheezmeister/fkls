FKLS_TASKS = 'fkls_tasks'

app = angular.module('fkls', ['ionic'])
app.filter 'orderByPriority', ->
  (items) ->
    items.sort (a, b) -> a.priority > b.priority ? 1 : -1

app.controller 'MainCtrl', ($scope, $window, $ionicPopover) ->
  $scope.platform = ionic.Platform.platform()
  
  # Read from local storage
  stored = $window.localStorage[FKLS_TASKS]
  if stored
    $scope.items = JSON.parse(stored)
  else
    $scope.items = [
      {done: true , text: 'one'}
      {done: false, text: 'two'}
      {done: true , text: 'three'}
    ]

  # Wire up the priority popover
  $ionicPopover.fromTemplateUrl(
    'templates/popover.html', scope: $scope
  ).then (popover) ->
    $scope.popover = popover
  $scope.priorityPopover = ($event, item) ->
    $scope.popover.show($event)
    $scope.applyPriority = (pri) ->
      item.priority = pri
      $scope.popover.hide()

  # Monitor items for changes, persist when modified
  onChange = ->
    console.log 'changed' + $scope.items.length
    $window.localStorage[FKLS_TASKS] = angular.toJson $scope.items
  $scope.$watch 'items', onChange, true
  
  # Adding new items
  $scope.addItem = ->
    text = $scope.item
    item =
      done: false
      text: text # document.getElementById('newTask').value
    parts = text.split ' '
    for part in parts
      if part[0] == '@'
        item.context = part
    $scope.item = ''
    $scope.items.push item

  # Delete completed tasks
  $scope.cleanup = ->
    incomplete = (item for item in $scope.items when !item.done)
    $scope.items = incomplete
