assertErr = require 'assert-err'
GraphQLScalarType = require('graphql').GraphQLScalarType
GraphQLError = require('graphql/error').GraphQLError
Kind = require('graphql/language').Kind
moment = require 'moment'

module.exports = (dateFormat = 'YYYY-MM-DDTHH:MM:SS.SSSZ') ->
  new GraphQLScalarType
    name: "Date: #{dateFormat}"

    #  Serialize date value into string
    #  @param  {Date} value date value
    #  @return {String} date as string
    serialize: (value) ->
      assertErr value instanceof Date, TypeError, 'Field error: value is not an instance of Date'
      assertErr not isNaN(value.getTime()), TypeError, 'Field error: value is an invalid Date'
      moment(value).format dateFormat


    # Parse value into date
    # @param  {*} value serialized date value
    # @return {Date} date value
    parseValue: (value) ->
      date = moment value, dateFormat
      assertErr date.isValid(), TypeError, 'Field error: value is an invalid Date'
      date.toDate()


    # Parse ast literal to date
    # @param  {Object} ast graphql ast
    # @return {Date} date value
    parseLiteral: (ast) ->
      assertErr ast.kind === Kind.STRING,
        GraphQLError, 'Query error: Can only parse strings to dates but got a: ' + ast.kind, [ast]
      date = moment ast.value, dateFormat
      assertErr date.isValid(),
        GraphQLError, "Query error: Invalid date format, only accepts: #{dateFormat}", [ast]
      date.toDate()
