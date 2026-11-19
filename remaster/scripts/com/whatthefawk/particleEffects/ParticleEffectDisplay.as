package com.whatthefawk.particleEffects
{
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.GameCamera;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import org.flintparticles.twoD.emitters.Emitter2D;
   
   public class ParticleEffectDisplay extends Entity
   {
      
      public static const GAME_CAMERA_RESIZED:String = "game_camera_resized";
      
      private var m_maxParticles:int;
      
      private var m_gameCamera:GameCamera;
      
      private var m_particleEffects:Array;
      
      private var m_renderer:ParticleRenderer;
      
      private var m_maxParticleEffects:int;
      
      public function ParticleEffectDisplay(param1:ParticleEffectDisplayParams)
      {
         super(param1);
         this.setGameCamera(param1.camera);
         this.m_particleEffects = [];
         this.m_maxParticles = param1.maxParticles;
         this.m_maxParticleEffects = param1.maxParticleEffects;
      }
      
      public function setGameCamera(param1:GameCamera) : void
      {
         this.m_gameCamera = param1;
         var _loc2_:int = this.m_gameCamera ? int(this.m_gameCamera.bounds.width) : 1;
         var _loc3_:int = this.m_gameCamera ? int(this.m_gameCamera.bounds.height) : 1;
         var _loc4_:Rectangle = new Rectangle(0,0,_loc2_,_loc3_);
         this.m_renderer = new ParticleRenderer(_loc4_);
         dispatchEvent(new Event(ParticleEffectDisplay.GAME_CAMERA_RESIZED));
      }
      
      public function get renderer() : ParticleRenderer
      {
         return this.m_renderer;
      }
      
      public function onParticleEffectComplete(param1:Event) : void
      {
         var _loc3_:Emitter2D = null;
         var _loc2_:ParticleEffect = ParticleEffect(param1.target);
         _loc2_.removeEventListener(ParticleEffectEvent.COMPLETE,this.onParticleEffectComplete);
         for each(_loc3_ in _loc2_.emitters)
         {
            // Emitters can finish after a level replay has disposed the renderer.
            if(this.m_renderer != null)this.m_renderer.removeEmitter(_loc3_);
         }
         _loc2_.dispose();
      }
      
      override public function update(param1:int) : void
      {
         var _loc3_:ParticleEffect = null;
         if(!this.m_gameCamera)
         {
            return;
         }
         this.m_renderer.canvas.x = this.m_gameCamera.currentPos.x - this.m_gameCamera.bounds.halfWidth;
         this.m_renderer.canvas.y = this.m_gameCamera.currentPos.y - this.m_gameCamera.bounds.halfHeight;
         var _loc2_:int = int(this.m_particleEffects.length);
         while(--_loc2_ > -1)
         {
            _loc3_ = this.m_particleEffects[_loc2_];
            if(_loc3_.isComplete)
            {
               this.m_particleEffects.splice(_loc2_,1);
            }
            else
            {
               _loc3_.update(param1);
            }
         }
      }
      
      public function addParticleEffect(param1:ParticleEffect, param2:Boolean = true) : void
      {
         var _loc3_:Emitter2D = null;
         if(!this.m_renderer)
         {
            return;
         }
         if(this.m_renderer.emitters.length > this.m_maxParticleEffects)
         {
            return;
         }
         this.m_particleEffects.push(param1);
         param1.addEventListener(ParticleEffectEvent.COMPLETE,this.onParticleEffectComplete,false,0,true);
         for each(_loc3_ in param1.emitters)
         {
            this.m_renderer.addEmitter(_loc3_);
         }
         if(param2)
         {
            param1.start();
         }
      }
      
      override public function dispose() : void
      {
         if(this.m_particleEffects != null)
         {
            for each(var effect:ParticleEffect in this.m_particleEffects)
            {
               effect.removeEventListener(ParticleEffectEvent.COMPLETE,this.onParticleEffectComplete);
               if(this.m_renderer != null && effect.emitters != null)
               {
                  for each(var emitter:Emitter2D in effect.emitters)this.m_renderer.removeEmitter(emitter);
               }
               effect.dispose();
            }
         }
         if(this.m_renderer != null)this.m_renderer.dispose();
         super.dispose();
         this.m_renderer = null;
         this.m_gameCamera = null;
         this.m_particleEffects = null;
      }
   }
}
