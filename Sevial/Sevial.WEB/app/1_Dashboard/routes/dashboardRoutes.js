'use strict';
dashboardModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('home', {
                url: '/Home',
                breadcrumb: 'Dashboard',
                templateUrl: 'app/1_dashboard/views/1_index.html',
                controller: 'dashboard.dashboardController as dshCtrl',
                resolve: {
                    check: ['$timeout', '$state', '$q', 'SessionServices', 'loading', 'growl',
                        function ($timeout, $state, $q, SessionServices, loading, growl) {
                            if (SessionServices.isLoggedIn()) {
                                if (!SessionServices.authorized("/Dashboard"))
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