'use strict';
sysParametersModule
    .factory('SysParametersServices',
    ['$resource', 'CommonConstants',
        function ($resource, CommonConstants) {
            var url = CommonConstants.API_BASE_URL();
            var paramDefaults = {};

            var actions = {
                getCategories: {
                    method: 'POST',
                    url: CommonConstants.PARAM_GET_CATEGORIES()
                },
            };
            return $resource(url, paramDefaults, actions);
        }
    ]);