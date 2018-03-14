'use strict';
securityModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('security', {
                url: '/Seguridad',
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
            .state('security.home', {
                url: '/Inicio',
                templateUrl: 'app/7_security/views/7_index.html',
                controller: 'security.securityController as secCtrl',
                resolve: {
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
                                $timeout(function () {
                                    growl.info("¡Bienvenido de nuevo!");
                                    $state.go('home');
                                }, 0);
                                return $q.reject();
                            }
                            //SessionServices.authorized("login");
                        }
                    ]
                }
            })
    }
]);