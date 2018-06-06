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
            .state('portfolioManagement.calculate', {
                url: '/CalculoTransferenciasPendientes',
                breadcrumb: 'Cálculo transferencias pendientes',
                templateUrl: 'app/5_PortfolioManagement/views/5_1_calculate.html',
                controller: 'portfolioManagement.calculateTransfersController as CalcCtrl',
            })
            .state('portfolioManagement.transfer', {
                url: '/ParametrizacionEntrega',
                breadcrumb: 'Parametrización de entregas',
                templateUrl: 'app/5_PortfolioManagement/views/5_2_transfer.html',
                controller: 'portfolioManagement.transferController as TransCtrl',
            })
            .state('portfolioManagement.transferDetail', {
                url: '/ParametrizacionEntrega/Detalle/:id',
                breadcrumb: 'Detalle',
                templateUrl: 'app/5_PortfolioManagement/views/5_2_transfer.detail.html',
                controller: 'portfolioManagement.transferDetailController as TrDCtrl',
            })
            .state('portfolioManagement.divipola', {
                url: '/GestionDepartamentos',
                breadcrumb: 'Gestión departamental',
                templateUrl: 'app/5_PortfolioManagement/views/5_3_DIVIPOLA.html',
                controller: 'portfolioManagement.DIVIPOLAController as DiviCtrl',
            })
    }
]);