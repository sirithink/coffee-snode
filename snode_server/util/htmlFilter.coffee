exports.clean = (html)->
  html.replace(/\ |\t|\n|\r/g, '').replace(/<[^>]+>+/g, '')