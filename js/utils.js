// Generated by CoffeeScript 1.6.3
(function() {
  this.getParams = function() {
    var d, param, parameters, params, url, _i, _len, _ref;
    url = location.href;
    parameters = url.split("?");
    params = {};
    if (!parameters[1]) {
      return params;
    }
    _ref = parameters[1].split("&");
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      param = _ref[_i];
      d = param.split("=");
      params[d[0]] = d[1];
    }
    return params;
  };

}).call(this);