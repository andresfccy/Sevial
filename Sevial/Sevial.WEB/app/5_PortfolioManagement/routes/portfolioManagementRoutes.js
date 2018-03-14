'use strict';
portfolioManagementModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('portfolioManagement', {
                url: '/ManejoCartera',
                template: '<div ui-view></div>',
                abstract: true,
                resolve: {
                    //"check": function (SessionServices, $location, loading, growl) {
                    //    if (!SessionServices.isLoggedIn()) {
                    //        $location.path("/Home");
                    //        growl.info("¡Bienvenido de nuevo!");
                    //    }
                    //    SessionServices.authorized("login");
                    //}
                }
            })
            .state('portfolioManagement.home', {
                url: '/Inicio',
                templateUrl: 'app/5_PortfolioManagement/views/5_index.html',
                resolve: {
                    //"check": function (SessionServices, $location, loading, growl) {
                    //    if (!SessionServices.isLoggedIn()) {
                    //        $location.path("/Home");
                    //        growl.info("¡Bienvenido de nuevo!");
                    //    }
                    //    SessionServices.authorized("login");
                    //}
                }
            })
    }
]);