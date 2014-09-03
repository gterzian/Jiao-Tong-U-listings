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

chats = new Meteor.Collection('Chats')
chats.allow({
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