'use strict';
var pendingTransfersModule = angular.module('sevialApp.pendingTransfers', []);
pendingTransfersModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('pendingTransfers');
    //$httpProvider.interceptors.push('InyectorDeError');
});