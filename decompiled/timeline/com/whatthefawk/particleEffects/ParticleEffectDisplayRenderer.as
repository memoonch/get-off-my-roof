package com.whatthefawk.particleEffects
{
   import com.whatthefawk.entity.GameCamera;
   import com.whatthefawk.rendering.ARenderer;
   import com.whatthefawk.utils.TickRegulator;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   
   public class ParticleEffectDisplayRenderer extends ARenderer
   {
      
      private var m_particleEffectDisplay:ParticleEffectDisplay;
      
      private var m_rendererTickRegulator:TickRegulator;
      
      private var m_rendererTickRate:int = 33;
      
      private var m_renderer:ParticleRenderer;
      
      public function ParticleEffectDisplayRenderer(param1:ParticleEffectDisplay, param2:GameCamera, param3:DisplayObjectContainer, param4:Object)
      {
         super(param1,param2,param3,param4);
         this.m_particleEffectDisplay = param1;
         this.m_renderer = this.m_particleEffectDisplay.renderer;
         this.m_rendererTickRegulator = new TickRegulator(this.m_rendererTickRate);
         this.m_rendererTickRegulator.addEventListener(TickRegulator.TICK,this.onRendererRegulatorTick,false,0,true);
         _container.visible = true;
         _container.addChild(this.m_renderer);
         this.m_particleEffectDisplay.addEventListener(ParticleEffectDisplay.GAME_CAMERA_RESIZED,this.onGameCameraResized,false,0,true);
      }
      
      override public function update(param1:int) : void
      {
         this.m_rendererTickRegulator.update(param1);
      }
      
      override protected function draw() : void
      {
      }
      
      protected function onGameCameraResized(param1:Event) : void
      {
         _container.removeChild(this.m_renderer);
         this.m_renderer = this.m_particleEffectDisplay.renderer;
         _container.addChild(this.m_renderer);
      }
      
      protected function onRendererRegulatorTick(param1:Event) : void
      {
         if(this.m_renderer.hasUpdated)
         {
            this.m_renderer.dispatchEvent(new Event(Event.RENDER));
         }
      }
      
      override protected function updateViewBox() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_particleEffectDisplay = null;
         this.m_renderer = null;
         this.m_rendererTickRegulator.removeEventListener(TickRegulator.TICK,this.onRendererRegulatorTick);
         this.m_rendererTickRegulator = null;
      }
   }
}

