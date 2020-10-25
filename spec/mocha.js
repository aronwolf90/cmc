// setup JSDOM
var jsdom = require('jsdom-global')()
require('../app/javascript/polyfill')
const sinon = require('sinon')

const SinonChai = require('sinon-chai')
const Chai = require('chai')

Chai.use(SinonChai)

// make expect available globally
global.expect = Chai.expect
window.Date = Date
global.jqueryFuncs = function () {}
global.jsdom = jsdom
global.sandbox = sinon.createSandbox()
