'use strict';
rightToPetitionModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('rightToPetition', {
                url: '/DerechosPeticion',
                breadcrumb: 'Derechos de petición',
                template: '<div ui-view></div>',
                controller: 'rightToPetition.rightToPetitionController',
                abstract: true,
                //resolve: {
                //    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                //        function ($timeout, $state, $q, SessionServices, loading, growl) {
                //            if (!SessionServices.isLoggedIn()) {
                //                if (!SessionServices.authorized("/DerechosPeticion"))
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
            .state('rightToPetition.home', {
                url: '/Inicio',
                templateUrl: 'app/3_rightToPetition/views/3_index.html',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/DerechosPeticion"))
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
            })
    }
]);