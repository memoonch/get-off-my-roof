const http = require('http');
const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname,'..');
http.createServer((req,res)=>{
  const pathname = new URL(req.url,'http://localhost').pathname;
  if(pathname === '/') {
    res.setHeader('Content-Type','text/html');
    return res.end(`<!doctype html><html><head><meta charset="utf-8"><title>Get Off My Roof — Original Game</title><style>body{margin:0;background:#161b22;color:#ddd;font:16px system-ui;display:grid;justify-items:center}h1{font-size:22px;margin:24px 0 12px}#game{width:640px;height:480px;background:#000}ruffle-player{width:100%;height:100%}p{color:#aab4c0}</style><script>window.RufflePlayer={config:{autoplay:'on',unmuteOverlay:'visible',allowNetworking:'none',openUrlMode:'deny'}};</script><script src="https://unpkg.com/@ruffle-rs/ruffle/ruffle.js"></script></head><body><h1>Get Off My Roof · original</h1><div id="game"></div><p>A / D move · Space jump · W primary · Mouse secondary · Q wetnap · 1–6 select weapon</p><script>window.addEventListener('load',()=>{if(!window.RufflePlayer?.newest){document.getElementById('game').textContent='Ruffle failed to load';return;}const p=window.RufflePlayer.newest().createPlayer();document.getElementById('game').append(p);p.ruffle().load('/game.swf');});</script></body></html>`);
  }
  if(pathname==='/game.swf') {res.setHeader('Content-Type','application/x-shockwave-flash');return fs.createReadStream(path.join(root,'source/get-my-roof.swf')).pipe(res);}
  res.writeHead(404);res.end();
}).listen(8123,'127.0.0.1',()=>console.log('Preview: http://127.0.0.1:8123'));
