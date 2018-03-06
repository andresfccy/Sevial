'use strict';
var commonModule = angular.module('sevialApp.common', []);
commonModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('common');
    //$httpProvider.interceptors.push('InyectorDeError');
});