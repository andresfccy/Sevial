﻿'use strict';
var app = angular.module('sisecEnsenanzaApp', [
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

]).config(function ($translateProvider, $translatePartialLoaderProvider, growlProvider) {
    $translateProvider.useLoader('$translatePartialLoader', {
        urlTemplate: 'i18n/{part}/{part}-{lang}.json'
    });
    $translateProvider.preferredLanguage('es');
    $translateProvider.useLocalStorage();
    growlProvider.globalTimeToLive(5000);
});