FKLS_TASKS = 'fkls_tasks'

app = angular.module('fkls', ['ionic'])
app.filter 'orderByPriority', ->
  (items) ->
    index = (a) ->
      "#{(if !a.done then '1' else '2')}-#{a.priority}-#{a.text}"
    items.sort (a, b) ->
      if index(a) > index(b) then 1 else -1

app.controller 'MainCtrl', ($scope, $window, $ionicPopover, util) ->
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
    $window.localStorage[FKLS_TASKS] = angular.toJson $scope.items
  $scope.$watch 'items', onChange, true

  # Color context badges based on hash of text
  $scope.colorcontext = (item) ->
    hashString = util.hashString
    if !item.context then return "#888"
    hashCode = hashString item.context
    hue = hashCode % 180 + 180
    "hsl(#{hue}, 50%, 50%"

  # Adding new items
  $scope.addItem = ->
    text = $scope.item
    item =
      text: text
      done: false
    parts = text.split ' '
    for part, index in parts
      if part[0] == '@'
        item.context = part
        parts.splice(index, 1)
        item.text = parts.join ' '
    $scope.item = ''
    $scope.items.push item

  # Deleting completed tasks
  $scope.cleanup = ->
    incomplete = (item for item in $scope.items when !item.done)
    $scope.items = incomplete
