'use strict';
correspondenceControlModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('correspondenceControl', {
                url: '/ControlCorrespondencia',
                breadcrumb: 'Control de correspondencia',
                template: '<div ui-view></div>',
                abstract: true,
                //resolve: {
                //    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                //        function ($timeout, $state, $q, SessionServices, loading, growl) {
                //            if (SessionServices.isLoggedIn()) {
                //                if (SessionServices.authorized("/ControlCorrespondencia"))
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
            .state('correspondenceControl.home', {
                url: '/Inicio',
                templateUrl: 'app/4_CorrespondenceControl/views/4_index.html',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/ControlCorrespondencia"))
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