'use strict';
pendingTransfersModule
    .controller('pendingTransfers.pendingTransfersController',
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
            self.options = [];

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.submit = submit;

            // Funciones
            function init() {
                //if (isHome()) {
                //    $state.go("pendingTransfers.infoUpload");
                //}

                var mod = SessionServices.getValueFromStorage(CommonConstants.MODULES_KEY).find(function (o) { return o.url.split('.')[0] == $state.current.name.split('.')[0] }) || {};
                var actionName = getCtrlName() + ".getOptionsByUser"
                loading.startLoading(actionName);
                var req = {
                    IdModulo: mod.id,
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                console.log(req);
                var p = SecurityServices.getOptionsByUser(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        CommonConstants.menu = result.Lista.reduce(function (p, o, i) {
                            p[o.A005_menu] = p[o.A005_menu] || { id: o.A005_menu, name: o.A004_nombre };
                            p[o.A005_menu].options = p[o.A005_menu].options || [];
                            p[o.A005_menu].options.push({ id: o.A005_codigo, name: o.A005_nombre, url: o.A005_url });
                            return p;
                        }, []).filter(function (o1) { return o1 != null; });
                        CommonConstants.rebuild = true;
                        console.log(CommonConstants.menu);
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
                return "pendingTransfers.pendingTransfersController";
            }

            function isHome() {
                if ($location.url() == "/TransferenciasPendientes/Inicio") return true;
            }
        }
    ]);