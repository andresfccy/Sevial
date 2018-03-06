'use strict';
commonModule.config(['$stateProvider',
    function ($stateProvider) {
        $stateProvider
            .state('403', {
                url: '/403',
                templateUrl: 'app/commons/views/403.html',
                controller: 'CommonsErrorController',
                resolve: {
                    $title: function () { return '¡Error!'; }
                }
            })
            .state('401', {
                url: '401',
                templateUrl: 'app/commons/views/401.html',
                controller: 'CommonsErrorController',
                resolve: {
                    $title: function () { return '¡Error!'; }
                }
            })
            .state('/500', {
                url: '/500',
                templateUrl: 'app/commons/views/500.html',
                controller: 'CommonsErrorController',
                resolve: {
                    $title: function () { return '¡Error!'; }
                }
            })
        ;
    }
]);