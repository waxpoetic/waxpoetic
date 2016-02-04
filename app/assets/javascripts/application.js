//= require loader
//= require jquery
//= require jquery_ujs
//= require lodash
//= require foundation
//= require turbolinks
//= require_tree .
//= require_self .

// Load foundation before loading all other modules
module.on('init', function(loadModules, event) {
  $(document).foundation();
  loadModules($(event.currentTarget));
});

// Send current scope to modules on load
module.on('load', function(current, scope) {
  current(scope);
});

// Load all modules when Turbolinks changes pages as well as immediately
// on DOM ready.
$(document).on('ready page:load', module.init);
