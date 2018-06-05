'use strict';
portfolioManagementModule
    .controller('portfolioManagement.calculateTransfersController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading', 'moment',
        'CommonConstants', 'SessionServices', 'CommonServices', 'PortfolioManagementServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading, moment,
            CommonConstants, SessionServices, CommonServices, PortfolioManagementServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.general = {};
            self.process = {};
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

            self.openCal = openCal;
            self.getCutDate = getCutDate;
            self.submitCalc = submitCalc;
            self.getPercentage = getPercentage;

            // Funciones públicas
            function init() {
                getPercentage();
                getControlDates();
            }

            function getControlDates() {
                var actionName = getCtrlName() + ".getControlDates()"
                var req = {
                    aliasUsuario: CommonConstants.username
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.getControlDates(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        if (result.Lista.length > 0) {
                            self.general = result.Lista[0];
                        }
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

            function getPercentage() {
                if (self.process.fechaProceso) {
                    var actionName = getCtrlName() + ".getPercentage()"
                    var req = {
                        aliasUsuario: CommonConstants.username,
                        fechaProceso: moment(self.process.fechaProceso).format("YYYYMMDD"), // aaaammdd
                        condicionProceso: self.process.condicionProceso // H: Históricos || A: Actualizados
                    };
                    loading.startLoading(actionName);
                    var p = PortfolioManagementServices.getPercentage(req).$promise;
                    p.then(function (result) {
                        if (result.CodigoRpta == 0) {
                            if (result.Lista.length > 0) {
                                self.process = result.Lista[0];
                            }
                        } else {
                            growl.warning(result.MensajeRpta);
                        }
                        loading.stopLoading(actionName);
                    }).catch(function (error) {
                        growl.error("Ocurrió un error");
                        console.log(error);
                        loading.stopLoading(actionName);
                    });
                } else {
                    self.process.nomEstadoProceso = "--";
                    self.process.porcProceso = 0;
                }
            }

            function submitCalc() {
                var actionName = getCtrlName() + ".submitCalc()"
                var req = {
                    aliasUsuario: CommonConstants.username,
                    fechaProceso: moment(self.process.fechaProceso).format("YYYYMMDD"), // aaaammdd
                    condicionProceso: self.process.condicionProceso // H: Históricos || A: Actualizados
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.submitCalc(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        growl.success(result.MensajeRpta);
                        getPercentage();
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

            function openCal(i) {
                self.popup = self.popup || [];
                self.popup[i] = !self.popup[i];
            }

            function getCutDate() {
                return self.general.fechaCorteAnterior;
            }

            // Helpers
            function getCtrlName() {
                return "portfolioManagement.calculateTransfersController";
            }
        }
    ]);