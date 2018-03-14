'use strict';
var rightToPetitionModule = angular.module('sevialApp.rightToPetition', []);
rightToPetitionModule.config(function ($translateProvider, $translatePartialLoaderProvider, $httpProvider) {
    $translatePartialLoaderProvider.addPart('rightToPetition');
    //$httpProvider.interceptors.push('InyectorDeError');
});