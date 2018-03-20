'use strict';
securityModule
    .factory('SessionServices',
    ['$localStorage', '$sessionStorage',
        'CommonConstants',
        function ($localStorage, $sessionStorage,
            CommonConstants) {
            var factory = {};

            factory.setValueToStorage = function (key, value) {
                $sessionStorage[key] = value;
            };
            factory.getValueFromStorage = function (key) {
                return $sessionStorage[key];
            };
            factory.removeAllInfoFromLocalStorage = function () {
                $sessionStorage.$reset();
            };

            factory.isLoggedIn = function (a) {
                var token = factory.getValueFromStorage(CommonConstants.TOKEN_KEY);
                if (typeof token === 'undefined' || token == null || token === '') {
                    return false;
                }
                return true;
            };
            factory.authorized = function (state) {
                console.log(state);
                //TODO: Lógica para saber si un usuario tiene acceso a un determinado estado del enrutador.
                return true;
            }
            return factory;
        }
    ]);