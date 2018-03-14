'use strict';
accountModule
    .factory('AccountServices',
    ['$resource', 'CommonConstants',
    function ($resource, CommonConstants) {
        var url = CommonConstants.API_BASE_URL();
        var paramDefaults = {};

        var actions = {
            login: {
                method: 'POST',
                url: CommonConstants.TOKEN(),
                //headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
            }
        };
        return $resource(url, paramDefaults, actions);
    }
]);