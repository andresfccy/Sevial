'use strict';
securityModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('security', {
                url: '/Seguridad',
                breadcrumb: 'Seguridad',
                template: '<div ui-view></div>',
                abstract: true,
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/Seguridad"))
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
            .state('security.home', {
                url: '/Inicio',
                templateUrl: 'app/7_security/views/7_index.html',
                controller: 'security.securityController as secCtrl',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/Inicio"))
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
            .state('login', {
                url: '/',
                templateUrl: 'app/7_security/views/7_login.html',
                controller: 'security.securityController as secCtrl',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("login"))
                                    return $q.reject();

                                return $timeout(function () {
                                    growl.info("¡Bienvenido de nuevo!");
                                    $state.go('home');
                                }, 0);
                            } 
                        }
                    ]
                }
            })
    }
]);