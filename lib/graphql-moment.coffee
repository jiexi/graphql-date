assertErr = require 'assert-err'
GraphQLScalarType = require('graphql').GraphQLScalarType
GraphQLError = require('graphql/error').GraphQLError
Kind = require('graphql/language').Kind
moment = require 'moment'

module.exports = (dateFormat, name = 'Date') ->

  momentFromString = (value) ->
    if dateFormat
      moment value, dateFormat
    else
      moment value


  stringFromDate = (date) ->
    if dateFormat
      moment(date).format dateFormat
    else
      moment(date).toJSON()


  descriptionForDateFormat = ->
    if dateFormat then dateFormat else 'YYYY-MM-DDTHH:MM:SS.SSSZ'


  new GraphQLScalarType {
    name

    #  Serialize date value into string
    #  @param  {Date} value date value
    #  @return {String} date as string
    serialize: (value) ->
      assertErr value instanceof Date, TypeError, 'Field error: value is not an instance of Date'
      assertErr not isNaN(value.getTime()), TypeError, 'Field error: value is an invalid Date'
      stringFromDate value


    # Parse value into date
    # @param  {*} value serialized date value
    # @return {Date} date value
    parseValue: (value) ->
      date = momentFromString value
      assertErr date.isValid(), TypeError, 'Field error: value is an invalid Date'
      date.toDate()


    # Parse ast literal to date
    # @param  {Object} ast graphql ast
    # @return {Date} date value
    parseLiteral: (ast) ->
      assertErr ast.kind is Kind.STRING,
        GraphQLError, 'Query error: Can only parse strings to dates but got a: ' + ast.kind, [ast]
      date = momentFromString ast.value

      assertErr date.isValid() and ast.value is stringFromDate date,
        GraphQLError, "Query error: Invalid date format, only accepts: #{descriptionForDateFormat()}", [ast]
      date.toDate()
  }
