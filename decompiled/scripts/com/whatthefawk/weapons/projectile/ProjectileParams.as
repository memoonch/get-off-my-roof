package com.whatthefawk.weapons.projectile
{
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.getoffmyroof.weapons.projectile.BounceForce;
   import com.whatthefawk.entity.MovingEntityParams;
   
   public class ProjectileParams extends MovingEntityParams
   {
      
      public var onHitSoundGroup:String;
      
      public var onFireSoundGroup:String;
      
      public var gravity:int = 0;
      
      public var onExplodeSoundGroup:String;
      
      public var explodeOnHit:Boolean = false;
      
      public var dieOnHit:Boolean = false;
      
      public var explodeOnDispose:Boolean = false;
      
      public var onFireSound:String;
      
      public var canHit:Array = [];
      
      public var onExplodeSound:String;
      
      public var explosionType:String = null;
      
      public var onHitBounceForce:BounceForce = new BounceForce(-300,300,150,200);
      
      public var onHitSound:String;
      
      public var fireParamsClass:Class = ProjectileFireParams;
      
      public var onHitStatEffectParams:OnHitStatEffectParams = null;
      
      public function ProjectileParams(param1:Object = null)
      {
         super(param1);
      }
   }
}

