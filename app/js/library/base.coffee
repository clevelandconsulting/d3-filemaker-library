class base 
 constructor: (@d3) ->
  @dataset = []
  @scales = {}
 
 @makeMargin: (top,right,bottom,left) ->
  {top: top, right: right, bottom: bottom, left: left}
  
 @makeLinearScale: (dMin,dMax,rMin,rMax) ->
  scale = d3.scale.linear()
  if (dMin != null || dMax != null)
   scale = scale.domain([dMin,dMax])
  if (rMin != null || rMax != null)
   scale = scale.range([rMin, rMax])
  
  scale
  
 makeSvg: (object) ->
  svg = d3.select(object).append("svg")
    .attr("width", @width + @margin.left + @margin.right)
    .attr("height", @height + @margin.top + @margin.bottom)
    .append("g")
    .attr("transform", "translate(" + @margin.left + "," + @margin.top + ")")
    
  svg.append("defs").append("clipPath")
    .attr("id", "clip")
    .append("rect")
    .attr("width", @width)
    .attr("height", @height)
  
  svg
  
 
 makeXAxis: (svg, _class='x axis', _orientation='bottom') ->
  svg.append("g")
    .attr("class", _class)
    .attr("transform", "translate(0," + @scales.y(0) + ")")
    .call(d3.svg.axis().scale(@scales.x).orient(_orientation))
 
 makeYAxis: (svg, _class='y axis', _orientation='left') ->
  svg.append("g")
    .attr("class", _class)
    .call(d3.svg.axis().scale(@scales.y).orient(_orientation))
  
 size: (margin,width,height)->
  @margin = margin
  @width = width - margin.left - margin.right
  @height = height - margin.top - margin.bottom
  
 setData: (dataset) ->
  @dataset = dataset
  
 addToData: (newDataPoint) ->
  @dataset.push(newDataPoint)
  
 deleteData: (i) ->
  @dataset.splice(i,1)
  
  
d3graphs.base = base