{GraphQLScalarType} = require 'graphql'
{GraphQLError} = require 'graphql/error'
{Kind} = require 'graphql/language'
assertErr = require 'assert-err'
moment = require 'moment'


module.exports = (dateFormat, name = 'Date') ->

  momentFromValue = (value) ->
    if dateFormat
      moment value, dateFormat, true
    else
      moment value, moment.ISO_8601, true


  valueFromDate = (date) ->
    if dateFormat
      moment(date).format dateFormat
    else
      moment(date).toISOString()


  descriptionForDateFormat = ->
    if dateFormat then dateFormat else 'YYYY-MM-DDTHH:MM:SS.SSSZ'


  new GraphQLScalarType {
    name

    #  Serialize date value into string
    #  @param  {Date} value date value
    #  @return {String} date as string
    serialize: (date) ->
      assertErr date instanceof Date, TypeError, 'Field error: value is not an instance of Date'
      assertErr not isNaN(date.getTime()), TypeError, 'Field error: value is an invalid Date'
      valueFromDate date


    # Parse value into date
    # @param  {*} value serialized date value
    # @return {Date} date value
    parseValue: (value) ->
      date = momentFromValue value
      assertErr date.isValid(), TypeError, 'Field error: value is an invalid Date'
      date.toDate()


    # Parse ast literal to date
    # @param  {Object} ast graphql ast
    # @return {Date} date value
    parseLiteral: (ast) ->
      assertErr ast.kind is Kind.STRING,
        GraphQLError, 'Query error: Can only parse strings to dates but got a: ' + ast.kind, [ast]
      date = momentFromValue ast.value
      assertErr (date.isValid() and ast.value is valueFromDate date),
        GraphQLError, "Query error: Invalid date format, only accepts: #{descriptionForDateFormat()}", [ast]
      date.toDate()
  }
