'use strict';
dashboardModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('home', {
                url: '/Home',
                templateUrl: 'app/dashboard/views/dashboard.html',
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
    }
]);