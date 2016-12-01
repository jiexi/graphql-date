# graphql-moment [![Build Status](https://travis-ci.org/jiexi/graphql-moment.svg?branch=master)](https://travis-ci.org/jiexi/graphql-moment)
GraphQL Moment Date Type

# Installation
```bash
npm i --save graphql-moment
```

# Usage
```js
var GraphQLMoment = require('graphql-moment')

// Use graphql-moment in your GraphQL objects for Date properties
var fooType = new GraphQLObjectType({
  name: 'Foo',
  description: 'Some foo type',
  fields: {
    created: {
      type: GraphQLMoment(), // defaults to standard ISO 8601 date format
      description: 'Date foo was created'
    }
  }
});

var queryType = new GraphQLObjectType({
  name: 'Query',
  fields: {
    foo: {
      type: fooType,
      resolve: function () {
        // ...
      },
    }
  }
})
```

# Custom date formats
```js
GraphQLMoment() // ISO 8601 format
GraphQLMoment('YYYY-MM-DD') // YYYY-MM-DD format
GraphQLMoment('x') // unix epoch format
```

# License
MIT

# Based on
[https://github.com/tjmehta/graphql-date](https://github.com/tjmehta/graphql-date)
