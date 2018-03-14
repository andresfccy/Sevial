'use strict';
accountModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('login', {
                url: '/',
                templateUrl: 'app/account/views/login.html',
                controller: 'account.accountController as accCtrl',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                $state.go("home");
                                growl.info("¡Bienvenido de nuevo!");
                            }
                            $timeout(function () {
                                $state.go('home');
                            }, 0);
                            return $q.reject()
                            //SessionServices.authorized("login");
                        }
                    ]
                }
            })
    }
]);