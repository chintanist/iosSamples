'use strict';

/* Controllers */

var phonecatApp = angular.module('phonecatApp', []);

phonecatApp.controller('PhoneListCtrl', function($scope) {
                          $scope.phones = [
                                                {'name': 'Nexus S',
                                                'brand': 'LG',
                                                'age':1,
                                                'snippet': 'Fast just got faster with Nexus S.'},
                                                {'name': 'Motorola XOOM™ with Wi-Fi',
                                                'brand': 'Motorola',
                                                'age':2,
                                                 'snippet': 'The Next, Next Generation tablet.'},
                                                {'name': 'MOTOROLA XOOM™',
                                                'brand': 'Motorola',
                                                'age':3,
                                                 'snippet': 'The Next, Next Generation tablet.'}
                                              ];
                       $scope.orderProp = 'age';
                        });