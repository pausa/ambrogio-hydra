module.exports = {
  pluginOptions: {
    electronBuilder: {
      nodeIntegration: true,
      builderOptions: {
        appId: 'dev.pausa.ambrogio.head.electron',
        win: {
          target: 'portable'
        },
        linux: {
          target: 'AppImage'
        }
      }
    }
  }
}
