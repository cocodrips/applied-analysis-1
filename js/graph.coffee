$ ->
  params = getParams()
  if params.N
    $("#N").val(params.N)
  if params.K
    $("#K").val(params.K)
  N = params.N || 100
  K = params.K || 3
  console.log N, K

  # Create a random graph
  nodes = []
  for i in [0...N]
    nodes.push({"name": i, "group": 1})

  links = []
  for i in [0...N]
    for j in [0...i]
      if Math.random() < K / N
        links.push({"source": i, "target": j, "value": 1})
  data = {nodes: nodes, links: links}
  draw(N, K, data)
