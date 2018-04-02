'use strict';
dashboardModule
    .controller('dashboard.dashboardController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading',
        'CommonConstants', 'SecurityServices', 'SessionServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading,
            CommonConstants, SecurityServices, SessionServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.modules = [];

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.submit = submit;

            // Funciones
            function init() {
                var actionName = getCtrlName() + ".getModulesByUser"
                loading.startLoading(actionName);
                var req = {
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = SecurityServices.getModulesByUser(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.modules = result.Lista;
                        self.rows = Math.ceil(Math.sqrt(result.Lista.length));
                        self.modulesMatrix = listToMatrix(result.Lista, self.rows);
                        //self.col_md_n = "col-md-" + 12 / Math.ceil(Math.sqrt(result.Lista.length));

                        CommonConstants.menu = result.Lista.map(function (o) { return { id: o.A002_codigo, name:o.A002_nombre, url: o.A002_url }; })

                        SessionServices.setValueToStorage(CommonConstants.MODULES_KEY, result.Lista.map(function (o) { return { id:o.A002_codigo, url:o.A002_url };}));
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

            function submit() {
            }

            // Helpers
            function getCtrlName() {
                return "dashboard.dashboardController";
            }

            function listToMatrix(list, elementsPerSubArray) {
                var matrix = [], i, k;

                for (i = 0, k = -1; i < list.length; i++) {
                    if (i % elementsPerSubArray === 0) {
                        k++;
                        matrix[k] = [];
                    }

                    matrix[k].push(list[i]);
                }

                return matrix;
            }
        }
    ]);