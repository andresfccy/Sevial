'use strict';
var app = angular.module('sevialApp', [
      'ngCookies'
    , 'ngResource'
    , 'pascalprecht.translate'
    , 'angular-growl'
    , 'ui.router'
    , 'ngMessages'
    , 'ngStorage'
    , 'ngAnimate'
    , 'ui.router.title'
    , 'ui.bootstrap'
    , 'ui.select'
    , 'ngSanitize'
    , 'angular-swal'

    // Módulos de la aplicación 
    // NOTA: Cada componente se tiene que registrar en la aplicación (en la lista siguiente) para ser incluído
    , 'sevialApp.common'
    , 'sevialApp.account'
    , 'sevialApp.dashboard'

]).config(function ($translateProvider, $translatePartialLoaderProvider, growlProvider) {
    $translateProvider.useLoader('$translatePartialLoader', {
        urlTemplate: 'i18n/{part}/{part}-{lang}.json'
    });
    $translateProvider.preferredLanguage('es');
    $translateProvider.useLocalStorage();
    growlProvider.globalTimeToLive(5000);
});