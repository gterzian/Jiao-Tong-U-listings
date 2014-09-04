Meteor.subscribe("Books")
Meteor.subscribe("Conversations")
Meteor.subscribe("Chats")
Meteor.subscribe("Watches")

categories = ["Beginner 1 - 初一", "Beginner 2 - 初二", "Beginner 3 - 初三", 
              "Intermediate 1 - 中一", "Intermediate 2 - 中二", "Intermediate 3 - 中三",
               "Advanced 1 - 高一", "Advanced 2 - 高二", "Advanced 3 - 高三"]
conditions = ['Like new', 'OK', 'Could be better']
               
Session.setDefault('current_category', categories[0])
Session.set('categories', categories)
Session.set('view_watch', false)



