module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-less")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-concat")
  
  grunt.initConfig

    coffee:
      default:
        options:
          bare: yes
        files:
          "public/js/main.js": "scripts/main.coffee"

    less: 
      default: 
        options:
          paths: ["bower_components"]
        files:
          "public/css/app.css": "styles/app.less"

    concat:
      scripts:
        src: [
          "bower_components/jquery/jquery.js"
          "bower_components/angular/angular.js"
          "bower_components/socket.io-client/dist/socket.io.js"
        ]
        dest: "public/js/core.js"

  grunt.registerTask "default", ["coffee", "less", "concat"]
