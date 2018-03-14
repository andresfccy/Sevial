'use strict';
dashboardModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('home', {
                url: '/Home',
                templateUrl: 'app/1_dashboard/views/1_index.html',
                controller: 'dashboard.dashboardController as dshCtrl',
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