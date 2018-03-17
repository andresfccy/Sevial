'use strict';
portfolioManagementModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('portfolioManagement', {
                url: '/ManejoCartera',
                breadcrumb: 'Manejo de cartera',
                template: '<div ui-view></div>',
                abstract: true,
                //resolve: {
                //    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                //        function ($timeout, $state, $q, SessionServices, loading, growl) {
                //            if (SessionServices.isLoggedIn()) {
                //                if (!SessionServices.authorized("/ManejoCartera"))
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
            .state('portfolioManagement.home', {
                url: '/Inicio',
                templateUrl: 'app/5_PortfolioManagement/views/5_index.html',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/ManejoCartera"))
                                    return $q.reject();
                            } else {
                                $timeout(function () {
                                    growl.warning("Sesión caducada");
                                    $state.go('login');
                                }, 0);
                                return $q.reject();
                            }
                        }
                    ]
                }
            })
    }
]);