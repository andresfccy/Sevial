'use strict';
portfolioManagementModule
    .controller('portfolioManagement.transferDetailController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading', 'moment',
        'CommonConstants', 'PortfolioManagementServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading, moment,
            CommonConstants, PortfolioManagementServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;
            var selId;

            // Publicación de variables por medio de la variable self
            self.dateOptions = {
                formatYear: 'yy',
                maxDate: new Date(2020, 5, 22),
                minDate: new Date(2000, 1, 1),
                startingDay: 1
            };

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.prepareEdit = prepareEdit;
            self.openCal = openCal;
            self.getListPortfolio = getListPortfolio;
            self.updatePortfolio = updatePortfolio;


            // Funciones
            function init() {
                getListPortfolio();
            }

            function getListPortfolio() {
                var id = $location.path().split('/')[4];
                if (id) {
                    selId = id;
                    var actionName = getCtrlName() + ".getDetailPortfolio()"
                    var req = {
                        aliasUsuario: CommonConstants.username,
                        idRegistro: id,
                        filtro: self.filtro
                    };
                    loading.startLoading(actionName);
                    var p = PortfolioManagementServices.getDetailPortfolio(req).$promise;
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
                } else {
                    $state.go("portfolioManagement.transfer");
                }
            }

            function prepareEdit(o) {
                self.isEditing = true;
                self.edit = angular.copy(o);
                self.edit.A052_fechaInicial = moment(self.edit.A052_fechaInicial, 'YYYY/MM/DD').toDate();
                self.edit.A052_fechaFinal = moment(self.edit.A052_fechaFinal, 'YYYY/MM/DD').toDate();
            }

            function openCal(i) {
                self.popup = self.popup || [];
                self.popup[i] = !self.popup[i];
            }

            function updatePortfolio() {
                console.log(selId);
                if (selId) {
                    var actionName = getCtrlName() + ".updateDetailPortfolio()"
                    var req = {
                        aliasUsuario: CommonConstants.username,
                        idRegistro: self.edit.A052_codigo,
                        fechaInicial: moment(self.edit.A052_fechaInicial).format('YYYYMMDD'),
                        fechaFinal: moment(self.edit.A052_fechaFinal).format('YYYYMMDD'),
                        estadoMunicipio: self.edit.A052_estadoRegistro,
                        observacion: self.edit.A052_observacion
                    };
                    loading.startLoading(actionName);
                    var p = PortfolioManagementServices.updateDetailPortfolio(req).$promise;
                    p.then(function (result) {
                        if (result.CodigoRpta == 0) {
                            getListPortfolio();
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
                } else {
                    growl.warning("Ocurrió un problema con el Id del registro que se quería modificar.");
                    $state.go("portfolioManagement.transfer");
                }
            }

            // Helpers
            function getCtrlName() {
                return "portfolioManagement.transferController";
            }
        }
    ]);