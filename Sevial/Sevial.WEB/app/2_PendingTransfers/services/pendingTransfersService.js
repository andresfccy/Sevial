'use strict';
pendingTransfersModule
    .factory('PendingTransfersServices',
    ['$resource', 'CommonConstants',
        function ($resource, CommonConstants) {
            var url = CommonConstants.API_BASE_URL();
            var paramDefaults = {};

            var actions = {
                getUploadFiles: {
                    method: 'POST',
                    url: CommonConstants.INFUP_GET_FILES()
                },
                proccessFiles: {
                    method: 'POST',
                    url: CommonConstants.INFUP_PROCESS_FILE()
                }
            };
            return $resource(url, paramDefaults, actions);
        }
    ]);