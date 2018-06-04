'use strict';
portfolioManagementModule
    .controller('portfolioManagement.calculateTransfersController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading', 'moment',
        'CommonConstants', 'SessionServices', 'CommonServices', 'PendingTransfersServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading, moment,
            CommonConstants, SessionServices, CommonServices, PendingTransfersServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self
            self.general = {};
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


            // Funciones públicas
            function init() {
                self.general.CorteAnterior = new Date();
                self.process.Porcentaje = 0;
            }

            function prepareEdit(obj) {

            }

            function submit() {
                
            }

            function deleteObj(o) {
                
            }

            function openCal(i) {
                self.popup = self.popup || [];
                self.popup[i] = !self.popup[i];
            }

            function getCutDate() {
                return moment(self.general.CorteAnterior);
            }

            // Funciones privadas
            function getTransfers() {
                
            }

            // Helpers
            function getCtrlName() {
                return "portfolioManagement.calculateTransfersController";
            }

            function cleanForm(editing) {

            }
        }
    ]);