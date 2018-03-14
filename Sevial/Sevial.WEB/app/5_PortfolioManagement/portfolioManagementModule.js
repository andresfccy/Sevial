'use strict';
var portfolioManagementModule = angular.module('sevialApp.portfolioManagement', []);
portfolioManagementModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('portfolioManagement');
    //$httpProvider.interceptors.push('InyectorDeError');
});