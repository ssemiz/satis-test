module.exports = function(grunt) {
	'use strict';

	// Load all grunt tasks
	require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

    // Load the configuration and save in grunt config
	var pkg  = grunt.file.readJSON('package.json');
	var conf = pkg.pbi_pattern;

    grunt.initConfig({
        pkg: pkg
	});

    grunt.config('conf', conf);

	// Load subtasks
	grunt.loadTasks('grunt/tasks/');

    grunt.registerTask('default', ['clean:dist','uglify', 'copy', 'svg', 'css', 'copy:oxid']);
	grunt.registerTask('css', ['sass', 'postcss', 'copy:oxid']);
	grunt.registerTask('svg', [ 'clean:svg', 'svgmin']);

	// cant use bump here 'cus that's name of the task. Would result in recursive madness.
	grunt.registerTask('bumpfix',     ['bump-only', 'conventionalChangelog', 'bump-commit']);
	grunt.registerTask('bumpminor',   ['bump-only:minor', 'conventionalChangelog', 'bump-commit']);
	grunt.registerTask('bumpmajor',   ['bump-only:major', 'conventionalChangelog', 'bump-commit']);
};
