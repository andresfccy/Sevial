'use strict';
commonModule.factory('CommonConstants', [
    function () {
        var factory = {
            API_HOSTNAME: 'http://localhost',
            API_HOSTNAME_SSL: 'https://localhost',

            API_LOGIN: 'http://localhost',
            API_LOGIN_SSL: 'https://localhost',

            API_PORT: '4000',
            API_LOGIN_PORT: '4000',

            TOKEN_HEADER: 'Authorization',

            TOKEN_KEY: 'authData',
            USER_ID_KEY: 'u',
            ROL_KEY: 'r',
            MODULES_KEY: 'Mds$%_',

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

            , SYSTEM_EP: function () { return '/api/sistema' }
            , SECURITY_EP: function () { return '/api/seguridad' }
            , PARAMETER_EP: function () { return '/api/parametro' }
            , INFO_UPLOAD_EP: function () { return '/api/cargueInformacion' }
            , INFO_EP: function () { return '/api/informacion' }
            , PORTF: function () { return '/api/deuda' }

            //, SYS_VALIDATE_ACCESS_URL: function () { return factory.API_BASE_URL() + factory.SECURITY_EP + '/validarUrlIngreso'; }

            , SEC_LOGIN: function () { return factory.API_BASE_URL() + factory.SECURITY_EP() + '/autenticarUsuario'; }
            , SEC_GET_MODULES_BY_USER: function () { return factory.API_BASE_URL() + factory.SECURITY_EP() + '/darModuloUsuario'; }
            , SEC_GET_OPTIONS_BY_USER: function () { return factory.API_BASE_URL() + factory.SECURITY_EP() + '/darOpcionModuloUsuario'; }
            , SEC_VALIDATE_ACCESS_URL: function () { return factory.API_BASE_URL() + factory.SECURITY_EP() + '/validarUrlIngreso'; }

            , PARAM_GET_LIST: function () { return factory.API_BASE_URL() + factory.PARAMETER_EP() + '/darListaCategoria'; }

            , INFUP_GET_FILES: function () { return factory.API_BASE_URL() + factory.INFO_UPLOAD_EP() + '/darArchivosCargue'; }
            , INFUP_PROCESS_FILE: function () { return factory.API_BASE_URL() + factory.INFO_UPLOAD_EP() + '/procesarArchivo'; }

            , INF_GET_TRANSFERS: function () { return factory.API_BASE_URL() + factory.INFO_EP() + '/darTransferencias'; }
            , INF_EDIT_TRANSFER: function () { return factory.API_BASE_URL() + factory.INFO_EP() + '/editarTransferencia'; }
            , INF_DELETE_TRANSFER: function () { return factory.API_BASE_URL() + factory.INFO_EP() + '/eliminarTransferencia'; }

            , CALCT_GET_CONTROL_DATES: function () { return factory.API_BASE_URL() + factory.PORTF() + '/darFechasControl'; }
            , CALCT_GET_PERCENTAGE: function () { return factory.API_BASE_URL() + factory.PORTF() + '/consultarEstadoProcDeuda'; }
            , CALCT_SUBMIT_CALC: function () { return factory.API_BASE_URL() + factory.PORTF() + '/enviarProcesoDeuda'; }

            , PARAM_GET_LIST_PORTFOLIO: function () { return factory.API_BASE_URL() + factory.PORTF() + '/listarEntregaCartera'; }
            , PARAM_UPDATE_PORTFOLIO: function () { return factory.API_BASE_URL() + factory.PORTF() + '/editarEntregaCartera'; }
            , PARAM_DELETE_PORTFOLIO: function () { return factory.API_BASE_URL() + factory.PORTF() + '/borrarEntregaCartera'; }
            , PARAM_GET_DETAIL_PORTFOLIO: function () { return factory.API_BASE_URL() + factory.PORTF() + '/listarDetalleEntregaCartera'; }
            , PARAM_UPDATE_DETAIL_PORTFOLIO: function () { return factory.API_BASE_URL() + factory.PORTF() + '/editarDetalleEntregaCartera'; }

            , PRMDTAL_GET_LIST_DPTOS: function () { return factory.API_BASE_URL() + factory.PORTF() + '/listarDepartamentales'; }
            , PRMDTAL_GET_LIST_AVAILABLE_CITIES_BY_DPTO: function () { return factory.API_BASE_URL() + factory.PORTF() + '/listarMunDisponiblesDptal'; }
            , PRMDTAL_GET_LIST_CITIES_BY_DPTO: function () { return factory.API_BASE_URL() + factory.PORTF() + '/listarMunicipiosDptal'; }
            , PRMDTAL_UPDATE_LIST: function () { return factory.API_BASE_URL() + factory.PORTF() + '/editarDptal'; }

            // Shared
            , TIPO_CARGUE: "TIPO_CARGUE"
            , ESTADO_CARGUE: "ESTADO_CARGUE"
            , BANCO_CUENTA: "BANCO_CUENTA"
            , CUANTIA: "CUANTIA"
            , TIPO_TRANSFERENCIA: "TIPO_TRANSFERENCIA"
            , COLOR_BOTON: "COLOR_BOTON"
            , ESTADO_GESTION: "ESTADO_GESTION"
            , MUNICIPIO: "MUNICIPIO"
            , DEPARTAMENTO: "DEPARTAMENTO"
            , AUTORIDAD_IMPOSICION: "AUTORIDAD_IMPOSICION"

            , appName: "Sevial 2018"
            , version: "v. Unrelease 0.18.6.05.1"
            , copyright: "CopyRight, 2018 by Sevial"
            , role: undefined
            , username: undefined
            , menu: []
        };
        return factory;
    }
]);