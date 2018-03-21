'use strict';
commonModule
    .controller('common.commonController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout',
        'growl', 'loading',
        'CommonConstants', 'SessionServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout,
            growl, loading,
            CommonConstants, SessionServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables
            self.appName = CommonConstants.appName;
            self.version = CommonConstants.version;
            self.copyright = CommonConstants.copyright;
            self.username = SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY) || "Dummy";
            self.role = CommonConstants.role || "Dummy Role";
            self.menu = [];

            $scope.$watch(angular.bind(CommonConstants.menu, function () {
                return CommonConstants.menu;
            }), function (newVal) {
                self.menu = newVal;
                });



            // Publicación de las funciones en el scope
            self.isLoggedIn = isLoggedIn;
            self.angularLoaded = angularLoaded;
            self.$onInit = init;

            // Funciones
            function init() {
                self.username = SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY) || "Dummy";
            }

            function isHome() {
                if (!$location.path().split('/')[1] && $location.path().split('/')[1] == 'Home') {
                    return true;
                }
                return false;
            }

            function getCtrlName() {
                return "common.commonController";
            }

            function isLoggedIn() {
                return SessionServices.isLoggedIn();
            }

            function angularLoaded() {
                return true;
            }

            //Simular defer para mostrar el símbolo de carga
            //loading.stopLoading(getCtrlName());
            //$timeout(function () { loading.stopLoading(getCtrlName()); }, 2000);
        }
    ]);