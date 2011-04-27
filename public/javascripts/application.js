// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
(function() {

  document.observe('dom:loaded', function() {
    $$('textarea#micropost_content').each(function(field) {
      var label;

      function format(count) {
        if (count == 1) {
          return "1 character left";
        } else {
          return count + " characters left";
        }
      }

      label = document.createElement('span');
      label.addClassName('remaining');
      label.innerHTML = format(140);
      field.insert({ after: label });
      
      field.on('keyup', function(evt) {
        var count = 140 - $F(field).length;
        label.innerHTML = format(count);
        if (count > 0) {
          label.removeClassName('nomore');
        } else {
          label.addClassName('nomore');
        }
      });
    });
  });

}());

