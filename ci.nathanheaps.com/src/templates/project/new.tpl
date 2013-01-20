{*
    Cintient, Continuous Integration made simple.
    Copyright (c) 2010-2012, Pedro Mata-Mouros <pedro.matamouros@gmail.com>

    This file is part of Cintient.

    Cintient is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Cintient is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Cintient. If not, see <http://www.gnu.org/licenses/>.

*}{include file='includes/header.inc.tpl'
subSectionTitle="New project"
subSectionId="projectNew"}
      <form action class="form" id="newProjectContainer">
        <fieldset>
          <div class="clearfix">
            <label for="title">Project title</label>
            <div class="input">
              <input class="span7 autofocus" type="text" name="title" value="{if isset($formData['title'])}{$formData['title']}{/if}" autofocus />
            </div>
          </div>
          <div class="clearfix">
            <label for="scmConnectorType">The SCM connector</label>
            <div class="input">
              <select class="span2" name="scmConnectorType">
{foreach from=$project_availableConnectors item=connector}
                <option value="{$connector}"{if isset($formData['scmConnectorType']) && $formData['scmConnectorType']==$connector} selected{/if}>{$connector|capitalize}
{/foreach}
              </select>
            </div>
          </div>
          <div class="clearfix">
            <label for="scmRemoteRepository">The SCM remote repository</label>
            <div class="input">
              <input class="span10" type="text" name="scmRemoteRepository" value="{if isset($formData['scmRemoteRepository'])}{$formData['scmRemoteRepository']}{/if}" />
            </div>
          </div>
          <div class="clearfix">
            <label for="scmUsername">Username for SCM access</label>
            <div class="input">
              <input class="span6" type="text" name="scmUsername" value="{if isset($formData['scmUsername'])}{$formData['scmUsername']}{/if}" />
              <span class="help-block">This field is optional.</span>
            </div>
          </div>
          <div class="clearfix">
            <label for="scmPassword">Password for SCM access</label>
            <div class="input">
              <input class="span6" type="password" name="scmPassword" value="{if isset($formData['scmPassword'])}{$formData['scmPassword']}{/if}" />
              <span class="help-block">This field is optional.</span>
            </div>
          </div>
          <div class="actions">
            <input type="submit" class="btn primary" value="Save changes">&nbsp;<a href="{UrlManager::getForDashboard()}" class="btn">Cancel</a>
          </div>
        </fieldset>
      </form>
<script type="text/javascript">
// <![CDATA[
$(document).ready(function() {
  Cintient.initGenericForm({
    formSelector : '#projectNew form',
    onSuccessRedirectUrl : '{UrlManager::getForDashboard()}',
    submitUrl: '{UrlManager::getForAjaxProjectNew()}',
  });
});
</script>
{include file='includes/footer.inc.tpl'}