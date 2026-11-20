package com.whatthefawk.particleEffects
{
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.MovieClip;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getDefinitionByName;
   import org.flintparticles.common.displayObjects.RadialDot;
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.engine.GameComponents;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import org.flintparticles.common.emitters.Emitter;
   import org.flintparticles.common.events.EmitterEvent;
   import org.flintparticles.common.events.ParticleEvent;
   import org.flintparticles.common.particles.Particle;
   import org.flintparticles.twoD.particles.Particle2D;
   import org.flintparticles.twoD.renderers.BitmapRenderer;
   
   public class ParticleRenderer extends BitmapRenderer
   {
      
      private static var s_qaLabel:flash.text.TextField;
      private var m_vectorLayer:Sprite;
      private var m_vectorPools:Object = {};
      private var m_vectorUsed:Object = {};
      protected var _hasUpdated:Boolean = false;
      
      protected var _blankBitmap:BitmapData;
      
      protected var _autoUpdate:Boolean = false;
      
      public function ParticleRenderer(param1:Rectangle, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2);
         this._blankBitmap = new BitmapData(param1.width,param1.height,true,16711680);
         this._autoUpdate = param3;
      }
      
      public function get hasUpdated() : Boolean
      {
         return this._hasUpdated;
      }
      
      override protected function updateParticles(param1:Event) : void
      {
         var _loc2_:Array = [];
         var _loc3_:int = int(_emitters.length);
         while(--_loc3_ > -1)
         {
            _loc2_ = _loc2_.concat((_emitters[_loc3_] as Emitter).particles);
         }
         this.renderParticles(_loc2_);
         this._hasUpdated = false;
      }
      
      override protected function emitterUpdated(param1:EmitterEvent) : void
      {
         super.emitterUpdated(param1);
         if(this._autoUpdate)
         {
            this.updateParticles(param1);
         }
         this._hasUpdated = true;
      }
      
      override public function removeEmitter(param1:Emitter) : void
      {
         var _loc4_:Particle = null;
         var _loc2_:int = int(_emitters.length);
         var _loc3_:int = _loc2_;
         while(--_loc3_ > -1)
         {
            if(_emitters[_loc3_] == param1)
            {
               _emitters.splice(_loc3_,1);
               param1.removeEventListener(EmitterEvent.EMITTER_UPDATED,this.emitterUpdated);
               param1.removeEventListener(ParticleEvent.PARTICLE_CREATED,particleAdded);
               param1.removeEventListener(ParticleEvent.PARTICLE_ADDED,particleAdded);
               param1.removeEventListener(ParticleEvent.PARTICLE_DEAD,particleRemoved);
               for each(_loc4_ in param1.particles)
               {
                  removeParticle(_loc4_);
               }
               if(_emitters.length == 0)
               {
                  removeEventListener(Event.RENDER,this.updateParticles);
                  this.renderParticles([]);
               }
               else if(stage)
               {
                  stage.invalidate();
               }
               return;
            }
         }
      }
      
      public function dispose() : void
      {
         while(_emitters.length > 0)this.removeEmitter(_emitters[0]);
         if(this.m_vectorLayer != null && this.m_vectorLayer.parent != null)this.m_vectorLayer.parent.removeChild(this.m_vectorLayer);
         this.m_vectorLayer = null;
         this.m_vectorPools = {};
         this.m_vectorUsed = {};
         removeEventListener(Event.RENDER,this.updateParticles);
         if(_bitmap != null)_bitmap.bitmapData = null;
         if(_bitmapData != null)_bitmapData.dispose();
         if(this._blankBitmap != null)this._blankBitmap.dispose();
         _bitmapData = null;
         this._blankBitmap = null;
      }

      override protected function drawParticle(param1:Particle2D) : void
      {
         var _loc2_:Matrix = null;
         _loc2_ = param1.matrixTransform;
         _loc2_.translate(-_canvas.x,-_canvas.y);
         var imageName:String = getQualifiedClassName(param1.image);
         var isDot:Boolean = imageName == "org.flintparticles.common.displayObjects::RadialDot";
         var isVector:Boolean = isDot || imageName == "particle_pigeon_feather_1" || imageName == "particle_sparkle_1" || imageName == "com.getoffmyroof.assets::Assets_WATER_PARTICLE" || imageName == "com.getoffmyroof.assets::Assets_EXPLOSION_PARTICLE" || imageName == "com.getoffmyroof.assets::Assets_VINYL_RECORD_PARTICLE";
         if(isVector && int(com.whatthefawk.screens.Root.root.loaderInfo.parameters.qaWeapon) != 1)
         {
            if(this.m_vectorLayer == null)
            {
               this.m_vectorLayer = new Sprite();
               this.m_vectorLayer.mouseEnabled = false;
               this.m_vectorLayer.mouseChildren = false;
               this.m_vectorLayer.x = 106.6666667;
               this.m_vectorLayer.scrollRect = new Rectangle(0,0,_canvas.width,_canvas.height);
               GameComponents.instance.getComponent("GameScreen").addChild(this.m_vectorLayer);
            }
            // RadialDot appearance is defined by its original radius/color.
            var sourceDot:RadialDot = isDot ? param1.image as RadialDot : null;
            var poolKey:String = isDot ? imageName + ":" + sourceDot.radius + ":" + sourceDot.color + ":" + sourceDot.blendMode : imageName;
            if(this.m_vectorPools[poolKey] == null)this.m_vectorPools[poolKey] = [];
            var pool:Array = this.m_vectorPools[poolKey];
            var used:int = int(this.m_vectorUsed[poolKey]);
            var art:DisplayObject;
            if(used == pool.length)
            {
               if(isDot)art = new RadialDot(sourceDot.radius,sourceDot.color,sourceDot.blendMode);
               else
               {
                  var artClass:Class = getDefinitionByName(imageName) as Class;
                  art = new artClass() as DisplayObject;
                  if(art is MovieClip)MovieClip(art).gotoAndStop(1);
               }
               art.blendMode = DisplayObject(param1.image).blendMode;
               pool.push(art);
               this.m_vectorLayer.addChild(art);
            }
            art = pool[used] as DisplayObject;
            this.m_vectorUsed[poolKey] = used + 1;
            art.transform.matrix = _loc2_;
            art.transform.colorTransform = param1.colorTransform;
            art.visible = true;
            return;
         }
         _bitmapData.draw(param1.image,_loc2_,param1.colorTransform,DisplayObject(param1.image).blendMode,null,_smoothing);
      }
      
      override protected function renderParticles(param1:Array) : void
      {
         var _loc4_:Particle2D = null;
         if(!_bitmap)
         {
            return;
         }
         for(var vectorKey:String in this.m_vectorPools)this.m_vectorUsed[vectorKey] = 0;
         _bitmapData.lock();
         var _loc2_:int = int(_preFilters.length);
         var _loc3_:int = _loc2_;
         while(--_loc3_ > -1)
         {
            _bitmapData.applyFilter(_bitmapData,_bitmapData.rect,BitmapRenderer.ZERO_POINT,_preFilters[_loc3_]);
         }
         if(_clearBetweenFrames && _loc2_ == 0)
         {
            _bitmapData.copyPixels(this._blankBitmap,this._blankBitmap.rect,BitmapRenderer.ZERO_POINT);
         }
         _loc3_ = int(param1.length);
         if(_loc3_)
         {
            for each(_loc4_ in param1)
            {
               this.drawParticle(_loc4_);
            }
         }
         _loc3_ = int(_postFilters.length);
         while(--_loc3_ > -1)
         {
            _bitmapData.applyFilter(_bitmapData,_bitmapData.rect,BitmapRenderer.ZERO_POINT,_postFilters[_loc3_]);
         }
         if(_colorMap)
         {
            _bitmapData.paletteMap(_bitmapData,_bitmapData.rect,BitmapRenderer.ZERO_POINT,_colorMap[1],_colorMap[2],_colorMap[3],_colorMap[0]);
         }
         for(var key:String in this.m_vectorPools)
         {
            var vectors:Array = this.m_vectorPools[key];
            for(var index:int=int(this.m_vectorUsed[key]);index<vectors.length;index++)vectors[index].visible = false;
         }
         var count:int = 0;
         var records:int = 0;
         var splats:int = 0;
         var sparkles:int = 0;
         var minX:Number = 10000;
         var maxX:Number = -10000;
         for each(var particle:Particle2D in param1)
         {
            var qaKind:String = getQualifiedClassName(particle.image);
            if(qaKind == "com.getoffmyroof.assets::Assets_VINYL_RECORD_PARTICLE" || qaKind == "org.flintparticles.common.displayObjects::RadialDot" || qaKind == "particle_sparkle_1")
            {
               count++;
               if(qaKind == "com.getoffmyroof.assets::Assets_VINYL_RECORD_PARTICLE")records++;
               if(qaKind == "org.flintparticles.common.displayObjects::RadialDot")splats++;
               if(qaKind == "particle_sparkle_1")sparkles++;
               minX = Math.min(minX,particle.x);
               maxX = Math.max(maxX,particle.x);
            }
         }
         if(count > 0)
         {
            if(s_qaLabel == null)
            {
               s_qaLabel = new flash.text.TextField();
               s_qaLabel.defaultTextFormat = new flash.text.TextFormat("_sans",12,0xA5F3B4,true);
               s_qaLabel.width = 730;
               s_qaLabel.height = 22;
               s_qaLabel.x = 8;
               s_qaLabel.y = 34;
               s_qaLabel.background = true;
               s_qaLabel.backgroundColor = 0x161B22;
               com.whatthefawk.screens.Root.stage.addChild(s_qaLabel);
            }
            s_qaLabel.text = (int(com.whatthefawk.screens.Root.root.loaderInfo.parameters.qaWeapon) == 1 ? "ORIGINAL bitmap" : "SHARPER original vectors") + " | live " + count + " | record " + records + " splat " + splats + " wipe " + sparkles;
         }
         _bitmapData.unlock();
      }
   }
}

