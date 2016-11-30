# graphql-moment <!-- [![Build Status](https://travis-ci.org/tjmehta/graphql-date.svg)](https://travis-ci.org/tjmehta/graphql-date) [![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](http://standardjs.com/) -->
GraphQL Moment Date Type

# Installation
```bash
npm i --save graphql-moment
```

# Usage
```js
var GraphQLDate = require('graphql-moment')

// Use graphql-moment in your GraphQL objects for Date properties
var fooType = new GraphQLObjectType({
  name: 'Foo',
  description: 'Some foo type',
  fields: {
    created: {
      type: GraphQLMoment,
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

# License
MIT
