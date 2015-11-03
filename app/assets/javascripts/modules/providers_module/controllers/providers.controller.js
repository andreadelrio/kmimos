providers_module.controller('ProvidersController', ['$scope', '$filter', 'ProviderService', 'ServiceService', function($scope, $filter, ProviderService, ServiceService) {


  $scope.search = {};

  $scope.search.locations = "";
  $scope.search.states = "";
  $scope.search.sizes = [];
  $scope.search.number_of;
  
  $scope.search.sel_service = [];

  $scope.providers;
  
  $scope.filteredProviders;
  
  ProviderService.get().$promise.then(function(providers){
    $scope.providers = providers;
  });
  
  $scope.map = { zoom: 16, control: {}, markers: []};

  $scope.map.markers = [];

  $scope.search.price = {
      min: 0,
      max: 1000,
      ceil: 1000,
      floor: 0
  };
  
  $scope.$watch('filteredProviders', function() {
    console.log("changed!");
    
    var temp_markers = [];
    var log = [];

    angular.forEach($scope.filteredProviders, function(provider, key) {
      console.log("quantity");
      temp_markers.push({latitude: provider.latitude, longitude: provider.longitude, id: provider.id, icon:'assets/huella-mensaje-17-mini.png' });
    }, log);

    $scope.map.markers = temp_markers;
  });

  $scope.onSliderChange = function(){
    
    $scope.search.price.min=$scope.priceSlider.min;
    $scope.search.price.max=$scope.priceSlider.max;
  }

  $scope.services = ServiceService.get();



}]);
