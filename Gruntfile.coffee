module.exports = (grunt) ->
  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks("grunt-contrib-stylus")
  grunt.loadNpmTasks("grunt-contrib-copy")
  grunt.loadNpmTasks("grunt-contrib-concat")
  
  grunt.initConfig

    coffee:
      default:
        options:
          bare: yes
        files:
          "public/js/main.js": "scripts/main.coffee"

    stylus: 
      default: 
        options:
          compress: yes
        files:
          "public/css/main.css": "styles/main.styl"

    concat:
      scripts:
        src: [
          "bower_components/jquery2/jquery.js"
          "bower_components/angular/angular.js"
          "bower_components/socket.io-client/dist/socket.io.js"
        ]
        dest: "public/js/core.js"
      styles:
        src: [
          #"bower_components/normalize-css/normalize.css"
          "bower_components/bootstrap/dist/css/bootstrap.css"
        ]
        dest: "public/css/core.css"

  grunt.registerTask "default", ["coffee", "stylus", "concat"]
