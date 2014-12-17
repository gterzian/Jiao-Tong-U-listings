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
    return (userId && doc.userId === userId);
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && doc.userId === userId);
  },
  remove: function (userId, doc) {
    return (userId && doc.userId === userId);
  },
  fetch: ['userId']
})

matches = new Meteor.Collection('Matches')
matches.allow({
  insert: function (userId, doc) {
    return (userId && doc.userId === userId);
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && doc.userId === userId);
  },
  remove: function (userId, doc) {
    return (userId && doc.userId === userId);
  },
  fetch: ['userId']
})

trust = new Meteor.Collection('Trust')
trust.allow({
  insert: function (userId, doc) {
    return (userId && doc.userId === userId);
  },
  update: function (userId, doc, fields, modifier) {
    return (userId && doc.userId === userId);
  },
  remove: function (userId, doc) {
    return (userId && doc.userId === userId);
  },
  fetch: ['userId']
})
