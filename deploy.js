'use strict';
/* jshint node: true */

var http = require('http');
var spawn = require('child_process').execFile;
var fs = require('fs');
var port = process.env.DEPLOY_PORT || 8008;
var execOptions = {
     maxBuffer: 1024 * 1024 // 1mb
};

http.createServer(function(req, res) {
    if (req.url !== '/push') {
        res.writeHead(400);
        res.end(req.url + ' not allowed');
        return;
    }

    console.log('Running on %s', process.cwd());
    res.writeHead(202, { 'Content-Type': 'text/plain' });
    res.write('Running...\n');

    var execOptions = {
        cwd: process.cwd(),
        maxBuffer: 1024 * 1024 // 1mb
    };

    spawn('./deploy.sh', execOptions, function(e, out, err) {
        var result = e || out.toString() || err.toString()
        console.log(result);
        fs.writeFile('./deploy.txt', result);
        res.end(result);
    });
}).listen(port);

console.log('Listening on %d', port);