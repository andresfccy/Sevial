'use strict';
portfolioManagementModule
    .controller('portfolioManagement.transferController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading', 'moment',
        'CommonConstants', 'PortfolioManagementServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading, moment,
            CommonConstants, PortfolioManagementServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.dateOptions = {
                formatYear: 'yy',
                maxDate: new Date(2020, 5, 22),
                minDate: new Date(2000, 1, 1),
                startingDay: 1
            };

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.submit = submit;
            self.openNew = openNew;
            self.prepareEdit = prepareEdit;
            self.deletePortfolio = deletePortfolio;
            self.openCal = openCal;
            self.updatePortfolio = updatePortfolio;

            // Funciones
            function init() {
                getListPortfolio();
            }

            function getListPortfolio() {
                var actionName = getCtrlName() + ".getListPortfolio()"
                var req = {
                    aliasUsuario: CommonConstants.username
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.getListPortfolio(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.portfolio = result.Lista;
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

            function prepareEdit(o) {
                self.isEditing = true;
                self.edit = angular.copy(o);
            }

            function openNew(o) {
                self.isEditing = false;
            }

            function deletePortfolio(o) {
                var actionName = getCtrlName() + ".deletePortfolio()"
                var req = {
                    aliasUsuario: CommonConstants.username,
                    idRegistro: o.A051_codigo
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.deletePortfolio(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        growl.success(result.MensajeRpta);
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

            function updatePortfolio() {
                var actionName = getCtrlName() + ".updatePortfolio()"
                var req = {
                    aliasUsuario: CommonConstants.username,
                    idRegistro: 0,
                    fechaInicial: moment(self.edit.A051_fechaInicial).format('YYYYMMDD'),
                    fechaFinal: moment(self.edit.A051_fechaFinal).format('YYYYMMDD')
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.updatePortfolio(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        growl.success(result.MensajeRpta);
                        getListPortfolio();
                        $('#editTransfer').modal('toggle');
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

            // Helpers
            function getCtrlName() {
                return "portfolioManagement.transferController";
            }
        }
    ]);