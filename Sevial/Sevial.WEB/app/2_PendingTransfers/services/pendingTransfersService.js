'use strict';
pendingTransfersModule
    .factory('PendingTransfersServices',
    ['$resource', 'CommonConstants',
        function ($resource, CommonConstants) {
            var url = CommonConstants.API_BASE_URL();
            var paramDefaults = {};

            var actions = {
                // Upload info services
                getUploadFiles: {
                    method: 'POST',
                    url: CommonConstants.INFUP_GET_FILES()
                },
                proccessFiles: {
                    method: 'POST',
                    url: CommonConstants.INFUP_PROCESS_FILE()
                },

                // Transfers services
                getTransfers: {
                    method: 'POST',
                    url: CommonConstants.INF_GET_TRANSFERS()
                },
                editTransfer: {
                    method: 'POST',
                    url: CommonConstants.INF_EDIT_TRANSFER()
                },
                deleteTransfer: {
                    method: 'POST',
                    url: CommonConstants.INF_DELETE_TRANSFER()
                },
            };
            return $resource(url, paramDefaults, actions);
        }
    ]);