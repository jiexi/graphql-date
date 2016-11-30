_ = require 'lodash'
chai = require 'chai'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'

chai.use sinonChai

_.assign global, {
  chai
  expect: chai.expect
  sinon
}
