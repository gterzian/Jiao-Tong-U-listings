Template.watches.categories = ->
  categories

Template.watches.conditions = ->
  conditions
  
Template.watches.watches = ->
  watches.find()
  
  
Template.watches.events
  'click #add_watch': (e,t) ->
    e.preventDefault()
    unless watches.findOne(condition:t.find("#condition").value, category: t.find("#category").value)
      watch_id = watches.insert
        watched: false
        condition: t.find("#condition").value
        category: t.find("#category").value
        userid:  Meteor.userId()
        contact: Meteor.user().emails[0]['address']
 
        
  'click .remove_watch': (e,t) ->
    e.preventDefault()
    console.log(e.currentTarget.id)
    watches.remove e.currentTarget.id