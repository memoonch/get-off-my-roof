package com.getoffmyroof.weapons.projectile
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.particleEffects.WaterExplosionEffect;
   import com.getoffmyroof.particleEffects.WaterExplosionEffectParams;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.weapons.projectile.Projectile;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   
   public class WaterBalloonProjectile extends Projectile
   {
      
      private var m_displayManager:DisplayManager;
      
      public function WaterBalloonProjectile(param1:ProjectileParams)
      {
         super(param1);
         this.m_displayManager = GameComponents.instance.getDisplayManager();
      }
      
      override public function dispose() : void
      {
         var _loc1_:WaterExplosionEffect = new WaterExplosionEffect(new WaterExplosionEffectParams());
         _loc1_.setPosition(currentPos.x,currentPos.y);
         this.m_displayManager.addParticleEffect("ParticleEffectDisplayTop",_loc1_);
         super.dispose();
      }
   }
}

