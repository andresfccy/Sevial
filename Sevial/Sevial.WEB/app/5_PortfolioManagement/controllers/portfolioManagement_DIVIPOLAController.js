'use strict';
portfolioManagementModule
    .controller('portfolioManagement.DIVIPOLAController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading',
        'CommonConstants', 'PortfolioManagementServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading,
            CommonConstants, PortfolioManagementServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.login = {};
            self.isEditing = false;
            self.citiesToRemove = [];
            self.citiesToAdd = [];

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.prepareEdit = prepareEdit;
            self.openNew = openNew;
            self.selectCity = selectCity;
            self.moveCities = moveCities;
            self.updateList = updateList;

            // Funciones
            function init() {
                getListDptos();
            }

            function getListDptos() {
                var actionName = getCtrlName() + ".getListDptos()"
                var req = {
                    aliasUsuario: CommonConstants.username
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.getListDptos(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.dptos = result.Lista;
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

            function updateList() {
                var actionName = getCtrlName() + ".updateList()";
                var citiesString = self.cities.map(function (o) { return o.A013_codigo; });
                var listaFormateada = citiesString.join(";");

                var req = {
                    aliasUsuario: CommonConstants.username,
                    departamental: self.edit.A016_codigo,
                    nombre: self.edit.A016_nombre,
                    divipola: self.edit.A016_divipola,
                    listaMunicipios: listaFormateada
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.updateList(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        growl.success(result.MensajeRpta);
                        $('#editDpto').modal('toggle');
                        getListDptos();
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

            function prepareEdit(o) {
                self.isEditing = true;
                self.edit = angular.copy(o);
                self.citiesToAdd = [];
                self.citiesToRemove = [];

                var actionName = getCtrlName() + ".getListAvailableCitiesByDpto()"
                var req = {
                    aliasUsuario: CommonConstants.username,
                    departamental: self.edit.A016_codigo ? self.edit.A016_codigo : 0
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.getListAvailableCitiesByDpto(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.availableCities = result.Lista;
                    } else {
                        growl.warning(result.MensajeRpta);
                    }
                    loading.stopLoading(actionName);
                }).catch(function (error) {
                    growl.error("Ocurrió un error");
                    console.log(error);
                    loading.stopLoading(actionName);
                });

                var actionName = getCtrlName() + ".getListCitiesByDpto()"
                var req = {
                    aliasUsuario: CommonConstants.username,
                    departamental: self.edit.A016_codigo ? self.edit.A016_codigo : 0
                };
                loading.startLoading(actionName);
                var p = PortfolioManagementServices.getListCitiesByDpto(req).$promise;
                p.then(function (result) {
                    if (result.CodigoRpta == 0) {
                        self.cities = result.Lista;
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

            function openNew() {
                self.isEditing = false;
            }

            function selectCity(o, i) {
                switch (i) {
                    case 0:
                        var idx = -1;
                        if (self.citiesToAdd.find(function (o1, i1) { if (o1.A013_codigo == o.A013_codigo) { idx = i1; return true; } })) {
                            self.citiesToAdd.splice(idx, 1);
                        } else {
                            self.citiesToAdd.push(o);
                        }
                        break;
                    case 1:
                        var idx = -1;
                        if (self.citiesToRemove.find(function (o1, i1) { if (o1.A013_codigo == o.A013_codigo) { idx = i1; return true; } })) {
                            self.citiesToRemove.splice(idx, 1);
                        } else {
                            self.citiesToRemove.push(o);
                        }
                        break;
                }
                o.selected = !o.selected;
            }

            function moveCities(i) {
                switch (i) {
                    case 0:
                        for (var k = 0; k < self.citiesToAdd.length; k++) {
                            self.citiesToAdd[k].selected = false;
                            var idx = -1;
                            console.log(self.citiesToAdd[k]);
                            self.availableCities.find(function (o1, i1) { if (o1.A013_codigo == self.citiesToAdd[k].A013_codigo) { idx = i1; return true; } });
                            self.availableCities.splice(idx, 1);
                            self.cities.push(self.citiesToAdd[k]);
                        }
                        self.citiesToAdd = [];
                        self.citiesToRemove = [];
                        break;
                    case 1:
                        for (var k = 0; k < self.citiesToRemove.length; k++) {
                            self.citiesToRemove[k].selected = false;
                            var idx = -1;
                            self.cities.find(function (o1, i1) { if (o1.A013_codigo == self.citiesToRemove[k].A013_codigo) { idx = i1; return true; } });
                            self.cities.splice(idx, 1);
                            self.availableCities.push(self.citiesToRemove[k]);
                        }
                        self.citiesToAdd = [];
                        self.citiesToRemove = [];
                        break;
                }
            }

            // Helpers
            function getCtrlName() {
                return "portfolioManagement.DIVIPOLAController";
            }
        }
    ]);