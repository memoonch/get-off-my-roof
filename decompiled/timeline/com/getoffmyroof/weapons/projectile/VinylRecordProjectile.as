package com.getoffmyroof.weapons.projectile
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.particleEffects.VinylRecordExplosionEffect;
   import com.getoffmyroof.particleEffects.VinylRecordExplosionEffectParams;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.weapons.projectile.Projectile;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   
   public class VinylRecordProjectile extends Projectile
   {
      
      private var m_displayManager:DisplayManager;
      
      public function VinylRecordProjectile(param1:ProjectileParams)
      {
         super(param1);
         this.m_displayManager = GameComponents.instance.getDisplayManager();
      }
      
      override public function dispose() : void
      {
         var _loc1_:VinylRecordExplosionEffect = new VinylRecordExplosionEffect(new VinylRecordExplosionEffectParams());
         _loc1_.setPosition(currentPos.x,currentPos.y);
         this.m_displayManager.addParticleEffect("ParticleEffectDisplayTop",_loc1_);
         super.dispose();
      }
   }
}

