require('coffee-script/register');
const Factory = require('./lib/factory.coffee');

const GraphQLDate = Factory();
const GraphQLUnixTime = Factory('x', 'UnixTime');
const GraphQLYYYYMMDD = Factory('YYYY-MM-DD', 'YearMonthDay');
const GraphQLMMDDYYYY = Factory('MM-DD-YYYY', 'MonthDayYear');

module.exports = {
  Factory,
  GraphQLDate,
  GraphQLUnixTime,
  GraphQLMMDDYYYY,
  GraphQLYYYYMMDD
}
