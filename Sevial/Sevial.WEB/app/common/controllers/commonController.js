'use strict';
commonModule
    .controller('common.commonController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout',
        'growl', 'loading',
        'CommonConstants',
        function ($scope, $state, $rootScope, $translate, $location, $timeout,
            growl, loading,
            CommonConstants) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Funciones
            function isHome() {
                if (!$location.path().split('/')[1] && $location.path().split('/')[1] == 'Home') {
                    return true;
                }
                return false;
            }

            function getCtrlName() {
                return "common.commonController";
            }

            //Simular defer para mostrar el símbolo de carga
            //loading.stopLoading(getCtrlName());
            //$timeout(function () { loading.stopLoading(getCtrlName()); }, 2000);
        }
    ]);