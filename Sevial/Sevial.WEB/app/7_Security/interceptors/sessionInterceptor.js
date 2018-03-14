securityModule
    .factory('sessionInterceptor',
    ['$q', '$rootScope',
        'SessionServices', 'CommonConstants',
        function ($q, $rootScope,
            SessionServices, CommonConstants) {
            var sessionInjector = {
                request: function (config) {
                    var tokenFromLocalStorage = SessionServices.getTokenFromLocalStorage();
                    if (typeof tokenFromLocalStorage !== 'undefined' && tokenFromLocalStorage != null) {
                        config.headers[CommonConstants.TOKEN_HEADER] = 'Bearer ' + tokenFromLocalStorage;
                        config.headers['Content-type'] = 'application/x-www-form-urlencoded';
                    } else {
                        // Nada por hacer.
                    }
                    return config;
                },
                responseError: function (rejection) {
                    if (rejection.status == 401) {
                        $rootScope.$broadcast('401');
                    } else if (rejection.status == 403) {
                        $rootScope.$broadcast('403');
                    } else if (rejection.status == 500) {
                        $rootScope.$broadcast('500');
                    }
                    return $q.reject(rejection);
                }
            };
            return sessionInjector;
        }
    ]);