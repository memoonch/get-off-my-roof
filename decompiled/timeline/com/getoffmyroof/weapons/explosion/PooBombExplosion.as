package com.getoffmyroof.weapons.explosion
{
   import com.whatthefawk.weapons.explosion.Explosion;
   import com.whatthefawk.weapons.explosion.ExplosionParams;
   
   public class PooBombExplosion extends Explosion
   {
      
      private var m_explodedInAir:Boolean = false;
      
      public function PooBombExplosion(param1:ExplosionParams)
      {
         super(param1);
      }
      
      override public function explode() : void
      {
         this.m_explodedInAir = newPos.y > 470 ? false : true;
         if(this.m_explodedInAir)
         {
            isCollidable = false;
         }
         super.explode();
      }
      
      public function get explodedInAir() : Boolean
      {
         return this.m_explodedInAir;
      }
   }
}

