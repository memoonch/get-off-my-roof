package com.getoffmyroof.particleEffects
{
   import com.whatthefawk.particleEffects.ParticleEffect;
   import flash.geom.Point;
   import org.flintparticles.common.actions.Age;
   import org.flintparticles.common.counters.Blast;
   import org.flintparticles.common.displayObjects.RadialDot;
   import org.flintparticles.common.initializers.Lifetime;
   import org.flintparticles.common.initializers.ScaleImageInit;
   import org.flintparticles.common.initializers.SharedImage;
   import org.flintparticles.twoD.actions.Accelerate;
   import org.flintparticles.twoD.actions.Move;
   import org.flintparticles.twoD.emitters.Emitter2D;
   import org.flintparticles.twoD.initializers.Velocity;
   import org.flintparticles.twoD.zones.DiscSectorZone;
   
   public class PooSplatterEffect extends ParticleEffect
   {
      
      private static const PI:Number = Math.PI;
      
      private static const POINT:Point = new Point();
      
      private var m_color:uint;
      
      private var m_minSplatterDist:int;
      
      private var m_maxSplatterDist:int;
      
      private var m_numOfSplats:int;
      
      public function PooSplatterEffect(param1:PooSplatterEffectParams)
      {
         super(param1);
         this.m_color = param1.color;
         this.m_numOfSplats = param1.numOfSplats;
         this.m_minSplatterDist = param1.minSplatterDist;
         this.m_maxSplatterDist = param1.maxSplatterDist;
         var _loc2_:Emitter2D = new Emitter2D();
         _loc2_.counter = new Blast(this.m_numOfSplats);
         _loc2_.addInitializer(new Lifetime(0.1,1));
         _loc2_.addInitializer(new ScaleImageInit(0.5,1.5));
         _loc2_.addInitializer(new SharedImage(new RadialDot(2,this.m_color)));
         _loc2_.addInitializer(new Velocity(new DiscSectorZone(POINT,this.m_maxSplatterDist,this.m_minSplatterDist,PI,PI * 2)));
         _loc2_.addAction(new Age());
         _loc2_.addAction(new Move());
         _loc2_.addAction(new Accelerate(0,100));
         addEmitter(_loc2_);
      }
   }
}

