assertErr = require 'assert-err'
GraphQLScalarType = require('graphql').GraphQLScalarType
GraphQLError = require('graphql/error').GraphQLError
Kind = require('graphql/language').Kind

module.exports = ({inputFormat}) ->

  new GraphQLScalarType
    name: 'Date'

    #  Serialize date value into string
    #  @param  {Date} value date value
    #  @return {String} date as string
    serialize: (value) ->
      assertErr value instanceof Date, TypeError, 'Field error: value is not an instance of Date'
      assertErr not isNaN(value.getTime()), TypeError, 'Field error: value is an invalid Date'
      value.toJSON()

    # Parse value into date
    # @param  {*} value serialized date value
    # @return {Date} date value
    parseValue: (value) ->
      date = new Date value
      assertErr not isNaN(date.getTime()), TypeError, 'Field error: value is an invalid Date'
      date

    # Parse ast literal to date
    # @param  {Object} ast graphql ast
    # @return {Date} date value
    parseLiteral: (ast) ->
      assertErr ast.kind === Kind.STRING,
        GraphQLError, 'Query error: Can only parse strings to dates but got a: ' + ast.kind, [ast]
      result = new Date ast.value
      assertErr not isNaN(result.getTime()),
        GraphQLError, 'Query error: Invalid date', [ast]
      assertErr ast.value === result.toJSON(),
        GraphQLError, 'Query error: Invalid date format, only accepts: YYYY-MM-DDTHH:MM:SS.SSSZ', [ast]
      result
