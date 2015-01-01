@getParams = ->
  url = location.href
  parameters    = url.split("?");
  params = {}

  if !parameters[1]
    return params
  for param in parameters[1].split("&")
    d = param.split("=")
    params[d[0]] = d[1]
  return params