'use strict';
portfolioManagementModule
    .factory('PortfolioManagementServices',
    ['$resource', 'CommonConstants',
        function ($resource, CommonConstants) {
            var url = CommonConstants.API_BASE_URL();
            var paramDefaults = {};

            var actions = {
                // Calculate portfolio
                getPercentage: {
                    method: 'POST',
                    url: CommonConstants.CALCT_GET_PERCENTAGE()
                },
                getControlDates: {
                    method: 'POST',
                    url: CommonConstants.CALCT_GET_CONTROL_DATES()
                },
                submitCalc: {
                    method: 'POST',
                    url: CommonConstants.CALCT_SUBMIT_CALC()
                },

                // Param
                getListPortfolio: {
                    method: 'POST',
                    url: CommonConstants.PARAM_GET_LIST_PORTFOLIO()
                },
                updatePortfolio: {
                    method: 'POST',
                    url: CommonConstants.PARAM_UPDATE_PORTFOLIO()
                },
                deletePortfolio: {
                    method: 'POST',
                    url: CommonConstants.PARAM_DELETE_PORTFOLIO()
                },
                getDetailPortfolio: {
                    method: 'POST',
                    url: CommonConstants.PARAM_GET_DETAIL_PORTFOLIO()
                },
                updateDetailPortfolio: {
                    method: 'POST',
                    url: CommonConstants.PARAM_UPDATE_DETAIL_PORTFOLIO()
                },

                // Param Deptal
                getListDptos: {
                    method: 'POST',
                    url: CommonConstants.PRMDTAL_GET_LIST_DPTOS()
                },
                getListAvailableCitiesByDpto: {
                    method: 'POST',
                    url: CommonConstants.PRMDTAL_GET_LIST_AVAILABLE_CITIES_BY_DPTO()
                },
                getListCitiesByDpto: {
                    method: 'POST',
                    url: CommonConstants.PRMDTAL_GET_LIST_CITIES_BY_DPTO()
                },
                updateList: {
                    method: 'POST',
                    url: CommonConstants.PRMDTAL_UPDATE_LIST()
                }
            };
            return $resource(url, paramDefaults, actions);
        }
    ]);