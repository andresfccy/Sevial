'use strict';
pendingTransfersModule
    .controller('pendingTransfers.pendingTransfersCalculateProcessController',
    ['$scope', '$state', '$rootScope', '$translate', '$location', '$timeout', '$q', '$http',
        'growl', 'loading', 'moment',
        'CommonConstants', 'SessionServices', 'CommonServices', 'PendingTransfersServices',
        function ($scope, $state, $rootScope, $translate, $location, $timeout, $q, $http,
            growl, loading, moment,
            CommonConstants, SessionServices, CommonServices, PendingTransfersServices) {

            // Instancia del controlador dentro de la variable self
            var self = this;

            // Publicación de variables por medio de la variable self

            // Publicación de las funciones por medio de la variable self
            self.$onInit = init;
            self.filterTable = filterTable;
            self.prepareEdit = prepareEdit;
            self.submit = submit;
            self.deleteObj = deleteObj;
            self.cleanForm = cleanForm;

            self.openCal = openCal;
            self.last


            // Funciones públicas
            function init() {

            }

            function submit() {
                // Enviar procesar
                var actionName = getCtrlName() + ".procesar()"
                loading.startLoading(actionName);
                var req = {};
                /*
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
                */
            }

            function openCal(i) {
                //console.log(i)
                self.popup = self.popup || [];
                self.popup[i] = !self.popup[i];
            }

            // Funciones privadas
            function getProcessState() {
                // Traer porcentaje carga
                var actionName = getCtrlName() + ".getTransfers()"
                loading.startLoading(actionName);
                var req = {};
                //var p = PendingTransfersServices.getTransfers().$promise;
                //p.then(function (result) {
                //    if (result.CodigoRpta == 0) {
                //    } else {
                //        growl.warning(result.MensajeRpta);
                //    }
                //    loading.stopLoading(actionName);
                //}).catch(function (error) {
                //    growl.error("Ocurrió un error");
                //    console.log(error);
                //    loading.stopLoading(actionName);
                //});

                // Para pruebas, genera un número aleatorio entre 0 y 100
                loading.stopLoading(actionName);
                return Math.random() * 100;
            }

            // Helpers
            function getCtrlName() {
                return "pendingTransfers.pendingTransfersCalculateProcessController";
            }
        }
    ]);