const assert=require('node:assert/strict');
const {inspect}=require('./weapon-swf-assets.cjs');
const source=inspect(),release=inspect('build/get-my-roof-remaster.swf');
assert.equal(release.length,35);
for(let i=0;i<source.length;i++){
 assert.equal(release[i].id,source[i].id);
 assert.deepEqual(release[i].bounds,source[i].bounds,'Registration changed: '+source[i].name);
 assert.equal(release[i].frames,source[i].frames,'Frame count changed: '+source[i].name);
 assert.deepEqual(release[i].labels,source[i].labels,'Frame labels changed: '+source[i].name);
}
console.log('All 35 weapon symbols retain original local bounds, frame counts and labels.');
