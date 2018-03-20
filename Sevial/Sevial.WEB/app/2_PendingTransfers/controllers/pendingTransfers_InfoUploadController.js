'use strict';
pendingTransfersModule
    .controller('pendingTransfers.pendingTransfersInfoUploadController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading',
        'CommonConstants', 'SessionServices', 'CommonServices', 'PendingTransfersServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading,
            CommonConstants, SessionServices, CommonServices, PendingTransfersServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.uploadTypes = [];
            self.states = [];
            self.files = [];
            self.selectedFiles = [];

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.showReason = showReason;
            self.selectFile = selectFile;
            self.filterTable = filterTable;
            self.submit = submit;


            // Funciones públicas
            function init() {
                // Traer tipos de cargue
                var actionName = getCtrlName() + ".getList(TIPO_CARGUE)"
                loading.startLoading(actionName);
                var req = {
                    NomCategoria: CommonConstants.TIPO_CARGUE,
                    Filtro: "",
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = CommonServices.getList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.uploadTypes = result.Lista;
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });

                // Traer estados de cargue
                var actionName = getCtrlName() + ".getList(ESTADO_CARGUE)"
                loading.startLoading(actionName);
                var req = {
                    NomCategoria: CommonConstants.ESTADO_CARGUE,
                    Filtro: "",
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = CommonServices.getList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.states = result.Lista;
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });

                getFiles();
            }

            function showReason(obj) {
                obj.showReason = !obj.showReason
            }

            function selectFile(obj) {
                obj.seleccionado = !obj.seleccionado;

                var idx = self.selectedFiles.indexOf(obj);
                if (idx < 0) {
                    self.selectedFiles.push(obj);
                } else {
                    self.selectedFiles.splice(idx, 1);
                }
            }

            function filterTable() {
                getFiles();
            }

            function submit() {
                var actionName = getCtrlName() + ".proccessFiles()"
                loading.startLoading(actionName);
                var req = {
                    ListaProcesar: self.selectedFiles.map(function (o) { return o.idTipoCargue + ',' + o.idArchivo; }).join(';'),
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = PendingTransfersServices.proccessFiles(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        growl.success(result.MensajeRpta);
                        getFiles();
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

            // Funciones privadas
            function getFiles() {
                // Traer archivos
                var actionName = getCtrlName() + ".getUploadFiles()"
                loading.startLoading(actionName);
                var req = {
                    IdTipoCargue: self.uploadType,
                    IdEstadoCargue: self.state,
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = PendingTransfersServices.getUploadFiles(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.files = result.Lista;
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

            // Helpers
            function getCtrlName() {
                return "pendingTransfers.pendingTransfersInfoUploadController";
            }
        }
    ]);