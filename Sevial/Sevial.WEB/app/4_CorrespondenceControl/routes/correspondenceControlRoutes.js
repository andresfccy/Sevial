'use strict';
correspondenceControlModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('correspondenceControl', {
                url: '/ControlCorrespondencia',
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
            .state('correspondenceControl.home', {
                url: '/Inicio',
                templateUrl: 'app/4_CorrespondenceControl/views/4_index.html',
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