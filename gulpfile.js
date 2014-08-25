var gulp = require('gulp');
var coffee = require('gulp-coffee');

gulp.task('watch', function() {
	gulp.watch('./*.coffee', ['compile-code']);
});

gulp.task('compile-code', function () {
	gulp.src('./*.coffee')
	.pipe(coffee())
	.pipe(gulp.dest('./'));
});


gulp.task('default', ['watch', 'compile-code']);
