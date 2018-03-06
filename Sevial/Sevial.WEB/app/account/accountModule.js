'use strict';
var accountModule = angular.module('sevialApp.account', []);
accountModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('account');
    //$httpProvider.interceptors.push('InyectorDeError');
});