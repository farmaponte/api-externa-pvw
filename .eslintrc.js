module.exports = {
  env: {
    es2021: true,
    node: true
  },
  globals: {
    use: true
  },
  extends: [
    'standard'
  ],
  parserOptions: {
    ecmaVersion: 12,
    sourceType: 'module'
  },
  rules: {
    'space-before-function-paren': 'off',
    camelcase: 'off'
  }
}
