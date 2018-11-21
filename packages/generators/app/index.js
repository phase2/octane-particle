'use strict';
//Require dependencies
const Generator = require('yeoman-generator');
const { camelCase } = require('lodash');

const prompts = [
  {
    name: 'name',
    message: 'Project Name ?',
    default: function(answers) {
      return process.cwd().split(require('path').sep).pop();
    },
    filter(answer) {
      return answer.replace(/ /g, '-').toLowerCase();
    },
  },
  {
    name: 'theme',
    message: 'Theme Name ?',
    default: function(answers) {
      return answers.name;
    },
    filter(answer) {
      return answer.replace(/ /g, '-').toLowerCase();
    },
  },
];

module.exports = class extends Generator {
  prompting() {
    return this.prompt(prompts).then(props => {
      // To access props later use this.props.someAnswer;
      this.props = {
        ...props,
        dashlessName: props.name.replace(/-/g, ''),
        underscoreName: props.name.replace(/-/g, '_'),
        camelCaseName: camelCase(props.name),
        dashlessTheme: props.theme.replace(/-/g, ''),
        underscoreTheme: props.theme.replace(/-/g, '_'),
        camelCaseTheme: camelCase(props.theme),
      };
    });
  }

  writing() {
    // Copy all non-dotfiles from templates.
    this.fs.copyTpl(
      this.templatePath('**/*'),
      this.destinationRoot(),
      this.props
    );

    // Copy all dotfiles from templates.
    this.fs.copyTpl(
      this.templatePath('**/.*'),
      this.destinationRoot(),
      this.props
    );

  }
};
