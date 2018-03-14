'use strict';
dashboardModule
    .factory('DashboardServices',
    ['$resource', 'CommonConstants',
        function ($resource, CommonConstants) {
            var url = CommonConstants.API_BASE_URL();
            var paramDefaults = {};

            var actions = {
                login: {
                    method: 'POST',
                    url: CommonConstants.SEC_LOGIN()
                },
                getModulesByUser: {
                    method: 'POST',
                    url: CommonConstants.SEC_GET_MODULES_BY_USER()
                },
                getOptionsByUser: {
                    method: 'POST',
                    url: CommonConstants.SEC_GET_OPTIONS_BY_USER()
                },
                validateAccessUrl: {
                    method: 'POST',
                    url: CommonConstants.SEC_VALIDATE_ACCESS_URL()
                },
            };
            return $resource(url, paramDefaults, actions);
        }
    ]);