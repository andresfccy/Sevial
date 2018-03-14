'use strict';
sysParametersModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('sysParameters', {
                url: '/ParametrosSistema',
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
            .state('sysParameters.home', {
                url: '/Inicio',
                templateUrl: 'app/6_SysParameters/views/6_index.html',
                resolve: {

                }
            });
    }
]);