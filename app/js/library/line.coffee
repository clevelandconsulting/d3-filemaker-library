class line extends d3graphs.base
 constructor: (d3) ->
  super(d3)
  
 d3line: (reset=false) ->
  if !@_d3line? || reset
   x = @xScale()
   y = @yScale()
   @_d3line = d3.svg.line().x((d, i) ->  x(i) ).y((d, i) ->  y(d) )
  
  @_d3line
  
 draw: (object='body') ->
  svg = @makeSvg(object)
  @makeXAxis(svg)
  @makeYAxis(svg)
  @path = @makePaths(svg)
  
 update: (newDataPoint, callback) ->
  @addToData(newDataPoint)
  x = @xScale()
  @path.attr("d", @d3line())
    .attr("transform", null)
    .transition()
    .delay(2000)
    .duration(500)
    .ease("linear")
    .attr("transform", "translate(" + x(-1) + ",0)")
    .each("end", callback)
   
  @deleteData(0)
 
 makePaths: (svg, _class='line') ->
  svg.append("g")
    .attr("clip-path", "url(#clip)")
  .append("path")
    .datum(@dataset)
    .attr("class", _class)
    .attr("d", @d3line())
 
 xScale: (min=0,max=@dataset.length) ->
  if !@scales.x?
   @scales.x = line.makeLinearScale(min,max,0,@width)
   
  @scales.x
 
 yScale: (min=d3.min(@dataset),max=d3.max(@dataset)) ->
  if !@scales.y?
   @scales.y = line.makeLinearScale(min,max,@height,0)
    
  @scales.y
 
d3graphs.line = line