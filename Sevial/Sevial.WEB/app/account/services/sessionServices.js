'use strict';
accountModule
    .factory('SessionServices',
    ['$localStorage', 
    'CommonConstants',
    function ($localStorage,
    CommonConstants) {
        var factory = {};
        
        factory.getTokenFromLocalStorage = function () {
            return $localStorage[CommonConstants.TOKEN_KEY_LOCALSTORAGE];
        };
        factory.setTokenToLocalStorage = function (token) {
            $localStorage[CommonConstants.TOKEN_KEY_LOCALSTORAGE] = token;
        };
        factory.getUserIdFromLocalStorage = function () {
            return $localStorage[CommonConstants.USER_ID_LOCALSTORAGE];
        };
        factory.setUserIdToLocalStorage = function (userId) {
            $localStorage[CommonConstants.USER_ID_LOCALSTORAGE] = userId;
        };
        factory.getRolFromLocalStorage = function () {
            return $localStorage[CommonConstants.ROL_LOCALSTORAGE];
        };
        factory.setRolToLocalStorage = function (rol) {
            $localStorage[CommonConstants.ROL_LOCALSTORAGE] = rol;
        };
        factory.removeAllInfoFromLocalStorage = function () {
            $localStorage.$reset;
        };
        factory.isLoggedIn = function () {
            var token = factory.getTokenFromLocalStorage();
            if (typeof token == 'undefined' || token == null || token == '') {
                return false;
            }
            return true;
        };
        factory.authorized = function (state) {
            //TODO: Lógica para saber si un usuario tiene acceso a un determinado estado del enrutador.
        }
        return factory;
    }
    ]);