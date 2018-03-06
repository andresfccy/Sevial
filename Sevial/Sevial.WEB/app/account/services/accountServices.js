'use strict';
accountModule
    .factory('AccountServices',
    ['$resource', 'CommonConstants',
    function ($resource, CommonConstants) {
        var url = CommonConstants.API_BASE_URL();
        var paramDefaults = {};

        var actions = {
            getValidationCode: {
                method: 'GET',
                url: CommonConstants.SISEC_ACCOUNT_GET_VALIDATION_CODE(),
                params: { username: '@username' },
                headers: { }
            },
            login: {
                method: 'POST',
                url: CommonConstants.SISEC_TOKEN(),
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            }
        };
        return $resource(url, paramDefaults, actions);
    }
]);