'use strict';
var app = angular.module('sevialApp', [
    'ngCookies'
    , 'ngResource'
    , 'pascalprecht.translate'
    , 'angular-growl'
    , 'angularMoment'
    , 'ui.router'
    , 'ui.router.title'
    , 'ui.router.breadcrumbs'
    , 'ngMessages'
    , 'ngStorage'
    , 'ngAnimate'
    , 'ui.bootstrap'
    , 'ngSanitize'
    , 'angular-swal'
    , 'ui.select'

    // Módulos de la aplicación 
    // NOTA: Cada componente se tiene que registrar en la aplicación (en la lista siguiente) para ser incluído
    , 'sevialApp.common'
    , 'sevialApp.security'
    , 'sevialApp.dashboard'
    , 'sevialApp.sysParameters'
    , 'sevialApp.pendingTransfers'
    , 'sevialApp.rightToPetition'
    , 'sevialApp.correspondenceControl'
    , 'sevialApp.portfolioManagement'

]).config(function ($translateProvider, $translatePartialLoaderProvider, growlProvider) {
    $translateProvider.useLoader('$translatePartialLoader', {
        urlTemplate: 'i18n/{part}/{part}-{lang}.json'
    });
    $translateProvider.preferredLanguage('es');
    $translateProvider.useLocalStorage();
    growlProvider.globalTimeToLive(5000);
});