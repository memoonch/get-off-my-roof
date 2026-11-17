package com.getoffmyroof.weapons.projectile
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.particleEffects.PooSplatterEffect;
   import com.getoffmyroof.particleEffects.PooSplatterEffectParams;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.weapons.projectile.Projectile;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   
   public class PooProjectile extends Projectile
   {
      
      protected var _displayManager:DisplayManager;
      
      public function PooProjectile(param1:ProjectileParams)
      {
         super(param1);
         this._displayManager = GameComponents.instance.getDisplayManager();
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:PooSplatterEffect = new PooSplatterEffect(new PooSplatterEffectParams({"numOfSplats":Math.random() * 2 + 1}));
         _loc1_.setPosition(currentPos.x,currentPos.y - 10);
         this._displayManager.addParticleEffect("ParticleEffectDisplayTop",_loc1_);
         super.dispose();
      }
   }
}

