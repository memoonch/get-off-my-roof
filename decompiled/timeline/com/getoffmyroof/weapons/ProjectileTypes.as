package com.getoffmyroof.weapons
{
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.life.stats.statEffects.OnHitStatEffectParams;
   import com.getoffmyroof.settings.Layers;
   import com.getoffmyroof.weapons.projectile.BoomerangProjectile;
   import com.getoffmyroof.weapons.projectile.BoomerangRenderer;
   import com.getoffmyroof.weapons.projectile.BounceForce;
   import com.getoffmyroof.weapons.projectile.FirecrackerProjectile;
   import com.getoffmyroof.weapons.projectile.PooBombProjectile;
   import com.getoffmyroof.weapons.projectile.PooHomingProjectile;
   import com.getoffmyroof.weapons.projectile.PooProjectile;
   import com.getoffmyroof.weapons.projectile.VinylRecordProjectile;
   import com.getoffmyroof.weapons.projectile.WaterBalloonProjectile;
   import com.getoffmyroof.weapons.projectile.YoYoProjectile;
   import com.getoffmyroof.weapons.projectile.YoYoRenderer;
   import com.urbansquall.ginger.tools.AnimationPlayerFactory;
   import com.whatthefawk.collision.bounds.BounceBoundsBehavior;
   import com.whatthefawk.collision.bounds.BoundsBehaviorParams;
   import com.whatthefawk.collision.bounds.RemoveBoundsBehavior;
   import com.whatthefawk.entity.MovingEntity;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.rendering.BitmapRenderer;
   import com.whatthefawk.rendering.SpriteRenderer;
   import com.whatthefawk.weapons.projectile.Projectile;
   import com.whatthefawk.weapons.projectile.ProjectileParams;
   import com.whatthefawk.weapons.projectile.ProjectileWeaponFactory;
   
   public class ProjectileTypes
   {
      
      public function ProjectileTypes()
      {
         super();
      }
      
      public static function register(param1:ProjectileWeaponFactory, param2:AnimationPlayerFactory = null) : void
      {
         var _loc3_:ProjectileParams = null;
         _loc3_ = new ProjectileParams();
         var _loc4_:Array = [new BounceBoundsBehavior(new BoundsBehaviorParams({
            "checkTop":false,
            "checkLeft":false,
            "checkRight":false
         })),new RemoveBoundsBehavior(new BoundsBehaviorParams({
            "checkTop":false,
            "checkBottom":false
         }))];
         _loc3_.lifeTime = 4000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "RockProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.3,0.3);
         _loc3_.friction = new Vector2D(0.98,0.98);
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         _loc3_.boundsBehaviors = _loc4_;
         _loc3_.customClass = Projectile;
         _loc3_.rendererClass = BitmapRenderer;
         _loc3_.rendererData = {"sprite":new Assets.ROCK_SPRITE()};
         _loc3_.gravity = 35;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         param1.registerProjectile(_loc3_);
         _loc3_ = new ProjectileParams();
         _loc3_.lifeTime = 7000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "TennisBallProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.85,0.85);
         _loc3_.friction = new Vector2D(0.98,0.98);
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         _loc3_.boundsBehaviors = _loc4_;
         _loc3_.customClass = Projectile;
         _loc3_.rendererClass = SpriteRenderer;
         _loc3_.rendererData = {"sprite":Assets.TENNIS_BALL_SPRITE};
         _loc3_.gravity = 35;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         _loc3_.onHitBounceForce = new BounceForce(-400,400,-200,-50);
         param1.registerProjectile(_loc3_);
         _loc3_ = new ProjectileParams();
         _loc3_.lifeTime = 4000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "BaseBallProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.4,0.4);
         _loc3_.friction = new Vector2D(0.98,0.98);
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         _loc3_.boundsBehaviors = _loc4_;
         _loc3_.customClass = Projectile;
         _loc3_.rendererClass = SpriteRenderer;
         _loc3_.rendererData = {"sprite":Assets.BASE_BALL_SPRITE};
         _loc3_.gravity = 35;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":2,
            "scare":1
         });
         _loc3_.onHitBounceForce = new BounceForce(-100,100,0,0);
         param1.registerProjectile(_loc3_);
         _loc3_ = new ProjectileParams();
         _loc3_.lifeTime = 4000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "WaterBalloonProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.3,0.3);
         _loc3_.friction = new Vector2D(0.98,0.98);
         _loc3_.dieOnHit = true;
         _loc3_.explodeOnHit = true;
         _loc3_.explosionType = "WaterBalloonExplosion";
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_REMOVE;
         _loc3_.boundsBehaviors = [new RemoveBoundsBehavior(new BoundsBehaviorParams())];
         _loc3_.customClass = WaterBalloonProjectile;
         _loc3_.rendererClass = BitmapRenderer;
         _loc3_.rendererData = {"sprite":new Assets.WATER_BALLOON_SPRITE()};
         _loc3_.gravity = 35;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1,
            "wetness":5
         });
         _loc3_.onExplodeSoundGroup = "WaterBalloonExplode";
         param1.registerProjectile(_loc3_);
         _loc3_ = new ProjectileParams();
         _loc3_.lifeTime = 4000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "FirecrackerProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.3,0.3);
         _loc3_.friction = new Vector2D(0.98,0.98);
         _loc3_.dieOnHit = true;
         _loc3_.explodeOnHit = true;
         _loc3_.explosionType = "FirecrackerExplosion";
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         _loc3_.boundsBehaviors = _loc4_;
         _loc3_.customClass = FirecrackerProjectile;
         _loc3_.rendererClass = BitmapRenderer;
         _loc3_.rendererData = {"sprite":new Assets.FIRECRACKER_SPRITE()};
         _loc3_.gravity = 35;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":2,
            "scare":1
         });
         _loc3_.onExplodeSoundGroup = "FireCrackerExplode";
         param1.registerProjectile(_loc3_);
         _loc3_ = new ProjectileParams();
         _loc3_.lifeTime = 4000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "VinylRecordProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.3,0.3);
         _loc3_.friction = new Vector2D(0.98,0.98);
         _loc3_.dieOnHit = true;
         _loc3_.explodeOnHit = true;
         _loc3_.explosionType = "VinylRecordExplosion";
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_REMOVE;
         _loc3_.boundsBehaviors = [new RemoveBoundsBehavior(new BoundsBehaviorParams())];
         _loc3_.customClass = VinylRecordProjectile;
         _loc3_.rendererClass = BitmapRenderer;
         _loc3_.rendererData = {"sprite":new Assets.VINYL_RECORD_SPRITE()};
         _loc3_.gravity = 10;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":1,
            "scare":1
         });
         _loc3_.onExplodeSoundGroup = "VinylRecordExplode";
         param1.registerProjectile(_loc3_);
         _loc3_ = new ProjectileParams();
         _loc3_.lifeTime = 4000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "YoYoProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.8,0.8);
         _loc3_.friction = new Vector2D(1,1);
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         _loc3_.boundsBehaviors = [new BounceBoundsBehavior(new BoundsBehaviorParams({
            "checkLeft":false,
            "checkRight":false,
            "checkTop":false
         }))];
         _loc3_.customClass = YoYoProjectile;
         _loc3_.rendererClass = YoYoRenderer;
         _loc3_.rendererData = {"sprite":new Assets.YOYO_SPRITE()};
         _loc3_.gravity = 5;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":2,
            "scare":1
         });
         param1.registerProjectile(_loc3_);
         _loc3_ = new ProjectileParams();
         _loc3_.lifeTime = 4000;
         _loc3_.isCollidable = true;
         _loc3_.isCollidableWithWall = false;
         _loc3_.type = "BoomerangProjectile";
         _loc3_.layer = Layers.PROJECTILE;
         _loc3_.radius = 7;
         _loc3_.bounce = new Vector2D(0.2,0.2);
         _loc3_.friction = new Vector2D(1,1);
         _loc3_.boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         _loc3_.boundsBehaviors = [new BounceBoundsBehavior(new BoundsBehaviorParams())];
         _loc3_.customClass = BoomerangProjectile;
         _loc3_.rendererClass = BoomerangRenderer;
         _loc3_.rendererData = {"sprite":Assets.BOOMERANG_SPRITE};
         _loc3_.gravity = 0;
         _loc3_.onHitStatEffectParams = new OnHitStatEffectParams({
            "damage":2,
            "scare":1
         });
         _loc3_.onHitBounceForce = new BounceForce();
         _loc3_.onFireSoundGroup = "BoomerangThrow";
         param1.registerProjectile(_loc3_);
         var _loc5_:ProjectileParams = new ProjectileParams();
         var _loc6_:Array = [new RemoveBoundsBehavior(new BoundsBehaviorParams({"checkTop":false}))];
         _loc5_.isCollidable = true;
         _loc5_.isCollidableWithWall = false;
         _loc5_.type = "PooProjectile";
         _loc5_.layer = Layers.PROJECTILE;
         _loc5_.radius = 7;
         _loc5_.bounce = new Vector2D(0.4,0.4);
         _loc5_.friction = new Vector2D(1,1);
         _loc5_.dieOnHit = true;
         _loc5_.boundsBehavior = MovingEntity.BOUNDS_REMOVE;
         _loc5_.boundsBehaviors = [new RemoveBoundsBehavior(new BoundsBehaviorParams({
            "checkTop":false,
            "checkLeft":false,
            "checkRight":false
         }))];
         _loc5_.customClass = PooProjectile;
         _loc5_.rendererClass = BitmapRenderer;
         _loc5_.rendererData = {"sprite":new Assets.POO_SPRITE()};
         param1.registerProjectile(_loc5_);
         _loc5_ = new ProjectileParams();
         _loc5_.isCollidable = true;
         _loc5_.isCollidableWithWall = false;
         _loc5_.type = "PooHomingProjectile";
         _loc5_.layer = Layers.PROJECTILE;
         _loc5_.radius = 7;
         _loc5_.bounce = new Vector2D(0.4,0.4);
         _loc5_.friction = new Vector2D(1,1);
         _loc5_.dieOnHit = true;
         _loc5_.boundsBehavior = MovingEntity.BOUNDS_REMOVE;
         _loc5_.boundsBehaviors = _loc6_;
         _loc5_.customClass = PooHomingProjectile;
         _loc5_.rendererClass = BitmapRenderer;
         _loc5_.rendererData = {"sprite":new Assets.POO_SPRITE()};
         param1.registerProjectile(_loc5_);
         _loc5_ = new ProjectileParams();
         _loc5_.isCollidable = true;
         _loc5_.isCollidableWithWall = false;
         _loc5_.type = "PooBombProjectile";
         _loc5_.layer = Layers.PROJECTILE;
         _loc5_.radius = 7;
         _loc5_.bounce = new Vector2D(0.4,0.4);
         _loc5_.friction = new Vector2D(1,1);
         _loc5_.dieOnHit = true;
         _loc5_.explodeOnHit = true;
         _loc5_.explodeOnDispose = false;
         _loc5_.explosionType = "PooBombExplosion";
         _loc5_.boundsBehavior = MovingEntity.BOUNDS_REMOVE;
         _loc5_.boundsBehaviors = _loc6_;
         _loc5_.customClass = PooBombProjectile;
         _loc5_.rendererClass = BitmapRenderer;
         _loc5_.rendererData = {
            "isRadiusVisible":true,
            "isBoundsVisible":true,
            "sprite":new Assets.POO_BOMB_SPRITE()
         };
         _loc5_.onFireSoundGroup = "PooBombFire";
         _loc5_.onExplodeSoundGroup = "PooBombExplosion";
         param1.registerProjectile(_loc5_);
         _loc5_ = new ProjectileParams();
         _loc5_.lifeTime = 4000;
         _loc5_.isCollidable = true;
         _loc5_.isCollidableWithWall = false;
         _loc5_.type = "PooRockProjectile";
         _loc5_.layer = Layers.PROJECTILE;
         _loc5_.radius = 7;
         _loc5_.bounce = new Vector2D(0.2,0.2);
         _loc5_.friction = new Vector2D(0.98,0.98);
         _loc5_.boundsBehavior = MovingEntity.BOUNDS_BOUNCE;
         _loc5_.boundsBehaviors = _loc4_;
         _loc5_.customClass = PooProjectile;
         _loc5_.rendererClass = BitmapRenderer;
         _loc5_.rendererData = {"sprite":new Assets.POO_ROCK_SPRITE()};
         _loc5_.gravity = 10;
         param1.registerProjectile(_loc5_);
      }
   }
}

