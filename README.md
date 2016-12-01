# graphql-moment [![Build Status](https://travis-ci.org/jiexi/graphql-moment.svg?branch=master)](https://travis-ci.org/jiexi/graphql-moment)
GraphQL Moment Date Type

# Installation
```bash
npm i --save graphql-moment
```

# Usage
```js
var {Factory, GraphQLDate} = require('graphql-moment')

// Use graphql-moment in your GraphQL objects for Date properties
var fooType = new GraphQLObjectType({
  name: 'Foo',
  description: 'Some foo type',
  fields: {
    created: {
      type: GraphQLDate, // defaults to standard ISO 8601 date format
      description: 'Date foo was created'
    }
  }
});

var fooType = new GraphQLObjectType({
  name: 'Foo',
  description: 'Some foo type',
  fields: {
    created: {
      type: GraphQLDate, // defaults to standard ISO 8601 date format
      description: 'Date foo was created'
    }
  }
});

```

# Built-in date formats
```js
GraphQLDate // Standard ISO 8601
GraphQLUnixTime // Milliseconds since 1970-01-01 UTC
GraphQLMMDDYYYY // MM-DD-YYYY format
GraphQLYYYYMMDD // YYYY-MM-DD format
```


# Custom date formats
```js
GraphQLTime = Factory('h:mm:ss', 'Time')
GraphQLEmit = Factory('ss:mm:h', 'Emit')
```

# License
MIT

# Based on
[https://github.com/tjmehta/graphql-date](https://github.com/tjmehta/graphql-date)
