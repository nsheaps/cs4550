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

/**
 * A class for handling access level.
 *
 * @package     User
 * @author      Pedro Mata-Mouros Fonseca <pedro.matamouros@gmail.com>
 * @copyright   2010-2011, Pedro Mata-Mouros Fonseca.
 * @license     http://www.gnu.org/licenses/gpl-3.0.html GNU GPLv3 or later.
 * @version     $LastChangedRevision$
 * @link        $HeadURL$
 * Changed by   $LastChangedBy$
 * Changed on   $LastChangedDate$
 */
class Access
{
  const NONE  = 0; // Not even owner has access
  const READ  = 1;
  const BUILD = 3; //3
  const WRITE = 7; //7
  const OWNER = 15; //15

  static $_description = array(
    self::NONE => "No access at all",
    self::READ => "No access to settings or possibility of changing anything",
    self::BUILD => "Access to builder settings, can trigger new builds",
    self::WRITE => "Can access and change all settings except deleting the project",
    self::OWNER => "Root level access",
  );

  //
  // Utility consts - SERIOUSLY take care if the above consts are ever altered!
  //
  const DEFAULT_USER_ACCESS_LEVEL_TO_PROJECT = self::BUILD;  // READ & BUILD

  static public function getDescription($access)
  {
    if (isset(self::$_description[$access])) {
      return self::$_description[$access];
    }
    return false;
  }

  static public function toStr($access)
  {
    $str = '';
    switch ($access) {
      case self::READ:
        $str = 'read';
        break;
      case self::BUILD:
        $str = 'build';
        break;
      case self::WRITE:
        $str = 'write';
        break;
      case self::OWNER:
        $str = 'owner';
        break;
      case self::NONE:
        $str = 'none';
        break;
      default:
        $str = 'invalid';
        break;
    }
    return $str;
  }

  static public function getList()
  {
    return array(
      self::NONE => self::toStr(self::NONE),
      self::READ => self::toStr(self::READ),
      self::BUILD => self::toStr(self::BUILD),
      self::WRITE => self::toStr(self::WRITE),
      self::OWNER => self::toStr(self::OWNER),
    );
  }
}