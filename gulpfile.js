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
    sourcemaps = require('gulp-sourcemaps');

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
        .pipe(coffee())
        .pipe(concat('app.js'))
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

gulp.task('default', ['clean'], function() {
    gulp.start('styles-sass', 'styles-css', 'scripts', 'jade', 'server', 'watch');
    bowerSrc()
        .pipe(gulp.dest('build/javascripts'));

    console.log('listening');
    // Create LiveReload server

    // Watch any files in dist/, reload on change
    // gulp.watch(['build/**']).on('change', connect.reload());
});


gulp.task('server', function(){
    connect.server({
        livereload: true,
        root: ['build']
    });
});


