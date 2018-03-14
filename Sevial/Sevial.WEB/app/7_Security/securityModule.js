'use strict';
var securityModule = angular.module('sevialApp.security', []);
securityModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('security');
    //$httpProvider.interceptors.push('InyectorDeError');
});