// Generated by CoffeeScript 1.6.2
exports.clean = function(html) {
  return html.replace(/&nbsp;/g, '').replace(/\t|\n|\r/g, '').replace(/<[^>]+>+/g, '').replace(/\ {2,}/g, ' ');
};
