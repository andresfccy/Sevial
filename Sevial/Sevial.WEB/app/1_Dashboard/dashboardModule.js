'use strict';
var dashboardModule = angular.module('sevialApp.dashboard', []);
dashboardModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('dashboard');
    //$httpProvider.interceptors.push('InyectorDeError');
});