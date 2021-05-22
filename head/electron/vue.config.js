module.exports = {
  pluginOptions: {
    electronBuilder: {
      nodeIntegration: true,
      builderOptions: {
        appId: 'dev.pausa.ambrogio.head.electron',
        // eslint-disable-next-line no-template-curly-in-string
        artifactName: '${name}-${version}-${os}-${arch}.${ext}',
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
