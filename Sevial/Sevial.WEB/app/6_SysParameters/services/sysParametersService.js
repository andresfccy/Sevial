'use strict';
sysParametersModule
    .factory('SysParametersServices',
    ['$resource', 'CommonConstants',
        function ($resource, CommonConstants) {
            var url = CommonConstants.API_BASE_URL();
            var paramDefaults = {};

            var actions = {

            };
            return $resource(url, paramDefaults, actions);
        }
    ]);