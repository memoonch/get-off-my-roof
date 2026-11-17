package com.getoffmyroof.particleEffects
{
   import com.getoffmyroof.assets.Assets;
   import com.whatthefawk.particleEffects.ParticleEffect;
   import flash.display.Sprite;
   import flash.geom.Point;
   import org.flintparticles.common.actions.Age;
   import org.flintparticles.common.actions.Fade;
   import org.flintparticles.common.counters.TimePeriod;
   import org.flintparticles.common.initializers.AlphaInit;
   import org.flintparticles.common.initializers.ColorInit;
   import org.flintparticles.common.initializers.Lifetime;
   import org.flintparticles.common.initializers.ScaleImageInit;
   import org.flintparticles.common.initializers.SharedImage;
   import org.flintparticles.twoD.actions.Accelerate;
   import org.flintparticles.twoD.actions.Move;
   import org.flintparticles.twoD.actions.Rotate;
   import org.flintparticles.twoD.emitters.Emitter2D;
   import org.flintparticles.twoD.initializers.Position;
   import org.flintparticles.twoD.initializers.RotateVelocity;
   import org.flintparticles.twoD.initializers.Rotation;
   import org.flintparticles.twoD.initializers.Velocity;
   import org.flintparticles.twoD.zones.DiscZone;
   import org.flintparticles.twoD.zones.RectangleZone;
   
   public class WipeFaceEffect extends ParticleEffect
   {
      
      public function WipeFaceEffect(param1:WipeFaceEffectParams)
      {
         super(param1);
         var _loc2_:Sprite = new Assets.PARTICLE_SPARKLE_1();
         var _loc3_:Emitter2D = new Emitter2D();
         _loc3_.counter = new TimePeriod(35,1);
         _loc3_.addInitializer(new AlphaInit());
         _loc3_.addInitializer(new ColorInit(16777215,8965111));
         _loc3_.addInitializer(new SharedImage(_loc2_));
         _loc3_.addInitializer(new Lifetime(0.1,0.8));
         _loc3_.addInitializer(new Position(new RectangleZone(-14,-70,14,-30)));
         _loc3_.addInitializer(new Velocity(new DiscZone(new Point(),10,1)));
         _loc3_.addInitializer(new Rotation(0,Math.PI * 2));
         _loc3_.addInitializer(new RotateVelocity(0,1));
         _loc3_.addInitializer(new ScaleImageInit(0.1,1));
         _loc3_.addAction(new Age());
         _loc3_.addAction(new Move());
         _loc3_.addAction(new Fade(1,0));
         _loc3_.addAction(new Rotate());
         _loc3_.addAction(new Accelerate(0,20));
         addEmitter(_loc3_);
      }
   }
}

