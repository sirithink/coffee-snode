var cache = window.cache = {};

cache.get = function(key){
    return this[key];
};
cache.put = function(key, value){
    cache[key] = value;
};