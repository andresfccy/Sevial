'use strict';
var sysParametersModule = angular.module('sevialApp.sysParameters', []);
sysParametersModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('sysParameters');
    //$httpProvider.interceptors.push('InyectorDeError');
});