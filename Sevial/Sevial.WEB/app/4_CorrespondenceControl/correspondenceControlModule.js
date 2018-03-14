'use strict';
var correspondenceControlModule = angular.module('sevialApp.correspondenceControl', []);
correspondenceControlModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('correspondenceControl');
    //$httpProvider.interceptors.push('InyectorDeError');
});