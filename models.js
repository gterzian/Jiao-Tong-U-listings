books = new Meteor.Collection('Books')
books.allow({
  insert: function (userId, doc) {
    return (userId && doc.userid === userId);
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && doc.userid === userId);
  },
  remove: function (userId, doc) {
    return (userId && doc.userid === userId);
  },
  fetch: ['userid']
})