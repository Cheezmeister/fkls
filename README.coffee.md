FKLS
============

The Zero-BS Task List. Written because I had to.

All Systems Go
--------------

    module.exports = (grunt) ->
      grunt.initConfig(require "./grunt_config.yaml")

Yes, I use Node and Grunt, I'm a horrible person. This is the real gruntfile.

      grunt.loadNpmTasks plugin for plugin in [
        'grunt-contrib-jade',
        'grunt-contrib-coffee',
        'grunt-contrib-stylus',
        'grunt-contrib-clean',
        'grunt-contrib-watch',
        'grunt-contrib-copy',
        'grunt-contrib-connect',
      ]

Load some plugins

      # Tasks
      grunt.registerTask 'default', 'build'
      grunt.registerTask 'build', [
        'coffee',
        'stylus',
        'jade',
      ]
      grunt.registerTask 'serve', [
        'build',
        'connect:server',
        'watch',
      ]

Define tasks.

