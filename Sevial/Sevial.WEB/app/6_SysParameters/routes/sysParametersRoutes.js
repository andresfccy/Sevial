'use strict';
sysParametersModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('sysParameters', {
                url: '/ParametrosSistema',
                breadcrumb: 'Parámetros del sistema',
                template: '<div ui-view></div>',
                abstract: true,
                //resolve: {
                //    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                //        function ($timeout, $state, $q, SessionServices, loading, growl) {
                //            if (SessionServices.isLoggedIn()) {
                //                if (!SessionServices.authorized("/ParametrosSistema"))
                //                    return $q.reject();

                //                $timeout(function () {
                //                    growl.info("¡Bienvenido de nuevo!");
                //                    $state.go('home');
                //                }, 0);
                //                return $q.reject();
                //            } else {
                //                $timeout(function () {
                //                    growl.warning("Sesión caducada");
                //                    $state.go('login');
                //                }, 0);
                //                return $q.reject();
                //            }
                //        }
                //    ]
                //}
            })
            .state('sysParameters.home', {
                url: '/Inicio',
                templateUrl: 'app/6_SysParameters/views/6_index.html',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/ParametrosSistema"))
                                    return $q.reject();
                            } else {
                                return $timeout(function () {
                                    growl.warning("Sesión caducada");
                                    $state.go('login');
                                }, 0);
                            }
                        }
                    ]
                }
            });
    }
]);