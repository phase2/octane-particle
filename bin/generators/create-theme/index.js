'use strict';
//Require dependencies
const Generator = require('yeoman-generator');
const { camelCase, startCase } = require('lodash');

const { npm_package_config_paths_design } = process.env;

const prompts = [
  {
    name: 'theme',
    message: 'Theme Name ?',
    default: function(answers) {
      return answers.name;
    },
    filter(answer) {
      return answer.replace(/ /g, '-').toLowerCase();
    }
  }
];

console.log(
  `Path is ${npm_package_config_paths_design}`
);

module.exports = class extends Generator {
  prompting() {
    return this.prompt(prompts).then(props => {
      let configVars = {};
      for (const key in process.env) {
        if (key.startsWith('npm_package_config_')) {
          configVars[camelCase(key.replace(/^npm_package_config_/, ''))] = process.env[key];
        }
      }
      // To access props later use this.props.someAnswer;
      this.props = {
        ...props,
        ...configVars,
        dashlessTheme: props.theme.replace(/-/g, ''),
        underscoreTheme: props.theme.replace(/-/g, '_'),
        camelCaseTheme: camelCase(props.theme),
        startCaseTheme: startCase(props.theme),
      };
    });
  }

  writing() {
    const options = {
      // Don't warn if there aren't any template files to copy.
      ignoreNoMatch: true,
      // Also match files that start with a dot.
      globOptions: {
        dot: true
      }
    };
    // Copy all files from templates.
    this.fs.copyTpl(
      this.templatePath('**/*'),
      this.destinationRoot(),
      this.props,
      {},
      options
    );
  }

};
