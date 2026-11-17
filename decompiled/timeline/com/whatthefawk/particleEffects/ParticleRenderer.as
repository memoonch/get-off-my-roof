package com.whatthefawk.particleEffects
{
   import flash.display.BitmapData;
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
               if(_loc2_ == 0)
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
      
      override protected function drawParticle(param1:Particle2D) : void
      {
         var _loc2_:Matrix = null;
         _loc2_ = param1.matrixTransform;
         _loc2_.translate(-_canvas.x,-_canvas.y);
         _bitmapData.draw(param1.image,_loc2_,param1.colorTransform,DisplayObject(param1.image).blendMode,null,_smoothing);
      }
      
      override protected function renderParticles(param1:Array) : void
      {
         var _loc4_:Particle2D = null;
         if(!_bitmap)
         {
            return;
         }
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
         _bitmapData.unlock();
      }
   }
}

