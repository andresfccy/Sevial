'use strict';
pendingTransfersModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('pendingTransfers', {
                url: '/TransferenciasPendientes',
                breadcrumb: 'Transferencias pendientes',
                controller: 'pendingTransfers.pendingTransfersController',
                template: '<div ui-view></div>',
                abstract: true,
                //resolve: {
                //    "check": function (SessionServices, $location, loading, growl) {
                //        if (!SessionServices.isLoggedIn()) {
                //            $location.path("/Home");
                //            growl.info("¡Bienvenido de nuevo!");
                //        }
                //        SessionServices.authorized("login");
                //    }
                //}
            })
            .state('pendingTransfers.home', {
                url: '/Inicio',
                templateUrl: 'app/2_pendingTransfers/views/2_index.html',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/TransferenciasPendientes"))
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
            .state('pendingTransfers.infoUpload', {
                url: '/CargueInformacion',
                breadcrumb: 'Carga de información',
                templateUrl: 'app/2_pendingTransfers/views/2_infoUpload.html',
                controller: 'pendingTransfers.pendingTransfersInfoUploadController as PTInfoUpCtrl',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/CargueInformacion"))
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
            .state('pendingTransfers.editLocalCollection', {
                url: '/EdicionRecaudo',
                breadcrumb: 'Editar recaudo local',
                templateUrl: 'app/2_pendingTransfers/views/2_editLocalColl.html',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/EdicionRecaudo"))
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