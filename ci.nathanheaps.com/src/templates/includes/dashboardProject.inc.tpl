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

*}
            <ul class="tabs" id="{$project->getTitle()}">
              <li class="active"><a href="#latest">Latest</a></li>
              <li><a href="#charts">Charts</a></li>
              <li><a href="#log">Log</a></li>
              <li><a href="#releases">Releases</a></li>
            </ul>

            <div class="tab-content">
              <div class="active" id="latest">
                <div class="row">
                  <div class="span2">Status:</div>
                  <div class="span6">{if !$project_build instanceof Project_Build}This project has never been built.{else}<span class="label {if $project_build->getStatus()!=Project_Build::STATUS_FAIL}success{else}important{/if}">{if $project_build->getStatus()!=Project_Build::STATUS_FAIL}Ok{else}Failed{/if}</span>{/if}</div>
                </div>
                <div class="row">
                  <div class="span2">Build:</div>
                  <div class="span6">{if !$project_build instanceof Project_Build}---{else}<a href="{UrlManager::getForProjectBuildView($project_build)}">#{$project_build->getId()}</a>{/if}</div>
                </div>
{if $project_build instanceof Project_Build}
                <div class="row">
                  <div class="span2">Commit:</div>
{$externalCommitLink=UrlManager::getExternalForScmCommitLink($project, $project_build)}
                  <div class="span6">{if !empty($externalCommitLink)}<a href="{$externalCommitLink}" target="_blank">{/if}{$project_build->getScmRevision()|truncate:10:''}{if !empty($externalCommitLink)}</a>{/if}</div>
                </div>
                <div class="row">
                  <div class="span2">Finished:</div>
{$time=time()-strtotime($project_build->getDate())}
{if $time < (3600)}
  {$formatStr='hms'}
{else}
  {$formatStr='yMdwhm'}
{/if}
                  <div class="span6">{Utility::timeDurationToHumanReadable($time, $formatStr)} ago</div>
                </div>
                <div class="row">
                  <div class="span2">Duration:</div>
{$duration=$project_build->getDuration()}
{if $duration < 1}
  {$duration=1}
{/if}
                  <div class="span6">{if !empty($duration)}{Utility::timeDurationToHumanReadable($duration, 'ms')}{else}---{/if}</div>
                </div>
{/if}
              </div>
              <div id="charts">
                <ul class="media-grid">
                  <li>
                    <div id="chartBuildTimelineContainer" class="chart" style="display: none;"></div>
                  </li>
                  <li>
                    <div id="chartBuildDurationContainer" class="chart" style="display: none;"></div>
                  </li>
{if !empty($project_buildStats.qualityTrend)}
                  <li>
                    <div id="chartQualityTrendContainer" class="chart" style="display: none;"></div>
                  </li>
{/if}
                  <li>
                    <div id="chartBuildOutcomesContainer" class="chart" style="display: none;"></div>
                  </li>
                </ul>
              </div>
              <div id="log">
{if !empty($project_log)}
                <table class="zebra-striped">
                  <thead>
                    <tr>
                      <th class="header yellow headerSortDown">Datetime</th>
                      <th class="header blue">Message</th>
                      <th class="header green">User</th>
                    </tr>
                  </thead>
                  <tbody>
{foreach from=$project_log item=log}
                    <tr>
                      <td>{$log->getDate()|date_format:"%Y/%m/%d - %H:%M:%S"}</td>
                      <td>{$log->getMessage()}</td>
                      <td>{if $log->getUsername() == ''}system{else}{$log->getUsername()}{/if}</td>
                    </tr>
{/foreach}
                  </tbody>
                </table>
{/if}
              </div>
              <div id="releases">
{if !empty($project_builds)}
                <table class="zebra-striped">
                  <thead>
                    <tr>
                      {*<th class="header yellow headerSortDown">Datetime</th>*}
                      <th class="header green headerSortDown">Build</th>
                      <th class="header yellow">Revision</th>
                      <th class="header blue">Release</th>
                    </tr>
                  </thead>
                  <tbody>
{foreach from=$project_builds item=build}
                    <tr>
                      {*<td>{$build->getDate()|date_format:"%Y/%m/%d - %H:%M:%S"}</td>*}
                      <td><a href="{UrlManager::getForProjectBuildHistory(['bid' => $build->getId()])}">#{$build->getId()}</a></td>
                      <td>{if $project->getScmConnectorType() == 'svn'}r{/if}{$build->getScmRevision()|truncate:10:''}</td>
                      <td><a href="{UrlManager::getForAsset($build->getId(), ['r' => 1, 'bid' => $build->getId()])}">{$build->getReleaseFile()}</a></td>
                    </tr>
{/foreach}
                  </tbody>
                </table>
{else}
              <p>To enable project build release packages, please <a href="{UrlManager::getForProjectEdit()}">edit your project's settings</a>.</p>
{/if}
              </div>
            </div>

