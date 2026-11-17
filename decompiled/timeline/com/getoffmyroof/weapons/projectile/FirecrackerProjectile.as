package com.getoffmyroof.weapons.projectile
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.particleEffects.ExplosionEffect;
   import com.getoffmyroof.particleEffects.ExplosionEffectParams;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.weapons.projectile.Projectile;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   
   public class FirecrackerProjectile extends Projectile
   {
      
      private var m_displayManager:DisplayManager;
      
      public function FirecrackerProjectile(param1:ProjectileParams)
      {
         super(param1);
         this.m_displayManager = GameComponents.instance.getDisplayManager();
      }
      
      override public function dispose() : void
      {
         var _loc1_:ExplosionEffect = new ExplosionEffect(new ExplosionEffectParams());
         _loc1_.setPosition(currentPos.x,currentPos.y);
         this.m_displayManager.addParticleEffect("ParticleEffectDisplayTop",_loc1_);
         super.dispose();
      }
   }
}

