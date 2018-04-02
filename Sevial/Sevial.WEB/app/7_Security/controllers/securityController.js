'use strict';
securityModule
    .controller('security.securityController',
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
            self.logout = logout;

            // Funciones
            function init() {
                // TODO: something at init
            }

            function submit() {
                // Do login
                var actionName = getCtrlName() + ".login"
                loading.startLoading(actionName);
                //var req = ""
                //    + "grant_type=password"
                //    + "&clientAppType=INS"
                //    + "&username=" + self.login.username
                //    + "&password=" + self.login.password;
                var req = {
                    AliasUsuario: self.login.username,
                    Clave: self.login.password
                };
                var p = SecurityServices.login(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta === 0) {
                        //OK
                        // Save info to storage
                        SessionServices.setValueToStorage(CommonConstants.TOKEN_KEY, result.Lista[0].A001_codigo);
                        SessionServices.setValueToStorage(CommonConstants.USER_ID_KEY, result.Lista[0].A001_aliasUsuario);
                        CommonConstants.username = result.Lista[0].A001_aliasUsuario;

                        $state.go("home");
                        growl.success("¡Autenticación correcta!");
                    } else {
                        growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });
            }

            function logout() {
                SessionServices.removeAllInfoFromLocalStorage();
                growl.warning("Sesión finalizada, ¡Hasta pronto!");
                $state.go("login");
            }

            // Helpers
            function getCtrlName() {
                return "security.securityController";
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