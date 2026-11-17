package com.getoffmyroof.collision
{
   import com.getoffmyroof.entity.Pigeon;
   import com.getoffmyroof.entity.Player;
   import com.getoffmyroof.weapons.projectile.PooProjectile;
   import com.whatthefawk.entity.CollisionResponse;
   import com.whatthefawk.entity.IMessageDispatcher;
   import com.whatthefawk.entity.Wall;
   import com.whatthefawk.weapons.explosion.Explosion;
   import com.whatthefawk.weapons.projectile.Projectile;
   
   public class LocalCollisionResponse extends CollisionResponse
   {
      
      public function LocalCollisionResponse(param1:IMessageDispatcher)
      {
         super(param1);
      }
      
      override public function handleCollision(param1:*, param2:*) : void
      {
         if(param1 is Player && Boolean(param1.isDead))
         {
            return;
         }
         if(param1 is Pigeon && Boolean(param1.isDead))
         {
            return;
         }
         if(param2 is Player && Boolean(param2.isDead))
         {
            return;
         }
         if(param2 is Pigeon && Boolean(param2.isDead))
         {
            return;
         }
         if(param1 is Pigeon && param2 is PooProjectile)
         {
            return;
         }
         if(param1 is PooProjectile && param2 is Pigeon)
         {
            return;
         }
         if(param1 is Pigeon && param2 is Pigeon)
         {
            return;
         }
         if(param1 is Projectile && param2 is Projectile)
         {
            return;
         }
         if(param1 is Projectile && param2 is Wall)
         {
            return;
         }
         if(param1 is Wall && param2 is Projectile)
         {
            return;
         }
         if(param1 is Player && param2 is Player)
         {
            return;
         }
         if(param1 is Player && param2 is Wall)
         {
            return;
         }
         if(param1 is Wall && param2 is Player)
         {
            return;
         }
         if(param1 is Player && param2 is Pigeon)
         {
            return;
         }
         if(param1 is Pigeon && param2 is Player)
         {
            return;
         }
         if(param1 is Explosion && param2 is Explosion)
         {
            return;
         }
         if(param1 is Projectile && param2 is Explosion)
         {
            return;
         }
         if(param1 is Explosion && param2 is Projectile)
         {
            return;
         }
         if(param1 is Explosion && param2 is Wall)
         {
            return;
         }
         if(param1 is Wall && param2 is Explosion)
         {
            return;
         }
         super.handleCollision(param1,param2);
      }
   }
}

