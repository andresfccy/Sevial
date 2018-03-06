'use strict';
app.directive('loading', ['$rootScope', function ($rootScope) {
    return {
        templateUrl: './app/common/views/loading.html',
        scope: true,
        controller: ['$scope', function ($scope) {
            $scope.loading = false;
            $rootScope.$on('loadingFlag', function (event, flag) {
                $scope.loading = flag;
            })
        }]
    }
}]);
app.provider('loading', function () {
    this.$get = ['$rootScope', function ($rootScope) {
        var listCallers = [];
        function broadcastFlag(flag) {
            $rootScope.$broadcast('loadingFlag', flag);
        }
        function startLoading(who) {
            console.log("Start loading: ", who);
            listCallers.push(who);
            broadcastFlag(true);
        }
        function stopLoading(who) {
            console.log("Stop loading: ",who);
            listCallers.splice(listCallers.indexOf(who), 1);
            //console.log("stop: " + JSON.stringify(listCallers))
            if (listCallers.length == 0)
                broadcastFlag(false);
        }

        return {
            startLoading: startLoading,
            stopLoading: stopLoading
        }
    }]
});