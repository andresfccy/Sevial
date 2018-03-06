'use strict';
accountModule
    .controller('account.accountController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading',
        'CommonConstants', 'AccountServices', 'SessionServices',
    function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
        growl, loading,
        CommonConstants, AccountServices, SessionServices) {

        // Instancia del controlador dentro de la variable self
        var self = this;

        // Publicación de variables por medio de la variable self
        self.login = {};

        // Publicación de las funciones por medio de la variable self
        self.init = init;
        self.submit = submit;

        // Funciones
        function init() {
            // TODO: something at init
        }

        function submit() {
            // Obtener lista de horarios
            loading.startLoading(getCtrlName() + ".getValidationCode");
            var req = {
                username: self.login.username
            };
            var p = AccountServices.getValidationCode(req).$promise;
            p.then(function (resultGetValidationCode) {
                if (resultGetValidationCode.estado) {
                    growl.info("Validando información");
                    self.login.codigoValidacion = resultGetValidationCode.codigo;

                    // -------------------------------------------
                    // TODO: Implementar validación con Sirius
                    // -------------------------------------------
                    // Do login
                    loading.startLoading(getCtrlName() + ".token");
                    var req = "grant_type=password&clientAppType=INS"
                        + "&username=" + self.login.username
                        + "&password=" + self.login.password
                        + "&codigoValidacion=" + self.login.codigoValidacion;
                    var p = AccountServices.login(req).$promise;
                    p.then(function (resultLogin) {

                        SessionServices.setTokenToLocalStorage(resultLogin.access_token);
                        SessionServices.setUserIdToLocalStorage(resultLogin.userName);

                        // -------------------------------------------
                        // TODO: Guardar en el local storage el resto de información útil, requerida para comprobar sesión
                        // -------------------------------------------

                        $state.go("home");

                        growl.success("¡Autenticación correcta!");
                        loading.stopLoading(getCtrlName() + ".token");
                    }).catch(function (error) {
                        if (error.data && error.data.error && error.data.error_description) {
                            growl.error(error.data.error_description);
                        }
                        else {
                            console.log("error", error);
                            growl.error("¡Oops!, Ocurrió un error, por favor contacta con el administrador del sistema.");
                        }
                        loading.stopLoading(getCtrlName() + ".token");
                    });

                } else {
                    growl.error("Error: " + resultGetValidationCode.mensaje);
                }
                loading.stopLoading(getCtrlName() + ".getValidationCode");
            }).catch(function (error) {
                console.log("error", error);
                growl.error("¡Oops!, Ocurrió un error, por favor contacta con el administrador del sistema.");
                loading.stopLoading(getCtrlName() + ".getValidationCode");
            });

            //$state.go("administrativeHome");
        }
        
        // Helpers
        function getCtrlName() {
            return "account.accountController";
        }

        function isHome() {
            if (!$location.path().split('/')[1] && $location.path().split('/')[1] == '') {
                return true;
            }
            return false;
        }

        //Simular defer para mostrar el símbolo de carga
        //loading.stopLoading(getCtrlName());
        //$timeout(function () { loading.stopLoading(getCtrlName()); }, 2000);
    }
    ]);