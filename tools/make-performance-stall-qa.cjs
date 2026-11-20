// Inject one minute of clock debt into a separate QA movie, never the release.
const fs = require('fs');
const {spawnSync} = require('child_process');
const folder = 'build/performance-test-scripts';
const name = '/com/urbansquall/metronome/Ticker.as';
fs.mkdirSync(folder + '/com/urbansquall/metronome', {recursive:true});
fs.cpSync('build/import-scripts',folder,{recursive:true});
let source = fs.readFileSync('remaster/scripts' + name, 'utf8').replace(/\r/g,'');
source = source.replace('this.m_timeOfLastUpdate = getTimer();', 'this.m_timeOfLastUpdate = getTimer() - 60000;');
source = source.replace('while(this.m_accruedTime >= this.m_delay)', 'var qaSteps:int = 0;\n         while(this.m_accruedTime >= this.m_delay)');
source = source.replace('dispatchEvent(new TickerEvent(this.m_delay));', '++qaSteps;\n            dispatchEvent(new TickerEvent(this.m_delay));');
source = source.replace('         }\n      }\n      \n      public function get running()', '         }\n         if(_loc3_ >= 60000)trace("Stall QA updates: " + qaSteps);\n      }\n      \n      public function get running()');
// Guard against source-layout changes before compiling a test movie.
if(!source.includes('Stall QA updates:')) {
  source = source.replace(/(dispatchEvent\(new TickerEvent\(this.m_delay\)\);\s*}\s*)(})/, '$1if(_loc3_ >= 60000)trace("Stall QA updates: " + qaSteps);\n      $2');
}
if(!source.includes('Stall QA updates:'))throw Error('QA instrumentation was not inserted');
source = source.replace('trace("Stall QA updates: " + qaSteps);',`{
            trace("Stall QA updates: " + qaSteps);
            var resultText:flash.text.TextField = new flash.text.TextField();
            resultText.defaultTextFormat = new flash.text.TextFormat("_sans",14,0x00FF00,true);
            resultText.width = 330;
            resultText.height = 25;
            resultText.x = 8;
            resultText.y = 34;
            resultText.background = true;
            resultText.backgroundColor = 0x161B22;
            resultText.text = "60s stall: " + qaSteps + " updates (limit 5)";
            com.whatthefawk.screens.Root.stage.addChild(resultText);
         }`);
fs.writeFileSync(folder + name, source);
const rootName = '/com/whatthefawk/screens/Root.as';
let rootSource = fs.readFileSync(folder + rootName,'utf8');
rootSource = rootSource.replace('this.m_ticker = new Ticker(this.TICK_INTERVAL);', `
         var qaClean:Boolean = true;
         for(var qaIndex:int = 0; qaIndex < 10; ++qaIndex)
         {
            trace("Cleanup QA: create display");
            var qaDisplay:com.whatthefawk.particleEffects.ParticleEffectDisplay = new com.whatthefawk.particleEffects.ParticleEffectDisplay(new com.whatthefawk.particleEffects.ParticleEffectDisplayParams());
            var qaEffect:com.whatthefawk.particleEffects.ParticleEffect = new com.whatthefawk.particleEffects.ParticleEffect(new com.whatthefawk.particleEffects.ParticleEffectParams(null));
            trace("Cleanup QA: create effect");
            qaEffect.addEmitter(new org.flintparticles.twoD.emitters.Emitter2D());
            trace("Cleanup QA: start emitter");
            qaDisplay.addParticleEffect(qaEffect);
            var qaRenderer:com.whatthefawk.particleEffects.ParticleRenderer = qaDisplay.renderer;
            trace("Cleanup QA: dispose display");
            qaDisplay.dispose();
            trace("Cleanup QA: disposed");
            qaClean = qaClean && qaRenderer.bitmapData == null;
         }
         qaClean = qaClean && !org.flintparticles.common.utils.FrameUpdater.instance.hasEventListener(org.flintparticles.common.events.UpdateEvent.UPDATE);
         var qaLabel:TextField = new TextField();
         qaLabel.defaultTextFormat = new TextFormat("_sans",14,0x00FF00,true);
         qaLabel.width = 390;
         qaLabel.height = 25;
         qaLabel.x = 8;
         qaLabel.y = 62;
         qaLabel.background = true;
         qaLabel.backgroundColor = 0x161B22;
         qaLabel.text = "10 effect lifecycles: " + (qaClean ? "PASS" : "FAIL");
         Root.stage.addChild(qaLabel);
         if(!qaClean)throw new Error("Particle cleanup QA failed");
         this.m_ticker = new Ticker(this.TICK_INTERVAL);`);
fs.writeFileSync(folder + rootName,rootSource);
const result = spawnSync('java', ['-jar',process.env.FFDEC_JAR || 'C:/Program Files (x86)/FFDec/ffdec.jar','-onerror','abort','-importScript','build/get-my-roof-remaster.swf','build/performance-stall-qa.swf',folder], {encoding:'utf8'});
fs.writeFileSync('docs/performance-stall-build.log',(result.stdout||'')+(result.stderr||''));
if(result.error || result.status !== 0)throw result.error || Error('Stall QA compile failed');
console.log('Built one-minute stall QA movie; release unchanged.');
