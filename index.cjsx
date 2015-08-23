{React, ReactBootstrap, FontAwesome} = window
{Button} = ReactBootstrap
remote = require 'remote'
windowManager = remote.require './lib/window'

i18n = require './node_modules/i18n'
path = require 'path-extra'
{__} = i18n

i18n.configure
  locales: ['en_US', 'ja_JP', 'zh_CN', 'zh_TW']
  defaultLocale: 'zh_CN'
  directory: path.join(__dirname, 'assets', 'i18n')
  updateFiles: false
  indent: '\t'
  extension: '.json'
i18n.setLocale(window.language)

window.settingsPanelWindow = null
initialSettingsPanelWindow = ->
  window.settingsPanelWindow = windowManager.createWindow
    # Use configure
    x: config.get 'poi.window.x', 0
    y: config.get 'poi.window.y', 0
    width: 1020
    height: 650
  window.settingsPanelWindow.loadUrl "file://#{__dirname}/index.html"
  # if process.env.DEBUG?
  # window.settingsPanelWindow.openDevTools
  #  detach: true

module.exports =
  name: 'SettingsPanel'
  priority: 101
  displayName: <span><FontAwesome name='rocket' key={0} />{' ' + __('Settings Panel')}</span>
  description: __ "The settings panel of Poi"
  version: '1.0.0'
  author: 'Chiba'
  link: 'https://github.com/Chibaheit'
  handleClick: ->
    settingsPanelWindow = windowManager.createWindow
      # Use configure
      x: config.get 'poi.window.x', 0
      y: config.get 'poi.window.y', 0
      width: 1020
      height: 650
    # if process.env.DEBUG?
    settingsPanelWindow.openDevTools
      detach: true
    settingsPanelWindow.loadUrl "file://#{__dirname}/index.html"
    settingsPanelWindow.show()
