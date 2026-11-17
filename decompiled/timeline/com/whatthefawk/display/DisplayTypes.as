package com.whatthefawk.display
{
   import com.getoffmyroof.settings.Layers;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.particleEffects.ParticleEffectDisplay;
   import com.whatthefawk.particleEffects.ParticleEffectDisplayParams;
   import com.whatthefawk.particleEffects.ParticleEffectDisplayRenderer;
   
   public class DisplayTypes
   {
      
      public function DisplayTypes()
      {
         super();
      }
      
      public static function register(param1:GameFactory) : void
      {
         param1.registerEntity(new ParticleEffectDisplayParams({
            "layer":Layers.PARTICLES_A,
            "type":"ParticleEffectDisplayTop",
            "customClass":ParticleEffectDisplay,
            "rendererClass":ParticleEffectDisplayRenderer
         }));
         param1.registerEntity(new ParticleEffectDisplayParams({
            "layer":Layers.PARTICLES_B,
            "type":"ParticleEffectDisplayBottom",
            "customClass":ParticleEffectDisplay,
            "rendererClass":ParticleEffectDisplayRenderer
         }));
      }
   }
}

