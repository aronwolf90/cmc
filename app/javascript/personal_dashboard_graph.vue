<template lang='pug'>
  #personal-dashboard-graph
    svg(
      width="100%", 
      preserveAspectRatio="xMidYMid meet",
      viewBox="0 0 900 650"
    )
</template>

<script>
import * as d3 from 'd3'
import { _3d } from 'd3-3d'
import * as Utils from './store/json_api/utils'

export default {
  data () { 
    return {
      j: 10, 
      scale: 20, 
      scatter: [],
      xLine: [],
      yLine: [], 
      xGridData: [], 
      xGrid: null,
      beta: 0, 
      alpha: 0,
      yScale: null,
      grid3d: null,
      point3d: null,
      yScale3d: null,
      svg: null,
      startAngle: Math.PI/9,
      points: [],
      arrows: [],
      yText: null,
      mx: null,
      my: null,
      mouseX: null,
      mouseY: null,
      div: null,
      pointLine: null,
      arrowLine: null
    }
  },
  created () {
    this.$store.dispatch('initUserIssuesForCurrentUser')

    this.div = d3
      .select("body")
      .append("div") 
      .attr("class", "personal-graph-tooltip")       
      .style("opacity", 0);

    this.grid3d = _3d()
      .shape('GRID', 40)
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale);

    this.point3d = _3d()
      .x(d => d.x)
      .y(d => d.y)
      .z(d => d.z)
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale);

    this.arrow3d = _3d()
      .shape('TRIANGLE')
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .x(d => d.x)
      .y(d => d.y)
      .z(d => d.z)
      .scale(this.scale)

    this.xScale3d = _3d()
      .shape('LINE_STRIP')
      .rotateY(this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale)

    this.yScale3d = _3d()
      .shape('LINE_STRIP')
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale);

    this.zScale3d = _3d()
      .shape('LINE_STRIP')
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale);

    this.pointLine = _3d()
      .shape('LINE_STRIP')
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale);

    this.arrowLine = _3d()
      .shape('LINE_STRIP')
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale); 
  },
  computed: {
    userIssues () {
      return this.$store.getters.metaCollection('user_issues') || []
    }
  },
  watch: {
    userIssues (newUserIssues, _oldUserIssues) {
      this.updatePoints(newUserIssues)
    }
  },
  mounted () {
    this.svg = d3.select('svg').append('g');

    this.init()
  },
  methods: { 
    posPointX (d) {
      return d.projected.x;
    },
    posPointY (d) {
      return d.projected.y;
    },
    key (d) { 
      return d.id; 
    }, 
    init () {
      let cnt = 0;
      this.xGridData = []
      this.scatter = []
      this.xLine = []
      this.yLine = []
      this.zLine = []

      for(let z = -6; z < 6; z++) {
        for(let x = -20; x < 20; x++){
          this.xGridData.push([x, 0, z]);
        }
      }

      for (let i = -20; i < 21; i++) {
        this.xLine.push([i, 0, -6])
      }

      for (let i = 0; i < 11; i++) {
        this.yLine.push([-20, -i, -6])
      }

      for (let i = -6; i < 7; i++) {
        this.zLine.push([-20, 0, i])
      }

      let data = [
          this.grid3d(this.xGridData),
          this.point3d(this.scatter),
          this.xScale3d([this.xLine]),
          this.yScale3d([this.yLine]),
          this.zScale3d([this.zLine])
      ];

      this.processData(data, 1000);
    },
    createXZGrid (data) {
      let grid3d = _3d()
        .shape('GRID', 40)
        .rotateY( this.startAngle)
        .rotateX(-this.startAngle)
        .scale(this.scale);

      let XYGrid = []
      for(let z = -6; z < 6; z++) {
        for(let x = -20; x < 20; x++){
          XYGrid.push([x, 0, z]);
        }
      }

      this.svg
        .selectAll('path.grid')
        .data(this.grid3d(XYGrid), this.key)
        .enter()
        .append('path')
        .attr('class', '_3d grid')
        .attr('stroke', 'black')
        .attr('stroke-width', 0.3)
        .attr('fill', function(d){ return d.ccw ? 'lightgrey' : '#717171'; })
        .attr('fill-opacity', 0.9)
        .attr('d', this.grid3d.draw)
        .style('transform', 'translate(50%, 50%)')
    },
    createXAxe (data) {
      let xLine = []
      for (let i = -20; i < 21; i++) {
        xLine.push([i, 0, -6])
      }

      this.svg
        .selectAll('text.xText')
        .data(this.xScale3d([xLine])[0])
        .enter()
        .append('text')
        .attr('class', '_3d xText')
        .attr('dx', '.3em')
        .each(d => {
          d.centroid = {
            x: d.rotated.x, 
            y: d.rotated.y, 
            z: d.rotated.z
          }
        })
        .attr('x', d => d.projected.x)
        .attr('y', d => d.projected.y)
        .text(d => {
          if (d[0] % 10 == 0) {
            return new Date(
              new Date() - 1000*3600*24*7*(d[0] + 20)
            ).toLocaleDateString()
          }
          else return ''
        })
        .style('transform', 'translate(50%, 50%)')
    },
    createYAxe (data) {
      let yLine = []
      for (let i = 0; i < 19; i++) {
        yLine.push([-20, -i, -6])
      }

      this.svg
        .selectAll('path.yScale')
        .data(this.yScale3d([yLine]))
        .enter()
        .append('path')
        .attr('id', 'y-axe')
        .attr('class', '_3d yScale')
        .attr('stroke', 'black')
        .attr('stroke-width', .5)
        .attr('d', this.yScale3d.draw)
        .style('transform', 'translate(50%, 50%)')

      this.svg
        .append('g')
        .append('text')
        .attr('dy', '12px')
        .style("font-size", "15px")
        .append("textPath")
        .attr("xlink:href", "#y-axe")
        .attr('startOffset', '100px')
        .text("Consumed hours")

      this.svg
        .selectAll('text.yText')
        .data(this.yScale3d([yLine])[0])
        .enter()
        .append('text')
        .attr('class', '_3d yText')
        .attr('dx', '.3em')
        .each(function(d){
          d.centroid = {x: d.rotated.x, y: d.rotated.y, z: d.rotated.z};
        })
        .attr('x', function(d){ return d.projected.x; })
        .attr('y', function(d){ return d.projected.y; })
        .text(d => d[1] <= 0 ? - d[1] : '')
        .style('transform', 'translate(50%, 50%)')
    },
    createZAxe (data) {
      let zLine = []
      for (let i = -6; i < 7; i++) {
        zLine.push([-20, 0, i])
      }

      this.svg
        .selectAll('text.zText')
        .data(this.zScale3d([zLine])[0])
        .enter()
        .append('text')
        .attr('class', '_3d zText')
        .attr('dx', '.3em')
        .each(function(d){
          d.centroid = {x: d.rotated.x, y: d.rotated.y, z: d.rotated.z};
        })
        .attr('x', function(d){ return d.projected.x; })
        .attr('y', function(d){ return d.projected.y; })
        .text(d => {
          if (d[2] % 3 == 0) return d[2] + 6
          else return ''
        })
        .style('transform', 'translate(50%, 50%)')

      this.svg
        .selectAll('path.zAxe')
        .data(this.zScale3d([zLine]))
        .enter()
        .append('path')
        .attr('id', 'z-axe')
        .attr('class', '_3d zAxe')
        .attr('stroke', 'black')
        .attr('stroke-width', .5)
        .attr('d', this.yScale3d.draw)
        .style('transform', 'translate(50%, 50%)')

      this.svg
        .append('g')
        .append('text')
        .attr('dx', '-5px')
        .attr('dy', '-5px')
        .style('font-size', '15px')
        .append('textPath')
        .attr('xlink:href', '#z-axe')
        .attr('startOffset', '35px')
        .text('Complexity');
    },
    processData() {
      this.createXZGrid()
      this.createXAxe()
      this.createYAxe()
      this.createZAxe()
      this.updatePoints(this.userIssues)
    },
    posPointX (d) {
      return d.projected.x;
    },
    posPointY (d) {
      return d.projected.y;
    },
    key (d) { 
      return d.id; 
    }, 
    addPoint (title, date, hours, complexity) {
      if (date < new Date() - 40*7*24*3600*1000) return
      if (!complexity) return

      let x = -20 + (new Date() - date)/(24*3600*1000*7)
      let z = -6 + complexity

      if (hours < 17) {
        this.points.push({
          x: x,
          y: -hours,
          z: z,
          date: date,
           hours: hours,
          complexity: complexity,
          title: title
        })
      }
      else {
        this.arrows.push({
          x: x,
          y: -16,
          z: z,
          date: date,
          hours: hours,
          complexity: complexity,
          title: title
        })
      }

      this.svg
        .selectAll('path.point-line')
        .data(this.pointLine(this.points.map(d => [
          [d.x, 0, d.z], [d.x, d.y, d.z]
        ])))
        .enter()
        .append('path')
        .attr('class', '_3d point-line')
        .attr('stroke', 'black')
        .attr('stroke-width', .5)
        .attr('d', this.pointLine.draw)
        .style('transform', 'translate(50%, 50%)')

      this.svg
        .selectAll('path.arrow-line')
        .data(this.arrowLine(this.arrows.map(d => [
          [d.x, d.y, d.z], [d.x, 0, d.z]
        ])))
        .enter()
        .append('path')
        .attr('class', '_3d arrow-line')
        .attr('stroke', 'black')
        .attr('stroke-width', .5)
        .attr('d', this.arrowLine.draw)
        .style('transform', 'translate(50%, 50%)')

      this.svg
        .selectAll('circle')
        .data(this.point3d(this.points), this.key)
        .enter()
        .append('circle')
        .attr('class', '_3d')
        .attr('opacity', 0)
        .attr('cx', this.posPointX)
        .attr('cy', this.posPointY)
        .attr('r', 5)
        .attr('stroke', function(d){ return d3.rgb(12, 67, 199) })
        .attr('fill', function(d){ return d3.rgb(12, 67, 199) })
        .attr('opacity', 1)
        .on('mouseover', d => {   
          this.div
            .transition()   
            .duration(10)   
            .style("opacity", .9) 
          this.div.html(
              '<center><b>' + d.title + '</b></center><br/>' +
              "date: " + d.date.toLocaleDateString() + "<br/>" +  
              "hours: " + d.hours.toFixed(2) + "<br/>" +
              "complexity: " + d.complexity
            )
            .style("left", (d3.event.pageX + 4) + "px")
            .style("top", (d3.event.pageY - 28 + 4) + "px")     
        })
        .on('mouseout', d => {
          this.div
            .transition()
            .duration(500)
            .style("opacity", 0)
        })
        .style('transform', 'translate(50%, 50%)')

      this.svg
        .selectAll('.arrow')
        .data(this.arrow3d(
          this.arrows.map(d => {
            return [
              {
                x: d.x-0.5, y: d.y, z: d.z, 
                date: d.date, 
                complexity: d.complexity,
                title: d.title,
                hours: d.hours
              }, 
              {x: d.x,     y: d.y-0.5, z: d.z}, 
              {x: d.x+0.5, y: d.y,     z: d.z}
            ]
          })
        ))
        .enter()
        .append('path')
        .attr('class', '_3d arrow')
        .attr('stroke', 'black')
        .attr('fill', d => d3.rgb(12, 67, 199))
        .attr('d', this.arrow3d.draw)
        .on('mouseover', d => {   
          this.div
            .transition()   
            .duration(10)   
            .style("opacity", .9) 
          this.div.html(
              '<center><b>' + d[0].title + '</b></center><br/>' +
              "date: " + d[0].date.toLocaleDateString() + "<br/>" +  
              "hours: " + d[0].hours.toFixed(2) + "<br/>" +
              "complexity: " + d[0].complexity
            )
            .style("left", (d3.event.pageX + 4) + "px")
            .style("top", (d3.event.pageY - 28 + 4) + "px")     
        })
        .on('mouseout', d => {
          this.div
            .transition()
            .duration(500)
            .style("opacity", 0)
        })
        .style('transform', 'translate(50%, 50%)')
    },
    updatePoints (userIssues) {
      for (let userIssue of userIssues) {
        let issue = this.$store.getters.associatedEntry({
          entry: userIssue, 
          name: 'issue'
        })
        this.addPoint(
          Utils.attribute(issue, 'title'),
          new Date(Utils.attribute(userIssue, 'start-time')),
          Utils.attribute(userIssue, 'spent-time')/3600,
          Utils.attribute(issue, 'complexity')/1
        )
      }
    },
  },
  mounted () {
    this.svg = d3.select('svg').append('g'); 
    this.init()
  }
}
</script>

<style lang='sass' scoped>
#personal-dashboard-graph
  svg
    max-height: 500px
</style>

<style lang='sass'>
  div.personal-graph-tooltip
    position: absolute
    width: 120px
    height: 80px
    padding: 2px
    font: 12px sans-serif
    background: lightsteelblue
    border: 0px
    border-radius: 8px    
    pointer-events: none 
    z-index: 1000000
</style>
