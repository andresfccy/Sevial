'use strict';
var dashboardModule = angular.module('sevialApp.dashboard', []);
accountModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('dashboard');
    //$httpProvider.interceptors.push('InyectorDeError');
});