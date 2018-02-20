
/* Data */
function testPlotly(name) {
    var url2 = '/metadata/' + name;
    var url3 = '/samples/'  + name;
    var url4 = '/WFREQval/' + name;
    var url5 = '/samples2/' + name;
    console.log(url4);

    Plotly.d3.json(url2, function (error, metaData) {
        console.log(metaData);
        Plotly.d3.select("tbody")
            .html("")
            .selectAll("tr")
            .data(metaData)
            .enter()
            .append("tr")
            .html(function (d) {
                return `<td>${d.t0}</td><td>${d.t1}</td>`
            });
    }

    );
    // Pie Plot
    Plotly.d3.json(url3, function (error, pieData) {

        var labels0 = pieData['otu_id']

        var values0 = pieData['sample_values']

        var data = [{
            values: values0,
            labels: labels0,
            type: "pie"
        }];

        var layout = {
            height: 500,
            width: 700
        };
        Plotly.newPlot("plot1", data, layout);
        
    });
    // End
    
    // Scatter
    Plotly.d3.json(url5, function (error, pieData) {

        var labels0 = pieData['otu_id']

        var values0 = pieData['sample_values']

        var data = [{
            y: values0,
            x: labels0,
            mode: 'markers',
            marker: {
                color: labels0, colorscale: 'Bluered', colorbar: {
                    title: 'Germ Code',
                    titleside: 'right'}, size: values0, sizeref: 1 },  
            type: 'scatter'
        }];

        var layout = {
            height: 500,
            width: 500
        };
        Plotly.newPlot("plot3", data, layout);
        
    });

    //End Scatter 

    // Plot Data
    Plotly.d3.json(url4, function (error, guageData) {
        var WFREQ = guageData.WFREQ;
        console.log(guageData.WFREQ);
        plotGuage(WFREQ);
    });
    // End plot Data 


}


init();