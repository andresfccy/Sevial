'use strict';
rightToPetitionModule
    .controller('rightToPetition.rightToPetitionController',
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
            self.$onInit = init;
            self.submit = submit;

            // Funciones
            function init() {
                var mod = SessionServices.getValueFromStorage(CommonConstants.MODULES_KEY).find(function (o) { return o.url == $state.current.name });
                var actionName = getCtrlName() + ".getOptionsByUser"
                loading.startLoading(actionName);
                var req = { IdModulo: mod.id, AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY) };
                console.log(req);
                var p = SecurityServices.getOptionsByUser(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        console.log(result);
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });
            }

            function submit() {
            }

            // Helpers
            function getCtrlName() {
                return "rightToPetition.rightToPetitionController";
            }
        }
    ]);