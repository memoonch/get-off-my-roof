package com.getoffmyroof.weapons
{
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.getoffmyroof.settings.Layers;
   import com.getoffmyroof.weapons.explosion.PooBombExplosion;
   import com.getoffmyroof.weapons.explosion.PooBombExplosionRenderer;
   import com.urbansquall.ginger.tools.AnimationPlayerFactory;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.rendering.EntityRenderer;
   import com.whatthefawk.weapons.explosion.Explosion;
   import com.whatthefawk.weapons.explosion.ExplosionFactory;
   import com.whatthefawk.weapons.explosion.ExplosionParams;
   
   public class ExplosionTypes
   {
      
      public function ExplosionTypes()
      {
         super();
      }
      
      public static function register(param1:ExplosionFactory, param2:AnimationPlayerFactory = null) : void
      {
         var _loc3_:ExplosionParams = null;
         _loc3_ = new ExplosionParams();
         _loc3_ = new ExplosionParams();
         _loc3_.type = "WaterBalloonExplosion";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 80;
         _loc3_.lifeTime = 1;
         _loc3_.isCollidable = true;
         _loc3_.customClass = Explosion;
         _loc3_.rendererClass = EntityRenderer;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":0,
            "scare":1,
            "wetness":3
         });
         param1.registerExplosion(_loc3_);
         _loc3_ = new ExplosionParams();
         _loc3_.type = "FirecrackerExplosion";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 50;
         _loc3_.lifeTime = 1;
         _loc3_.isCollidable = true;
         _loc3_.customClass = Explosion;
         _loc3_.rendererClass = EntityRenderer;
         _loc3_.rendererData = {
            "isRadiusVisible":true,
            "isBoundsVisible":true
         };
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         param1.registerExplosion(_loc3_);
         _loc3_ = new ExplosionParams();
         _loc3_.type = "VinylRecordExplosion";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 50;
         _loc3_.lifeTime = 1;
         _loc3_.isCollidable = true;
         _loc3_.customClass = Explosion;
         _loc3_.rendererClass = EntityRenderer;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":0,
            "scare":1
         });
         param1.registerExplosion(_loc3_);
         _loc3_ = new ExplosionParams();
         _loc3_.type = "PooBombExplosion";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 50;
         _loc3_.lifeTime = 1000;
         _loc3_.isCollidable = true;
         _loc3_.useHitAreaForCollisions = true;
         _loc3_.hitTime = 800;
         _loc3_.hitAreaRadius = 15;
         _loc3_.hitAreaPosition = new Vector2D(0,-70);
         _loc3_.customClass = PooBombExplosion;
         _loc3_.rendererClass = PooBombExplosionRenderer;
         _loc3_.rendererData.animationPlayer = param2.instantiate("PooExplosionAnimations");
         _loc3_.rendererData.isRadiusVisible = false;
         _loc3_.rendererData.isHitAreaRadiusVisible = false;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         param1.registerExplosion(_loc3_);
      }
   }
}

