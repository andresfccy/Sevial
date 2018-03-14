'use strict';
accountModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('login', {
                url: '/',
                templateUrl: 'app/account/views/login.html',
                controller: 'account.accountController as accCtrl',
                resolve: {
                    "check": function (SessionServices, $location, loading, growl) {
                        if (SessionServices.isLoggedIn()) {
                            $location.path("/Home");
                            growl.info("¡Bienvenido de nuevo!");
                        }
                        //SessionServices.authorized("login");
                    }
                }
            })
    }
]);