package com.getoffmyroof.particleEffects
{
   import com.getoffmyroof.assets.Assets;
   import com.whatthefawk.particleEffects.ParticleEffect;
   import flash.display.Sprite;
   import flash.geom.Point;
   import org.flintparticles.common.actions.Age;
   import org.flintparticles.common.actions.Fade;
   import org.flintparticles.common.counters.Blast;
   import org.flintparticles.common.initializers.AlphaInit;
   import org.flintparticles.common.initializers.Lifetime;
   import org.flintparticles.common.initializers.ScaleImageInit;
   import org.flintparticles.common.initializers.SharedImage;
   import org.flintparticles.twoD.actions.Accelerate;
   import org.flintparticles.twoD.actions.Move;
   import org.flintparticles.twoD.actions.RandomDrift;
   import org.flintparticles.twoD.actions.Rotate;
   import org.flintparticles.twoD.emitters.Emitter2D;
   import org.flintparticles.twoD.initializers.Position;
   import org.flintparticles.twoD.initializers.RotateVelocity;
   import org.flintparticles.twoD.initializers.Rotation;
   import org.flintparticles.twoD.initializers.Velocity;
   import org.flintparticles.twoD.zones.DiscZone;
   import org.flintparticles.twoD.zones.PointZone;
   
   public class ExplosionEffect extends ParticleEffect
   {
      
      private static const PI:Number = Math.PI;
      
      private static const POINT:Point = new Point();
      
      private static const UP_VELOCITY:Point = new Point(0,-200);
      
      private var m_numOfParticles:int;
      
      private var m_gravity:int;
      
      private var m_spread:int;
      
      private var m_maxBlastDist:int;
      
      private var m_drift:Point;
      
      private var m_lifeTime:int;
      
      private var m_minBlastDist:int;
      
      public function ExplosionEffect(param1:ExplosionEffectParams)
      {
         super(param1);
         this.m_numOfParticles = param1.numOfParticles;
         this.m_minBlastDist = param1.minBlastDist;
         this.m_maxBlastDist = param1.maxBlastDist;
         this.m_lifeTime = param1.lifeTime;
         this.m_gravity = param1.gravity;
         this.m_spread = param1.spread;
         this.m_drift = param1.drift;
         var _loc2_:Sprite = new Assets.EXPLOSION_PARTICLE();
         var _loc3_:Emitter2D = new Emitter2D();
         _loc3_.counter = new Blast(this.m_numOfParticles);
         _loc3_.addInitializer(new AlphaInit());
         _loc3_.addInitializer(new SharedImage(_loc2_));
         _loc3_.addInitializer(new Lifetime(0.1,this.m_lifeTime));
         _loc3_.addInitializer(new Position(new PointZone(POINT)));
         _loc3_.addInitializer(new Velocity(new PointZone(UP_VELOCITY)));
         _loc3_.addInitializer(new Velocity(new DiscZone(POINT,this.m_maxBlastDist,this.m_minBlastDist)));
         _loc3_.addInitializer(new Rotation(0,PI * 2));
         _loc3_.addInitializer(new RotateVelocity(1,3));
         _loc3_.addInitializer(new ScaleImageInit(0.5,1.5));
         _loc3_.addAction(new Age());
         _loc3_.addAction(new Move());
         _loc3_.addAction(new Fade(1,0));
         _loc3_.addAction(new Rotate());
         _loc3_.addAction(new Accelerate(0,this.m_gravity));
         _loc3_.addAction(new RandomDrift(this.m_drift.x,this.m_drift.y));
         addEmitter(_loc3_);
      }
   }
}

