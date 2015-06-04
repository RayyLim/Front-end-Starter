'use strict'
gulp       = require 'gulp'
gp         = require 'gulp-load-plugins'
path       = require 'path'
browserify = require 'browserify'
source     = require 'vinyl-source-stream'
jade       = require 'gulp-jade'
rename     = require 'gulp-rename'
clean      = require 'gulp-clean'
coffeelint = require 'gulp-coffeelint'
connect    = require 'gulp-connect'

gulp.task 'clean', ->
    gulp.src 'build/*', {read : false}
        .pipe clean()

# HTML
gulp.task 'html', ->
    gulp.src 'source/**/*.jade'
        .pipe jade()
        .pipe rename {extname:""}
        .pipe gulp.dest 'build'

# lint
gulp.task 'lint', ->
    gulp.src 'source/javascripts/**/*.coffee'
        .pipe coffeelint()
        .pipe coffeelint.reporter()
    
# JS
gulp.task 'js', ['lint'], ->
    browserify
        debug: true
        entries: ['./source/javascripts/app.js.coffee']
        extensions: ['.coffee', '.js', '.js.coffee']
        paths: ['./source/javascripts']
    .transform 'coffeeify'
    .transform 'deamdify'
    .transform 'debowerify'
    # .transform 'uglifyify'
    .bundle()
    .pipe source 'app.js'
    .pipe gulp.dest 'build/javascripts'

gulp.task 'build', ->
    gulp.start 'html', 'js'

gulp.task 'server', ['build'], ->
    connect.server {root: ['build']}

"""
var gulp = require('gulp'),
    sass = require('gulp-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss = require('gulp-minify-css'),
    jshint = require('gulp-jshint'),
    uglify = require('gulp-uglify'),
    imagemin = require('gulp-imagemin'),
    rename = require('gulp-rename'),
    concat = require('gulp-concat'),
    notify = require('gulp-notify'),
    cache = require('gulp-cache'),
    livereload = require('gulp-livereload'),
    del = require('del'),
    coffee = require('gulp-coffee'),
    coffeelint = require('gulp-coffeelint'),
    watch = require('gulp-watch'),
    cache = require('gulp-cache'),
    bowerSrc = require('gulp-bower-src'),
    connect = require('gulp-connect'),
    haml = require('gulp-haml'),
    jade = require('gulp-jade')
    sourcemaps = require('gulp-sourcemaps'),
    coffeeify = require('gulp-coffeeify')

var config = {
     bootstrapDir: './bower_components/bootstrap-sass-official' 
}

gulp.task('lint', function(){
    return gulp.src('source/javascripts/**/*.coffee')
        .pipe(coffeelint())
        .pipe(coffeelint.reporter());
});

gulp.task('styles-sass', function() {
    return gulp.src('source/stylesheets/**/*.sass')
        .pipe(sass({
            includePaths: [config.bootstrapDir + '/assets/stylesheets'],
        }))
        .pipe(autoprefixer('last 2 version'))
        .pipe(rename({extname:""}))
        .pipe(gulp.dest('build/stylesheets'))
        .pipe(notify({message:'Styles task complete'}))
        .pipe(connect.reload());
});

gulp.task('styles-css', function(){
    return gulp.src('source/stylesheets/**/*.cass')
        .pipe(gulp.dest('build/stylesheets'));
});

gulp.task('scripts', ['lint'], function() {
    return gulp.src('source/javascripts/**/*.coffee')
        //.pipe(sourcemaps.init())
        .pipe(coffeeify({
            debug:true
        }))
        // .pipe(concat('app.js'))
        //.pipe(sourcemaps.write())
        .pipe(gulp.dest('build/javascripts'))
        // .pipe(notify({message:'Scripts task complete'}));
});

gulp.task('jade', function(){
    return gulp.src('source/**/*.jade')
    .pipe(jade())
    .pipe(rename({extname:""}))
    .pipe(gulp.dest('build/'))
})

gulp.task('clean', function(cb){
    del(['build/'], cb)
});

gulp.task('watch', function(){
    gulp.watch('source/stylesheets/**/*.sass', ['styles-sass']);
    gulp.watch('source/stylesheets/**/*.css', ['styles-css']);
    gulp.watch('source/javascripts/**/*.js', ['scripts']);
});

gulp.task('build', ['clean'], function() {
    gulp.start('styles-sass', 'styles-css', 'scripts', 'jade', 'watch');
    bowerSrc()
        .pipe(gulp.dest('build/javascripts'));

    console.log('listening');
    // Create LiveReload server

    // Watch any files in dist/, reload on change
    // gulp.watch(['build/**']).on('change', connect.reload());
});


gulp.task('default', function(){
    connect.server({
        livereload: true,
        root: ['build']
    });
});
"""


