'use strict';
pendingTransfersModule
    .controller('pendingTransfers.pendingTransfersEditCollectionController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading', 'moment',
        'CommonConstants', 'SessionServices', 'CommonServices', 'PendingTransfersServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading, moment,
            CommonConstants, SessionServices, CommonServices, PendingTransfersServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.transfers = [];
            self.towns = [];
            self.banks = [];
            self.types = [];
            self.quantities = [];
            self.autorities = [];
            self.dateOptions = {
                formatYear: 'yy',
                maxDate: new Date(2020, 5, 22),
                minDate: new Date(2000, 1, 1),
                startingDay: 1
            };

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.filterTable = filterTable;
            self.editTransfer = editTransfer;
            self.submit = submit;
            self.deleteObj = deleteObj;
            self.cleanForm = cleanForm;

            self.openCal = openCal;


            // Funciones públicas
            function init() {
                // Traer municipios
                var actionName = getCtrlName() + ".getList(MUNICIPIO)"
                loading.startLoading(actionName);
                var req = {
                    NomCategoria: CommonConstants.MUNICIPIO,
                    Filtro: "",
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = CommonServices.getList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.towns = result.Lista;
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                    });

                // Traer bancos
                var actionName = getCtrlName() + ".getList(BANCO_CUENTA)"
                loading.startLoading(actionName);
                var req = {
                    NomCategoria: CommonConstants.BANCO_CUENTA,
                    Filtro: "",
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = CommonServices.getList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.banks = result.Lista;
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });

                // Traer tipos de transferencias
                var actionName = getCtrlName() + ".getList(TIPO_TRANSFERENCIA)"
                loading.startLoading(actionName);
                var req = {
                    NomCategoria: CommonConstants.TIPO_TRANSFERENCIA,
                    Filtro: "",
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = CommonServices.getList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.types = result.Lista;
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });

                // Traer cuantías
                var actionName = getCtrlName() + ".getList(CUANTIA)"
                loading.startLoading(actionName);
                var req = {
                    NomCategoria: CommonConstants.CUANTIA,
                    Filtro: "",
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = CommonServices.getList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.quantities = result.Lista;
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });

                // Traer autoridades
                var actionName = getCtrlName() + ".getList(AUTORIDAD_IMPOSICION)"
                loading.startLoading(actionName);
                var req = {
                    NomCategoria: CommonConstants.AUTORIDAD_IMPOSICION,
                    Filtro: "",
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = CommonServices.getList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.autorities = result.Lista;
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });

                getTransfers();
            }

            function filterTable() {
            }

            function editTransfer(obj) {
                //self.editingTransfer = true;
                //self.transferForm.$setPristine();
                //self.transferForm.$setUntouched();
                cleanForm(true);

                self.editTransfer = angular.copy(obj);
                self.editTransfer.A030_fechaInicio = new Date(self.editTransfer.A030_fechaInicio);
                self.editTransfer.A030_fechaFin = new Date(self.editTransfer.A030_fechaFin);
                self.editTransfer.A030_fechaTrf = new Date(self.editTransfer.A030_fechaTrf);
                self.editTransfer.A030_fechaCorte = new Date(self.editTransfer.A030_fechaCorte);
            }

            function submit() {
                // Guardar Cambios
                var actionName = getCtrlName() + ".editTransfer()"
                loading.startLoading(actionName);
                var req = {
                    IdRegistro: self.editTransfer.A030_codigo,
                    IdEstadoGestion: self.editTransfer.A030_estadoGestion,
                    IdMunicipio: self.editTransfer.A030_municipio,
                    VlrPagado: self.editTransfer.A030_vlrPagado,
                    IdCuantia: self.editTransfer.A030_cuantia,
                    VlrTrf45: self.editTransfer.A030_vlrTrf45,
                    VlrTrf10: self.editTransfer.A030_vlrTrf10,
                    FechaInicio: self.editTransfer.A030_fechaInicio,
                    FechaFin: self.editTransfer.A030_fechaFin,
                    Vigencia: self.editTransfer.A030_vigencia,
                    FechaTrf: self.editTransfer.A030_fechaTrf,
                    FechaCorte: self.editTransfer.A030_fechaCorte,
                    IdTipoTrf: self.editTransfer.A030_tipoTrf,
                    Observacion: self.editTransfer.A030_observacion,
                    BancoCuenta: self.editTransfer.A030_bancoCuenta,
                    IdAutoridadImposicion: self.editTransfer.A030_autoridadImposicion,
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = PendingTransfersServices.editTransfer(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        growl.success(result.MensajeRpta);
                        getTransfers();
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

            function deleteObj(o) {
                // Eliminar registro
                var actionName = getCtrlName() + ".deleteTransfer()"
                loading.startLoading(actionName);
                var req = {
                    IdRegistro: o.A030_codigo,
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = PendingTransfersServices.deleteTransfer(req).$promise;
                p.then(function(result) {
                    if (result.CodigoRpta == 0) {
                        growl.success(result.MensajeRpta);
                        getTransfers();
                    } else {
                        //growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function(error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });
            }

            function openCal(i) {
                //console.log(i)
                self.popup = self.popup || [];
                self.popup[i] = !self.popup[i];
            }

            // Funciones privadas
            function getTransfers() {
                // Traer archivos
                loading.startLoading(actionName);
                var actionName = getCtrlName() + ".getTransfers()"
                var req = {
                    AliasUsuario: SessionServices.getValueFromStorage(CommonConstants.USER_ID_KEY)
                };
                var p = PendingTransfersServices.getTransfers(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.transfers = result.Lista;
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
                return "pendingTransfers.pendingTransfersEditCollectionController";
            }

            function cleanForm(editing) {
                self.transferForm.$setPristine();
                self.transferForm.$setUntouched();
                self.editingTransfer = editing;
                self.editTransfer = {};
            }
        }
    ]);