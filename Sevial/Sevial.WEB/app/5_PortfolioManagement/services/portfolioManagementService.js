'use strict';
correspondenceControlModule
    .factory('CorrespondenceControlServices',
    ['$resource', 'CommonConstants',
        function ($resource, CommonConstants) {
            var url = CommonConstants.API_BASE_URL();
            var paramDefaults = {};

            var actions = {
                //login: {
                //    method: 'POST',
                //    url: CommonConstants.SEC_LOGIN()
                //},
            };
            return $resource(url, paramDefaults, actions);
        }
    ]);