module.exports = {
  printWidth: 100,
  tabWidth: 2,
  useTabs: false,
  semi: true,
  singleQuote: true,
  trailingComma: 'es5',
  endOfLine: 'lf',
  overrides: [
    {
      files: '*.html',
      options: {
        printWidth: 120,
        singleQuote: false,
      },
    },
  ],
};
