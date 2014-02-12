app.controller('WeightsCtrl', ['$scope', '$resource', function($scope, $resource) {
  var Weights = $resource('/api/weights');
  $scope.weights = Weights.query();
}]);