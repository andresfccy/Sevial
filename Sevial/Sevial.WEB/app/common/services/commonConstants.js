'use strict';
commonModule.factory('CommonConstants', [
    function () {
        var factory = {
            API_HOSTNAME: 'http://localhost',
            API_HOSTNAME_SSL: 'https://localhost',

            API_LOGIN: 'http://localhost',
            API_LOGIN_SSL: 'https://localhost',

            API_PORT: '50885',
            API_LOGIN_PORT: '50885',

            TOKEN_HEADER: 'Authorization',
            TOKEN_KEY_LOCALSTORAGE: 'authData',
            USER_ID_LOCALSTORAGE: 'u',
            ROL_LOCALSTORAGE: 'r',
            API_BASE_URL: function () {
                var baseUrl = factory.API_HOSTNAME;
                if (factory.API_PORT.length > 0 || factory.API_PORT !== '80') {
                    baseUrl += ':' + factory.API_PORT;
                }
                return baseUrl;
            },
            API_BASE_URL_SSL: function () {
                var baseUrl = factory.API_HOSTNAME_SSL;
                if (factory.API_PORT.length > 0 || factory.API_PORT !== '80') {
                    baseUrl += ':' + factory.API_PORT;
                }
                return baseUrl;
            },
            API_LOGIN_URL: function () {
                var baseUrl = factory.API_LOGIN;
                if (factory.API_LOGIN_PORT.length > 0 || factory.API_LOGIN_PORT !== '80') {
                    baseUrl += ':' + factory.API_LOGIN_PORT;
                }
                return baseUrl;
            },
            API_LOGIN_URL_SSL: function () {
                var baseUrl = factory.API_LOGIN_SSL;
                if (factory.API_LOGIN_PORT.length > 0 || factory.API_LOGIN_PORT !== '80') {
                    baseUrl += ':' + factory.API_LOGIN_PORT;
                }
                return baseUrl;
            }

            , TOKEN: function () { return factory.API_BASE_URL() + '/Sesion/Login'; }

            , ACCOUNT: function () { return factory.API_BASE_URL() + '/Account'; }
            , HOME_ADMINISTRATIVE: function () { return factory.API_BASE_URL() + '/HomeAdministrativo'; }
            , QA_SCHEDULE: function () { return factory.API_BASE_URL() + '/ModuloHorarioCalidad'; }

            , SISEC_ACCOUNT_GET_VALIDATION_CODE: function () { return factory.SISEC_ACCOUNT() + '/GenerarCodigoValidacion?userName=:username'; }
            , SISEC_ACCOUNT_LOGIN: function () { return factory.SISEC_ACCOUNT() + '/Login'; }

            , HOME_ADMINISTRATIVE_GET_HOURS: function () { return factory.HOME_ADMINISTRATIVE() + '/ListaGeneralHorarioCalidad'; }

            , QA_SCHEDULE_GET_ALL: function () { return factory.QA_SCHEDULE() + '/ListaGeneralHorarioCalidad'; }
            , QA_SCHEDULE_GET_SCHEDULES_TYPES: function () { return factory.QA_SCHEDULE() + '/ListarObjetosCalidad'; }
        };

        var procesando = false;

        var funcionesObservadores = [];
        var registrarObservadorProcesando = function (funcion) {
            funcionesObservadores.push(funcion);
        };

        var notificarObservadores = function () {
            angular.forEach(funcionesObservadores, function (funcion) {
                funcion();
            });
        };

        var storage = localStorage;
        function guardar(clave, valor) {
            storage.setItem(clave, valor);
        }
        function eliminar(clave) {
            storage.removeItem(clave);
        }
        return factory;
    }
]);