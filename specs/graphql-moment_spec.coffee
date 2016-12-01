Kind = require('graphql/language').Kind
GraphQLMoment = require('../lib/graphql-moment')

describe 'GraphQLMoment', ->
  describe 'serialize', ->
    describe 'non-date object', ->
      it 'returns an error', ->
        str = '2015-07-24T10:56:42.744Z'
        expect(-> GraphQLMoment().serialize str).to.throw /not an instance of Date/

    describe 'invalid date object', ->
      it 'returns an error', ->
        date = new Date 'invalid'
        expect(-> GraphQLMoment().serialize date).to.throw /an invalid Date/

    describe 'date object', ->
      describe 'default date format', ->
        it 'returns a date string', ->
          date = new Date '2015-07-24T10:56:42.744Z'
          expect(GraphQLMoment().serialize date).to.equal date.toJSON()

      describe 'custom date format', ->
        it 'returns a date string', ->
          date = new Date '1970-01-01T00:00:01.000Z'
          expect(GraphQLMoment('x').serialize date).to.equal '1000'

  describe 'parseValue', ->
    describe 'invalid date string', ->
      describe 'default date format', ->
        it 'returns an error', ->
          expect(-> GraphQLMoment().parseValue 'invalid').to.throw /an invalid Date/

      describe 'custom date format', ->
        it 'returns an error', ->
          expect(-> GraphQLMoment('x').parseValue '123-invalid').to.throw /an invalid Date/

    describe 'valid date string', ->
      describe 'default date format', ->
        it 'returns a date object', ->
          str = '2015-07-24T10:56:42.744Z'
          date = GraphQLMoment().parseValue str
          expect(date).to.be.an.instanceOf Date
          expect(date.toJSON()).to.equal str

      describe 'custom date format', ->
        it 'returns a date object', ->
          str = '1000'
          date = GraphQLMoment('x').parseValue str
          expect(date).to.be.an.instanceOf Date
          expect(date.toJSON()).to.equal '1970-01-01T00:00:01.000Z'

  describe 'parseLiteral', ->
    describe 'invalid ast', ->
      it 'returns an error', ->
        ast = kind: Kind.INT
        expect(-> GraphQLMoment().parseLiteral ast).to.throw /only parse strings/

    describe 'invalid date string', ->
      describe 'default date format', ->
        it 'returns an error', ->
          ast =
            kind: Kind.STRING
            value: 'invalid'
          expect(-> GraphQLMoment().parseLiteral ast).to.throw /Invalid date format/

      describe 'custom date format', ->
        it 'returns an error', ->
          ast =
            kind: Kind.STRING
            value: '123-invalid'
          expect(-> GraphQLMoment('x').parseLiteral ast).to.throw /Invalid date format/

    describe 'valid date string', ->
      describe 'default date format', ->
        it 'returns a date object', ->
          ast =
            kind: Kind.STRING
            value: '2015-07-24T10:56:42.744Z'
          date = GraphQLMoment().parseLiteral ast
          expect(date).to.be.an.instanceOf Date
          expect(date.toJSON()).to.equal ast.value

      describe 'custom date format', ->
        it 'returns a date object', ->
          ast =
            kind: Kind.STRING
            value: '1000'
          date = GraphQLMoment('x').parseLiteral ast
          expect(date).to.be.an.instanceOf Date
          expect(date.toJSON()).to.equal '1970-01-01T00:00:01.000Z'
