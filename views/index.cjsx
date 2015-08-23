glob = require 'glob'
path = require 'path-extra'
{ROOT, _, $, $$, React, ReactBootstrap} = window
{Grid, Col, Input, TabbedArea, TabPane, Alert} = ReactBootstrap
# Discover plugins and remove unused plugins or no setting ui plugins
plugins = glob.sync(path.join(ROOT, 'plugins', '*'))
plugins = plugins.filter (filePath) ->
  enable = false
  if filePath != 'SettingsPanel'
    plugin = require filePath
    enabled = config.get "plugin.#{plugin.name}.enable", true
  enabled && plugin.settingsClass?
plugins = plugins.map (filePath) ->
  plugin = require filePath
  plugin.priority = 10000 unless plugin.priority?
  plugin
plugins = _.sortBy(plugins, 'priority')
console.log plugins
SettingsPanelArea = React.createClass
  render: ->
    <TabbedArea bsStyle="pills" defaultActiveKey={0}>
      <link rel="stylesheet" href={path.join(__dirname, '../','assets', 'main.css')} />
      {
        plugins.map (plugin, index) ->
          <TabPane key={index}  eventKey={index} tab={plugin.displayName} id={plugin.name} className='poi-settings-tabpane'>
          {
            React.createElement(plugin.settingsClass)
          }
          </TabPane>
      }
    </TabbedArea>
React.render <SettingsPanelArea />, $('settings-panel')
