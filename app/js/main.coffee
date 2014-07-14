###
animation = (d3Selector) ->
 start = d3.transform( "translate(" + this.startPoint.x + "," + this.startPoint.y + ")")
 stop = d3.transform("translate(" + this.stopPoint.x + "," + this.stopPoint.y + ")")
 interpolate = d3.interpolateTransform(start,stop)
 animation_interval = window.setInterval( ()-> 
  frame++; # Get transform Value and aply it to the DOM 
  transformValue = interpolate(frame/(self.fps * self.duration))
  d3Selector.attr("transform", transformValue); 
  # Check if animation should stop 
  if frame >= self.fps * self.duration || self.stopFlag 
   window.clearInterval(animation_interval)
   return
 ,intervalTime)
###

n = 40
random = d3.random.normal(0, .2)
data = d3.range(n).map(random)


l = new d3graphs.line(d3)
l.size(d3graphs.line.makeMargin(20,20,20,40),960,500)
l.setData(data)
l.xScale(0,n-1)
l.yScale(-1,1)

#width = l.width
#height = l.height
#margin = l.margin
#x = l.xScale(0,n-1)
#y = l.yScale(-1,1)

###
console.log l.xScale()



console.log data
 
margin = {top: 20, right: 20, bottom: 20, left: 40}
width = 960 - margin.left - margin.right
height = 500 - margin.top - margin.bottom
 
x = d3.scale.linear()
    .domain([0, n - 1])
    .range([0, width])
 
y = d3.scale.linear()
    .domain([-1, 1])
    .range([height, 0])
 
line = d3.svg.line()
    .x((d, i) ->  x(i) )
    .y((d, i) ->  y(d) )
###

l.draw()


###

svg = d3.select("body").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")
 
svg.append("defs").append("clipPath")
    .attr("id", "clip")
  .append("rect")
    .attr("width", width)
    .attr("height", height)
 
svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + y(0) + ")")
    .call(d3.svg.axis().scale(x).orient("bottom"))
 
svg.append("g")
    .attr("class", "y axis")
    .call(d3.svg.axis().scale(y).orient("left"))
 
path = svg.append("g")
    .attr("clip-path", "url(#clip)")
  .append("path")
    .datum(data)
    .attr("class", "line")
    .attr("d", line)
###

tick = () ->
  ###
  # push a new data point onto the back
  l.dataset.push(random())
 
  # redraw the line, and slide it to the left
  
  path
      .attr("d", l.d3line())
      .attr("transform", null)
    .transition()
      .delay(2000)
      .duration(1000)
      .ease("linear")
      .attr("transform", "translate(" + x(-1) + ",0)")
      .each("end", tick)
      
  
 
  # pop the old data point off the front
  l.dataset.shift()
  ###
  
  l.update(random(),tick)
 
tick()
