<template lang='pug'>
  #personal-dashboard-graph
    svg(
      width="100%", 
      height="auto", 
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
      yText: null,
      mx: null,
      my: null,
      mouseX: null,
      mouseY: null
    }
  },
  created () {
    this.$store.dispatch('initUserIssuesForCurrentUser')

    this.grid3d = _3d()
      .shape('GRID', 40)
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale);

    this.point3d = _3d()
      .x(function(d) { return d.x })
      .y(function(d) { return d.y })
      .z(function(d) { return d.z })
      .rotateY( this.startAngle)
      .rotateX(-this.startAngle)
      .scale(this.scale);

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
  },
  computed: {
    userIssues () {
      return this.$store.getters.metaCollection('user_issues') || []
    }
  },
  watch: {
    userIssues (newUserIssues, _oldUserIssues) {
      for (let userIssue of newUserIssues) {
        let issue = this.$store.getters.associatedEntry({
          entry: userIssue, 
          name: 'issue'
        })
        this.addPoint(
          new Date(Utils.attribute(userIssue, 'start-time')),
          Utils.attribute(userIssue, 'spent-time')/3600,
          Utils.attribute(issue, 'complexity')/1
        )
        console.log(Utils.attribute(issue, 'complexity'))
      }
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
    addPoint(date, hours, complexity) {
      if (date < new Date() - 40*7*24*3600*1000) return
      this.points.push({
        x: -18 + (new Date() - date)/(24*3600*1000*7),
        y: 17 - hours,
        z: -5 + complexity
      })

      this.svg
        .selectAll('circle')
        .data(this.point3d(this.points), this.key)
        .enter()
        .append('circle')
        .attr('class', '_3d')
        .attr('opacity', 0)
        .attr('cx', this.posPointX)
        .attr('cy', this.posPointY)
        .transition().duration(0.1)
        .attr('r', 3)
        .attr('stroke', function(d){ return d3.rgb(12, 67, 199) })
        .attr('fill', function(d){ return d3.rgb(12, 67, 199) })
        .attr('opacity', 1)
        .style('transform', 'translate(50%, 50%)')
    },
    init(){
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
    createXZGrid(data) {
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
      for (let i = 0; i < 11; i++) {
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
        .style("font-size", "15px")
        .append("textPath")
        .attr("xlink:href", "#y-axe")
        .attr('startOffset', '35px')
        .text("Consumed hours");

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
        .text(function(d){ return d[1] <= 0 ? d[1] : ''; })
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
        .style("font-size", "15px")
        .append("textPath")
        .attr("xlink:href", "#z-axe")
        .attr('startOffset', '35px')
        .text("Complexity");
    },
    processData(data, tt) {
      this.createXZGrid(data)
      this.createXAxe(data)
      this.createYAxe(data)
      this.createZAxe(data)
    }
  }
}
</script>

<style lang='sass'>
</style>