<script type="text/javascript">
// <![CDATA[
var chartBuildOutcomes;
var chartBuildDuration;
var chartBuildTimeline;
var chartQualityTrend;
$(document).ready(function() {
  //
  // Build outcomes
  //
  chartBuildOutcomes = new Highcharts.Chart({
    chart: {
      renderTo: 'chartBuildOutcomesContainer',
      type: 'pie'
    },
    title: {
      text: 'Build outcomes'
    },
    tooltip: {
      formatter: function() {
        slice = Math.round(this.y * 100 / {math equation="x+y" x=$project_buildStats.buildOutcomes.0 y=$project_buildStats.buildOutcomes.1});
        return this.point.name +': '+ slice + '%';
      }
    },
    plotOptions: {
      pie: {
        allowPointSelect: false,
        cursor: 'pointer',
        dataLabels: {
          enabled: true,
          formatter: function() {
            return this.point.name +': '+ this.y;
          },
          style: {
            color: '#555',
            font: '.92em Helvetica Neue,Helvetica,Arial,sans-serif'
          }
        }
      }
    },
    series: [{
      type: 'pie',
      name: 'Build outcomes',
      data: [
        ['Ok', {$project_buildStats.buildOutcomes.1}],
        {
          name: 'Failed',
          y: {$project_buildStats.buildOutcomes.0},
          sliced: true,
          selected: true
        }
      ]
    }],
  });
  $('#chartBuildOutcomesContainer').fadeIn(600);

  //
  // Build timeline
  //
  chartBuildTimeline = new Highcharts.Chart({
    chart: {
      width: 610,
      height: 260,
      renderTo: 'chartBuildTimelineContainer',
      defaultSeriesType: 'scatter',
      zoomType: 'x',
    },
    title: {
      text: 'Build timeline'
    },
    subtitle: {
      text: ''
    },
    xAxis: {
      type: 'datetime',
      title: {
        text: ''
      },
      maxZoom: 5 * 24 * 3600000, // 5 days (minimum to not breakdown from days into hours on the XX axis)
    },
    yAxis: {
      title: {
        text: ''
      },
      maxZoom: 1 * 24 * 3600000, // 1 day
      labels: {
        formatter: function() {
          if (this.value > 999) { // beats to hours
            hours = 24;
          } else {
            yDate = new Date(this.value*86.4*1000);
            hours = yDate.getHours();
          }
          return '' + hours + 'h';
        }
      },
      min: 0,
      max: 1000,
    },
    tooltip: {
      formatter: function() {
        date = new Date(this.x);
        return '' + date.toDateString() + ', ' + date.toTimeString();
      }
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'top',
      x: -10,
      y: 100,
      //backgroundColor: '#ddd',
      borderWidth: 0,
    },
    plotOptions: {
      scatter: {
        marker: {
          radius: 5,
          states: {
            hover: {
              enabled: true,
            }
          }
        },
        states: {
          hover: {
            marker: {
              enabled: false
            }
          }
        }
      }
    },
    series: [
      {
        type: 'scatter',
        name: 'Ok',
        color: 'rgba(124,196,0, .4)',
        //color: 'rgba(70,165,70,.4)',
        data: [
{foreach from=$project_buildStats.buildTimeline.ok item=ok}{$okMilli=$ok*1000}[{$okMilli}, {$ok|date_format:"B"}],{/foreach}
        ]
      },
      {
        name: 'Failed',
        color: 'rgba(255,40,0, .4)',
        //color: 'rgba(196,60,53,.4)',
        data: [
{foreach from=$project_buildStats.buildTimeline.failed item=failed}{$failedMilli=$failed*1000}[{$failedMilli}, {$failed|date_format:"B"}],{/foreach}
        ]
      }
    ]
  });
  $('#chartBuildTimelineContainer').fadeIn(600);


  //
  // Build timeline
  //
  chartBuildDuration = new Highcharts.Chart({
    colors: ['rgb(98,207,252)'],
    chart: {
      width: 610,
      height: 150,
      renderTo: 'chartBuildDurationContainer',
      zoomType: 'x',
      backgroundColor: {
        linearGradient: [0, 0, 0, 150],
        stops: [
          [0.16, '#fff'],
          [0.9, '#eee']
        ]
      },
    },
    title: {
      text: 'Build duration'
    },
    subtitle: {
      text: ''
    },
    xAxis: {
      type: 'linear',
      title: {
        text: ''
      },
      tickLength: 0,
      labels: {
        formatter: function() {
          return '';
        }
      },
      showFirstLabel: false,
    },
    yAxis: {
      maxPadding: 0,
      title: {
        text: ''
      },
      //showFirstLabel: false,
    },
    tooltip: {
      formatter: function() {
        return 'Build <span style="color: rgb(98,207,252);">#' + this.x + '</span>: ' + this.y + ' seconds';
      }
    },
    legend: {
      enabled : false
    },
    plotOptions: {
      area: {
        fillColor: {
          linearGradient: [0, 0, 0, 300],
          stops: [
            [0, 'rgb(98,207,252)'],
            [1, 'rgba(2,0,0,0)']
          ]
        },
        lineWidth: 1,
        lineColor: 'rgb(98,207,252)',
        marker: {
          enabled: false,
          states: {
            hover: {
              enabled: true,
              radius: 5
            }
          }
        },
        shadow: false,
        states: {
          hover: {
            lineWidth: 1
          }
        }
      }
    },
    series: [
      {
        type: 'area',
        name: 'Duration',
        data: [
{foreach from=$project_buildStats.buildDuration item=duration}[{$duration.0}, {$duration.1}],{/foreach}
        ]
      }
    ]
  });
  $('#chartBuildDurationContainer').fadeIn(600);


{if !empty($project_buildStats.qualityTrend)}
  //
  // Quality trend
  //
  chartQualityTrend = new Highcharts.Chart({
    colors: ['#62CFFC', '#46A546', '#F89406', '#EEDC94', '#C43C35', '#BFBFBF'],
    chart: {
      renderTo: 'chartQualityTrendContainer',
      width: 610,
      height: 260,
    },
    title: {
      text: 'Quality trend',
    },
    subtitle: {
      text: '',
    },
    xAxis: {
      title: {
        text: ''
      },
    },
    yAxis: {
      title: {
        text: ''
      },
      min: 0,
      showFirstLabel: false,
      maxPadding: 0.0,
      //type: 'logarithmic'
    },
    tooltip: {
      formatter: function() {
        return '<b>'+ this.series.name +'</b><br/>Build #'+ this.x +', '+ this.y +'';
      }
    },
    legend: {
      layout: 'vertical',
      align: 'right',
      verticalAlign: 'top',
      x: -10,
      y: 100,
      borderWidth: 0,
      //backgroundColor: '#ddd',
    },
    series: [
{foreach from=$project_buildStats.qualityTrend key=name item=metrics}
      {
        name: '{$name}',
        data: [{foreach from=$metrics key=build item=value}[{$build}, {if empty($value)}0{else}{$value}{/if}],{/foreach}]
      },
{/foreach}
    ],
    plotOptions: {
      line: {
        marker: {
          enabled: false
        }
      }
    }
  });
  $('#chartQualityTrendContainer').fadeIn(600);
{/if}
});

// ]]>
</script>