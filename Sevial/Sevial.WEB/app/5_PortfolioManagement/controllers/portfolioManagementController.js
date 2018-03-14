'use strict';
portfolioManagementModule
    .controller('portfolioManagement.portfolioManagementController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading',
        'CommonConstants', 'SecurityServices', 'SessionServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading,
            CommonConstants, SecurityServices, SessionServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.login = {};

            // Publicación de las funciones por medio de la variable self
            self.init = init;
            self.submit = submit;

            // Funciones
            function init() {
            }

            function submit() {
            }

            // Helpers
            function getCtrlName() {
                return "portfolioManagement.portfolioManagementController";
            }
        }
    ]);