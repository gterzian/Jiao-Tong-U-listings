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

conversations = new Meteor.Collection('Conversations')
conversations.allow({
  insert: function (userId, doc) {
    return (userId && _.contains(doc.users, userId));
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && _.contains(doc.users, userId));
  },
  remove: function (userId, doc) {
   return (userId && _.contains(doc.users, userId));
  },
  fetch: ['userid', 'users']
})

watches = new Meteor.Collection('Watches')
watches.allow({
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