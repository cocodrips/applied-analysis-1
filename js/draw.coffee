@draw = (N, K, data)->
  graph(N, K, data)
  po(N, K, data)

@po = (N, K, data) ->
  f = (n) ->
    if n == 0
      return 1
    m = 1
    for i in [1..n]
      m *= i
    return m

  numLink = (0 for i in [0...N])
  for link in data.links
    numLink[link.target.index]++
    numLink[link.source.index]++


  # Real
  maximum = 0
  for d in numLink
    maximum = Math.max(maximum, d)
  maximum += 3

  linkDist = (0 for i in [0..maximum])
  for d in numLink
    linkDist[d]++

  maximumY = 0
  for d, i in linkDist
    linkDist[i] = [i, d]
    maximumY = Math.max(maximumY, d)

  # Poisson
  poisson = []
  for i in [0..maximum]
    p = N * (Math.pow(K, i) * Math.pow(2.718, -K)) / f(i)
    poisson.push([i, p])

  maximumY = Math.max(poisson[K][1], maximumY)

  graphWidth = Math.min(25, 500 / (maximum + 1))
  graphHeight = 300 / maximumY

  real = d3.select("#real").selectAll("div")
  .data(linkDist)
  .enter()
  .append("div")
  .attr("class", "bar")
  .style("left", (d)-> return graphWidth * d[0] + "px")
  .style("bottom", 0)
  .style("width", graphWidth + "px")
  .style("height", (d)-> graphHeight * d[1] + "px")

  real.append("div")
  .text((d) -> d[0])
  .attr("class", "axis")
  .style("width", graphWidth + "px")


  d3.select("#po").selectAll("div")
  .data(poisson)
  .enter()
  .append("div")
  .attr("class", "poisson")
  .style("left", (d)-> return graphWidth * d[0] + "px")
  .style("bottom", 0)
  .style("width", graphWidth + "px")
  .style("height", (d)-> graphHeight * d[1] + "px")


@graph = (N, K, data) ->
  width = 500
  height = 400
  force = d3.layout.force()
  .charge(-5000 * K / N)
  .linkDistance(30)
  .size([width, height])

  svg = d3.select('#graph')
  .append('svg')
  .attr('width', width)
  .attr('height', height)

  force
  .nodes(data.nodes)
  .links(data.links)
  .start()
  #
  link = svg.selectAll(".link")
  .data(data.links)
  .enter().append("line")
  .attr("class", "link")
  .style("stroke-width", (d)-> return 1)

  node = svg.selectAll(".node")
  .data(data.nodes)
  .enter().append("circle")
  .attr("class", "node")
  .attr("r", Math.max(1, Math.min(1000 / N, 30)))
  .style("fill", (d) ->return "#76C9C8")
  .call(force.drag)

  node.append("title")
  .text((d) -> return d.name)

  force.on "tick", () ->
    link.attr("x1", (d)-> return d.source.x)
    link.attr("y1", (d)-> return d.source.y)
    link.attr("x2", (d)-> return d.target.x)
    link.attr("y2", (d)-> return d.target.y)

    node.attr("cx", (d) ->  return d.x)
    .attr("cy", (d) -> return d.y)