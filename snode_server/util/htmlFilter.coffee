###
  **
  *对html的剥离
  *
###
exports.clean = (html)->
  html.replace(/&nbsp;|\t|\n|\r/g, '').replace(/<[^>]+>/g, '').replace(/\ {2,}/g, ' ')
