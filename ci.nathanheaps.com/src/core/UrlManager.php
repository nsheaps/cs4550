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
 *
 * @package     Global
 * @author      Pedro Mata-Mouros Fonseca <pedro.matamouros@gmail.com>
 * @copyright   2010-2011, Pedro Mata-Mouros Fonseca.
 * @license     http://www.gnu.org/licenses/gpl-3.0.html GNU GPLv3 or later.
 * @version     $LastChangedRevision$
 * @link        $HeadURL$
 * Changed by   $LastChangedBy$
 * Changed on   $LastChangedDate$
 */
class UrlManager
{
  static public function getExternalForScmCommitLink(Project $project, Project_Build $project_build)
  {
    //
    // GitHub
    //
    if (preg_match('/(github\.com)[:\/](\w+)\/(\w+)\.git/', $project->getScmRemoteRepository(), $matches)) {
      return "https://{$matches[1]}/{$matches[2]}/$matches[3]/commit/{$project_build->getScmRevision()}";
    }
    return '';
  }

  static public function getForAdmin()
  {
    return CINTIENT_BASE_URL . '/admin/';
  }

  static public function getForAjaxAdminGlobalSettings()
  {
    return CINTIENT_BASE_URL . '/ajax/admin/global-settings/';
  }

  static public function getForAjaxAdminExecutables()
  {
    return CINTIENT_BASE_URL . '/ajax/admin/executables/';
  }

  static public function getForAjaxAdminLog()
  {
    return CINTIENT_BASE_URL . '/ajax/admin/log/';
  }

  static public function getForAjaxAuthentication()
  {
    return CINTIENT_BASE_URL . '/ajax/authentication/';
  }

  static public function getForAjaxAvatarUpload(Array $params = array())
  {
    return CINTIENT_BASE_URL . '/ajax/avatar-upload/?' .  http_build_query($params);
  }

  static public function getForAjaxDashboardProject(Array $params = array())
  {
    return CINTIENT_BASE_URL . '/ajax/dashboard/project/?' .  http_build_query($params);
  }

  static public function getForAjaxProjectBuildHistory(Array $params = array())
  {
    return CINTIENT_BASE_URL . '/ajax/project/history/?' .  http_build_query($params);
  }

  static public function getForAjaxProjectIntegrationBuilderAddElement()
  {
    return CINTIENT_BASE_URL . '/ajax/project/integration-builder-add-element/';
  }

  static public function getForAjaxProjectIntegrationBuilderDeleteElement()
  {
    return CINTIENT_BASE_URL . '/ajax/project/integration-builder-delete-element/';
  }

  static public function getForAjaxProjectIntegrationBuilderSaveElement()
  {
    return CINTIENT_BASE_URL . '/ajax/project/integration-builder-save-element/';
  }

  static public function getForAjaxProjectIntegrationBuilderSortElements()
  {
    return CINTIENT_BASE_URL . '/ajax/project/integration-builder-sort-elements/';
  }

  static public function getForAjaxProjectAccessLevelChange()
  {
    return CINTIENT_BASE_URL . '/ajax/project/access-level/';
  }

  static public function getForAjaxProjectAddUser()
  {
    return CINTIENT_BASE_URL . '/ajax/project/add-user/';
  }

  static public function getForAjaxProjectBuild()
  {
    return CINTIENT_BASE_URL . '/ajax/project/build/';
  }

  static public function getForAjaxProjectDelete()
  {
    return CINTIENT_BASE_URL . '/ajax/project/delete/';
  }

  static public function getForAjaxProjectEditGeneral()
  {
    return CINTIENT_BASE_URL . '/ajax/project/edit-general/';
  }

  static public function getForAjaxProjectEditRelease()
  {
    return CINTIENT_BASE_URL . '/ajax/project/edit-release/';
  }

  static public function getForAjaxProjectEditScm()
  {
    return CINTIENT_BASE_URL . '/ajax/project/edit-scm/';
  }

  static public function getForAjaxProjectNew()
  {
    return CINTIENT_BASE_URL . '/ajax/project/new/';
  }

  static public function getForAjaxProjectNotificationsSave()
  {
    return CINTIENT_BASE_URL . '/ajax/project/notifications-save/';
  }

  static public function getForAjaxProjectRemoveUser()
  {
    return CINTIENT_BASE_URL . '/ajax/project/remove-user/';
  }

  static public function getForAjaxRegistration()
  {
    return CINTIENT_BASE_URL . '/ajax/registration/';
  }

  static public function getForAjaxSearchUser()
  {
    return CINTIENT_BASE_URL . '/ajax/search/user/';
  }

  static public function getForAjaxSettingsNotificationsSave()
  {
    return CINTIENT_BASE_URL . '/ajax/settings/notifications-save/';
  }

  static public function getForAsset($filename, Array $params = array())
  {
    $params['f'] = $filename;
    return CINTIENT_BASE_URL . "/asset/?" .  http_build_query($params);
  }

  static public function getForAuthentication()
  {
    return CINTIENT_BASE_URL . '/authentication/';
  }

  static public function getForDashboard()
  {
    return CINTIENT_BASE_URL . '/dashboard/';
  }

  static public function getForLogout()
  {
    return CINTIENT_BASE_URL . '/logout/';
  }

  static public function getForProjectBuildHistory(Array $params = array())
  {
    return CINTIENT_BASE_URL . '/project/history/?' .  http_build_query($params);
  }

  static public function getForProjectBuildView(Project_Build $build, Project $project = null)
  {
    return CINTIENT_BASE_URL . "/project/history/?bid={$build->getId()}" . ($project instanceof Project ? '&pid='.$project->getId() : '');
  }

  static public function getForProjectEdit(Array $params = array())
  {
    return CINTIENT_BASE_URL . '/project/edit/?' .  http_build_query($params);
  }

  static public function getForProjectEditUsers()
  {
    return CINTIENT_BASE_URL . '/project/edit/?users';
  }

  static public function getForProjectNew()
  {
    return CINTIENT_BASE_URL . '/project/new/';
  }

  static public function getForProjectView(Project $project = null)
  {
    $param = '';
    if ($project instanceof Project) {
      $param = "?pid={$project->getId()}";
    }
    return CINTIENT_BASE_URL . "/project/" . $param;
  }

  static public function getForRegistration()
  {
    return CINTIENT_BASE_URL . "/registration/";
  }

  static public function getForSettings()
  {
    return CINTIENT_BASE_URL . '/settings/';
  }
}