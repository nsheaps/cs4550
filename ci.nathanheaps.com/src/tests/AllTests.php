<?php
/*
 *
 *  Cintient, Continuous Integration made simple.
 *  Copyright (c) 2010-2012, Pedro Mata-Mouros <pedro.matamouros@gmail.com>
 *
 *  This file is part of Cintient.
 *
 *  Cintient is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Cintient is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Cintient. If not, see <http://www.gnu.org/licenses/>.
 *
 */

require_once dirname(__FILE__) . '/../config/phpunit.conf.php';
require 'DatabaseTest.php';
require 'FrameworkBaseObjectTest.php';
require 'FrameworkProcessTest.php';

class AllTests
{
  public static function suite()
  {
    $suite = new PHPUnit_Framework_TestSuite('PHPUnit');
    $suite->addTestSuite('DatabaseTest');
    $suite->addTestSuite('FrameworkBaseObjectTest');
    $suite->addTestSuite('FrameworkProcessTest');
    return $suite;
  }
}