'use strict';
pendingTransfersModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('pendingTransfers', {
                url: '/TransferenciasPendientes',
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
            .state('pendingTransfers.home', {
                url: '/Inicio',
                templateUrl: 'app/2_pendingTransfers/views/2_index.html',
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